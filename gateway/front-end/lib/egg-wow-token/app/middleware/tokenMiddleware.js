
'use strict';

const ms = require('ms');

module.exports = (options = {}) => {
    return async function tokenMiddleware (ctx, next) {
        const {
            logger,
            request,
            query,
            app,
        } = ctx;
        let {
            redis,
        } = app;
        try {
            let { useActive } = Object.assign({}, ctx.app.config.token, options);
            const accessToken = request.headers['access-token']
                || request.body.access_token
                || query.access_token;
            // 没有 accessToken
            if (!accessToken)
                throw 'F40000';
            let token = await ctx.getTokenByAccessToken(accessToken);
            // token
            if (token.isDead) {
                let { message } = token;
                logger.info(`accessToken:【${accessToken}】 即将失效！${message}`);
                await ctx.destructionTokenByAccessToken(accessToken);
                throw { code: 'F40004', msg: message || 'token过期，请重新登录' };
            }
            // 判断是否是同一个客户端
            if (!token.judgeClient()) {
                logger.info(`accessToken: 【${accessToken}】 对应的环境发生变化.`);
                await ctx.destructionTokenByAccessToken(accessToken);
                throw { code: 'F40004', msg: message || 'token无效，请重新登录' };
            }
            ctx.state.token = token;
            await next();
            token = ctx.state.token;
            if (!token) return null;
            await token.save();
        } catch (err) {
            ctx.respError(err);
        }
    };
};
