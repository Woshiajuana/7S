
'use strict';

const { Controller } = require('egg');

module.exports = class HandleController extends Controller {

    static route (app, middleware, controller) {
        app.router.mount('/api/v1/app/captcha/send', controller.send)
        ;

    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/app/captcha/send 发送验证码
     * @apiDescription  User 用户模块
     * @apiGroup  验证码
     * @apiParam  {String} [email] 账号
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/app/captcha/send
     * */
    async send () {
        const { ctx, service } = this;
        try {
            let {
                email,
            } = await ctx.validateBody({
                email: [ 'nonempty' ],
            });
            ctx.logger.info(`用户注册，查询邮箱是否已注册：请求参数=> ${email}`);
            const data = await service.userService.curl('api/v1/user/one', {
                data: { email },
            });
            if (data) {
                ctx.logger.info(`用户注册，查询邮箱是否已注册：请求结果=> 已注册 ${JSON.stringify(data)}`);
                throw '该邮箱已注册';
            }
            ctx.logger.info(`用户注册：请求参数=> ${email}`);
            await service.userService.curl('api/v1/user/create', {
                data: { email, password },
            });
            ctx.logger.info(`用户注册：请求返回=> 注册成功`);
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

};
