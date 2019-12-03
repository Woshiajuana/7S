
'use strict';

const { Controller } = require('egg');

module.exports = class HandleController extends Controller {

    static route (app, middleware, controller) {
        app.router.mount('/api/v1/user/create', controller.create),
        app.router.mount('/api/v1/user/update', controller.update)
        ;
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/user/create 创建用户
     * @apiDescription 创建用户
     * @apiGroup 用户
     * @apiParam  {String} [email] 邮箱
     * @apiParam  {String} [password] 密码
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/user/create
     */
    async create () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                email: [ 'nonempty' ],
                password: [ 'nonempty' ],
            });
            await service.userService.create(objParams);
            ctx.respSuccess();
        } catch (err) {
            ctx.respError(err);
        }
    }




};
