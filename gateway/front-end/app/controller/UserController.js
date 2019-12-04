
'use strict';

const { Controller } = require('egg');

module.exports = class HandleController extends Controller {

    static route (app, middleware, controller) {
        app.router.mount('/api/v1/app/user/login', controller.login)
            .mount('/api/v1/app/user/register', controller.register)
        ;

    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/app/user/login 用户登录
     * @apiDescription  User 用户模块
     * @apiGroup 用户
     * @apiParam  {String} [account] 账号
     * @apiParam  {String} [password] 密码
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

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/app/user/register 用户注册
     * @apiDescription  User 用户模块
     * @apiGroup 用户
     * @apiParam  {String} [email] 账号
     * @apiParam  {String} [password] 密码
     * @apiParam  {String} [code] 验证码
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/app/user/register
     * */
    async register () {
        const { ctx, service, app } = this;
        try {
            let {
                email,
                password,
            } = await ctx.validateBody({
                email: [ 'nonempty' ],
                password: [ 'nonempty' ],
                code: [ ],
            });
            const data = await service.userService.curl('api/v1/user/info', {
                data: { email },
            });
            if (data) throw '该邮箱已注册';
            await service.userService.curl('api/v1/user/create', {
                data: { email, password },
            });
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }



};
