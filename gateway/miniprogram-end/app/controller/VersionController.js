
'use strict';

const { Controller } = require('egg');

module.exports = class HandleController extends Controller {

    static route (app, middleware, controller) {
        app.router.mount('/api/v1/wx/version/check', controller.check)
        ;

    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/wx/version/check 检测是否有新的版本
     * @apiDescription  Captcha 版本模块
     * @apiGroup  验证码
     * @apiParam  {String} [email] 账号
     * @apiParam  {String} [template] 模板
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/wx/version/check
     * */
    async check () {
        const { ctx, service } = this;
        try {
            let objParams = await ctx.validateBody({
                platform: [ 'nonempty', (v) => ['android', 'iOS'].indexOf(v) > -1 ],
            });
            ctx.logger.info(`发送验证码：请求参数=> ${JSON.stringify(objParams)}`);
            const data = await service.transformService.curl('api/v1/version/check', {
                data: objParams,
            });
            ctx.logger.info(`发送验证码：请求返回=> 发送成功`);
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

};
