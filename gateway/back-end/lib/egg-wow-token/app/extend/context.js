'use strict';

const jwt = require('jsonwebtoken');
const ms = require('ms');
const moment = require('moment');

class Token {
    constructor(ctx, props = {}, options) {
        this.ctx = ctx;
        for (let key in props) {
            this[key] = props[key];
        }
        this.options = options;
        // id
        if (!this.id) {
            throw new Error('Token id is empty!');
        }
        // 客户端信息
        if (!this.client) {
            this.client = this.options.getClientInfo(this.ctx);
        }
        const timeStamp = new Date().getTime();
        // 创建时间
        if (!this.createAt) {
            this.createAt = timeStamp;
        }
        // 更新时间
        if (!this.updateAt) {
            this.updateAt = timeStamp;
        }
        if (!props.hasOwnProperty('isDead')) {
            this.isDead = false;
        }
        // token
        if (!this.accessToken) {
            this.accessToken = `acst:${this.id}:${jwt.sign({ id: this.id, createAt: this.createAt }, this.options.secret, this.options.jwtOption || {})}`;
        }
    }

    // 判断是不是同一台设备
    judgeClient () {
        const { logger } = this.ctx;
        const strNowClient = this.options.getClientInfo(this.ctx);
        const result = this.client === strNowClient;
        logger.info(`用户:【${this.id}】登录客户端:【${this.client}】与请求客户端【${strNowClient}】${result ? '一致' : '不一致'}`);
        return result;
    }

    // toJSON
    toJSON () {
        const obj = {};
        Object.keys(this).forEach(key => {
            if (typeof key !== 'string') return;
            if (key[0] === '_') return;
            if (key === 'ctx') return;
            if (this[key] === undefined) return;
            obj[key] = this[key];
        });
        return obj;
    }

    // 保存
    async save () {
        const { logger } = this.ctx;
        const { redis } = this.ctx.app;
        logger.info(`redis 创建用户: 【${this.id}】, 数据 accessToken:【${this.accessToken}】 有效期:【${this.options.maxAge}】`);
        await redis.set(this.accessToken, JSON.stringify(this.toJSON()), 'PX', ms(this.options.maxAge));
    }

    // 更新时间
    async active () {
        const { redis } = this.ctx.app;
        await redis.expire(this.accessToken, ms(this.options.maxAge) * 0.001);
    }
}

module.exports = {

    // 生成 token
    async generateToken (data, options) {
        const { app, logger } = this;
        const token = new Token(this, data, Object.assign({}, app.config.token, options));
        await token.save();
        return token;
    },

    // 根据 accessToken 获取
    async getTokenByAccessToken (accessToken) {
        const { app, logger } = this;
        const { redis } = app;
        const strToken = await redis.get(accessToken);
        if (!strToken) {
            logger.info(`redis 获取 accessData 数据 accessToken: ${accessToken} 失败 不存在!`);
            throw `F40001`;
        }
        let objToken = null;
        try {
            objToken = JSON.parse(strToken);
        } catch (err) {
            logger.info(`accessData:${ accessToken } 数据解析错误: ${err.message} ${strToken}`);
            throw `F40001`;
        }
        if (!objToken) {
            logger.info(`redis 获取 accessToken: ${accessToken} 为空！`);
            throw `F40002`;
        }
        return new Token(this, objToken, Object.assign({}, app.config.token, objToken.options));
    },

    // 判断是否要销毁
    async destructionTokenByAccessToken (accessToken) {
        const { app, logger } = this;
        const { redis } = app;
        await redis.del(accessToken);
        logger.info(`accessToken: 【${accessToken}】即将删除`);
    },

    // 查找所有的token
    async getTokenByUserId (id) {
        const { app } = this;
        const { redis } = app;
        const result = [];
        let keys = await redis.keys(`acst:${id}:*`);
        if (!keys || !keys.length) return result;
        for(let i = 0 ; i < keys.length; i++) {
            const accessData = await this.getTokenByAccessToken(keys[i]);
            if (accessData) {
                result.push(accessData)
            }
        }
        return result;
    },

    // 登录踢出
    async kickOutUserById (id, options = {}) {
        const { app, logger } = this;
        let { maxUser } = Object.assign({}, app.config.token, options);
        if (maxUser <= 0) return;
        let arrOtherToken = await this.getTokenByUserId(id) || [];
        arrOtherToken.sort((a, b) => a.createAt - b.createAt);
        const arrNeedKickOut = arrOtherToken.slice(0, arrOtherToken.length - maxUser);
        arrNeedKickOut.forEach(async (token, index) => {
            if (!token.isDead) {
                token.isDead = true;
                token.maxAge = ms(`5m`);
                token.message = `您的账号于：${moment().format('YYYY-MM-DD HH:mm:ss')} 在客户端：${this.ip} ${this.userAgent ? this.userAgent.ua : ''} 上登录，如果不是您本人操作，请立马更改密码！`;
                await token.save();
                logger.info(`预踢掉在线用户:【${token.id}】token:【${token.accessToken}】.`);
            }
        });
    },
};

