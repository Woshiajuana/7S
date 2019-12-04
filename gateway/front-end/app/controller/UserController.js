
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
            let {
                account,
                password,
            } = await ctx.validateBody({
                account: [ 'nonempty' ],
                password: [ 'nonempty' ],
            });
            const data = await service.userService.curl('/api/v1/user/info', {
                data: { email: account, password },
            });
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

};
