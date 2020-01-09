
'use strict';

const { Service } = require('egg');
const { populate, select } = require('../../model/UserInfoModel');
const ms = require('ms');

module.exports = class HandleServer extends Service {

    // 创建管理用户
    async create (data) {
        const { ctx } = this;
        await ctx.model.UserInfoModel.create(data);
    }

    // 登录查询
    async auth ({ account, password, captcha }) {
        const { app, logger } = this;
        const { redis } = app;
        const { maxTimes, capTimes } = app.config.auth;
        let objUser = await this.findOne({ nickname: account }, ' password');
        if (!objUser)
            objUser = await this.findOne({ phone: account }, ' password');
        if (!objUser)
            objUser = await this.findOne({ email: account }, ' password');
        if (!objUser) {
            logger.info(`账号:【${account}】不存在`);
            throw '用户账号不存在或密码错误';
        }
        let { _id, password: pwd, disabled, lock } = objUser;
        if (disabled) {
            logger.info(`账号:【${account}】已禁用`);
            throw 'F40005';
        }
        if (lock) {
            logger.info(`账号:【${account}】已锁定`);
            throw 'F40006';
        }
        let times = await redis.get(`${_id} auth password times`) || 0;
        times = +times;
        if (password !== pwd) {
            times++;
            if (times >= maxTimes) {
                await this.unlock({ id: _id, lock: true }, true);
                logger.info(`账号:【${account}】密码输入超过最大错误次数:【${maxTimes}】已锁定`);
                await redis.del(`${_id} auth password times`);
                throw 'F40006';
            }
            await redis.set(`${_id} auth password times`, times);
            logger.info(`账号:【${account}】密码输入错误 还有${maxTimes - times}次机会`);
            throw `密码输入错误，您还有${maxTimes - times}次机会`;
        }
        if (times) await redis.del(`${_id} auth password times`);
        delete objUser.password;
        return objUser;
    }

    // 生成 token
    async token (objUser) {
        const { ctx, app, config } = this;
        const { _id } = objUser;
        const { accessToken } = await ctx.generateToken({ id: _id, user: objUser });
        objUser.access_token = accessToken;
        await ctx.kickOutUserById(_id);
        return objUser;
    }

    // 安全退出
    async logout () {
        const { ctx, app } = this;
        const { accessToken } = ctx.state.token || {};
        if (!accessToken) return null;
        await ctx.destructionTokenByAccessToken(accessToken);
    }

    // 查询用户信息
    async findOne (data, s = '') {
        const { ctx } = this;
        return await ctx.model.UserInfoModel
            .findOne(data)
            .select(select + s)
            .populate(populate)
            .lean();
    }

    // 根据 id 查询用户信息
    async findById (id) {
        const { ctx } = this;
        return await ctx.model.UserInfoModel
            .findById(id)
            .select(select)
            .populate(populate)
            .lean();
    }

    // 用户列表
    async list ({ numIndex, numSize, group, keyword }) {
        const { ctx, app } = this;
        if (numIndex && numSize) {
            let filter = {
                $or: [], // 多字段同时匹配
            };
            if (keyword) {
                filter.$or.push({ nickname: { $regex: keyword, $options: '$i', } });
                filter.$or.push({ phone: { $regex: keyword, $options: '$i', } });
                filter.$or.push({ email: { $regex: keyword, $options: '$i', } });
            }
            if (group) {
                group = app.mongoose.Types.ObjectId(group);
                filter.$or.push({ group: group });
            }
            if (!filter.$or.length) delete filter.$or;
            const numTotal = await ctx.model.UserInfoModel.count(filter);
            const arrData = await ctx.model.UserInfoModel
                .find(filter)
                .sort('-created_at')
                .skip((numIndex - 1) * numSize)
                .limit(numSize)
                .select(select)
                .populate(populate)
                .lean();
            return {
                numTotal,
                numIndex,
                numSize,
                arrData,
            }
        } else {
            const arrData = await ctx.model.UserInfoModel
                .find().sort('-created_at').select(select).lean();
            return arrData;
        }

    }

    // 删除
    async del (id) {
        const { ctx, app, logger } = this;
        const { is_root } = await this.findById(id);
        if (is_root) {
            logger.info(`拒绝删除 root 账号`);
            throw '不能删除 root 账号';
        }
        logger.info(`删除账号:【${id}】`);
        await ctx.model.UserInfoModel.remove({ _id: app.mongoose.Types.ObjectId(id) });
    }

    // 更新
    async update (data, type) {
        const { ctx, app, logger } = this;
        const { id } = data;
        const { is_root } = await this.findById(id);
        if (!type && is_root) {
            logger.info(`拒绝更新 root 账号`);
            throw '不能更新 root 账号';
        }
        logger.info(`更新账号:【${id}】`);
        delete data.id;
        return await ctx.model.UserInfoModel.findByIdAndUpdate({ _id: app.mongoose.Types.ObjectId(id) }, data, { new: true })
            .select(select)
            .populate(populate)
            .lean();
    }

    // 锁定 or 解锁
    async unlock (data, type = false) {
        const { ctx, app, logger } = this;
        const { id, lock } = data;
        const { redis } = app;
        await this.update(data, type);
        const arrToken = await ctx.getTokenByUserId(id);
        await redis.del(`${id} auth password times`);
        arrToken.forEach(async (token) => {
            if (token.user.lock !== lock) {
                token.maxAge = ms('5m');
                token.user.lock = lock;
                await token.save();
            }
        });
        logger.info(`${lock ? '锁定' : '解锁'}账号:【${id}】`);
    }

    // 禁用 or 启用
    async disableEnable (data) {
        const { ctx, app, logger } = this;
        const { id, disabled } = data;
        await this.update(data);
        const arrToken = await ctx.getTokenByUserId(id);
        arrToken.forEach(async (token) => {
            if (token.user.disabled !== disabled) {
                token.maxAge = ms('5m');
                token.user.disabled = disabled;
                await token.save();
            }
        });
        logger.info(`管理员:【${ctx.state.token.user._id}】${disabled ? '禁用' : '启用'}账号:【${id}】`);
    }
};
