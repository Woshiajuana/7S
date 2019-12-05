
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
     * @apiDescription  Captcha 验证码模块
     * @apiGroup  验证码
     * @apiParam  {String} [email] 账号
     * @apiParam  {String} [template] 模板
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/app/captcha/send
     * */
    async send () {
        const { ctx, service } = this;
        try {
            let objParams = await ctx.validateBody({
                email: [ 'nonempty' ],
                template: [ 'nonempty' ],
            });
            ctx.logger.info(`发送验证码：请求参数=> ${JSON.stringify(objParams)}`);
            await service.emailService.sendCaptcha(objParams);
            ctx.logger.info(`发送验证码：请求返回=> 发送成功`);
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

};
