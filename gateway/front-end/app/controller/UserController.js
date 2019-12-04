
'use strict';

const { Controller } = require('egg');

module.exports = class HandleController extends Controller {

    static route (app, middleware, controller) {
        app.router.mount('/api/app/user/login', controller.login)
        ;

    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/app/user/login 用户登录
     * @apiDescription  User 用户模块
     * @apiGroup 用户
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/app/user/login
     */
    async login () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                email: [ 'nonempty' ],
                password: [ 'nonempty' ],
            });
            await service.userService.create(objParams);
            ctx.respSuccess();

            const {
                params,
                method = '',
                query = '',
                body = '',
            } = ctx;
            const strTargetUrl = params[0] || '';
            const data = await service.userService.curl(strTargetUrl, {
                method,
                data: method === 'get' ? query : body,
            });
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

};
