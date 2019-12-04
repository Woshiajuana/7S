
'use strict';

const { CurlService } = require('egg');

module.exports = class TransFormService extends CurlService {

    constructor (ctx) {
        super(ctx);
    }

    async afterRequest (response) {
        let {
            status,
            statusMessage,
            data,
        } = response;
        const strErrMsg = data.msg || data.message || statusMessage;
        if (status >= 300 || status < 200 || data.code !== 'S00000')
            throw `[${status}]：${strErrMsg}`;
        return response.data ? response.data.data : response;
    }

    async beforeRequest (options) {
        return options;
    }


    // 验证账号
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

};
