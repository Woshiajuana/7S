
'use strict';

module.exports = () => {
    return async function (ctx, next) {
        const {
            logger,
            request,
            query,
            app,
        } = ctx;
        try {
            let {
                method,
                path,
            } = request;
            const {
                accessToken,
                user = {},
            } = ctx.state.token;
            const {
                group,
                is_root,
                disabled,
                lock,
                _id
            } = user;
            if (disabled) {
                logger.info(`用户:【${_id}】被禁用`);
                await ctx.destructionTokenByAccessToken(accessToken);
                ctx.state.token = '';
                throw 'F40005'
            }
            if (lock) {
                logger.info(`用户:【${_id}】被锁定`);
                await ctx.destructionTokenByAccessToken(accessToken);
                ctx.state.token = '';
                throw 'F40006'
            }
            const {
                is_root_group,
                api_routes,
            } = group || {};
            if (is_root || is_root_group || checkApiRoutes(path, method, api_routes)) {
                logger.info(`用户:【${_id}】权限API:【${path}】验证通过`);
                await next();
            } else {
                logger.info(`用户:【${_id}】权限API:【${path}】验证失败`);
                throw 'F40003';
            }
        } catch (err) {
            ctx.respError(err);
        }
    }
};

function checkApiRoutes (path, method, routes) {
    return routes.filter((item) => item.path === path && item.method === method).length > 0;
}
