
'use strict';

module.exports = () => {
    return async function (ctx, next) {
        await next();
        const {
            logger,
            request,
            query,
            app,
            body,
            state,
            service,
            ip = '',
            params = '',
        } = ctx;
        try {
            let {
                method,
                path,
                body: data,
            } = request;
            let {
                id: userId,
            } = state.token || {};
            if (path === '/api/v1/user-info/login' && body && body.data) {
                userId = body.data._id;
            }
            let target = params[0] || '';
            if (target) {
                path = `${path.replace(target, '')}*`;
            }
            let {
                _id: apiId,
            } = await service.apiRouteService.findOne({ path, method }) || {};
            await service.oplogService.create({
                user: userId,
                api: apiId,
                result: { code: body.code, msg: body.msg },
                params: data || {},
                ip,
                target,
            });
        } catch (err) {
            ctx.respError(err);
        }
    }
};
