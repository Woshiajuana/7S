
'use strict';

const { Controller } = require('egg');

module.exports = class HandleController extends Controller {

    static route (app, middleware, controller) {
        app.router.mount('/api/v1/app/file/upload', middleware.tokenMiddleware(), controller.upload)
        ;

    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/app/file/upload 上传文件
     * @apiDescription  File 文件模块
     * @apiGroup  文件
     * @apiParam  {String} [account] 账号
     * @apiParam  {String} [password] 密码
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/app/file/upload
     */
    async upload () {
        const { ctx, service, app } = this;
        try {
            let {
                account,
                password,
                captcha,
            } = await ctx.validateBody({
                account: [ 'nonempty' ],
                password: [ 'nonempty' ],
                captcha: [ ],
            });

            ctx.respSuccess();
        } catch (err) {
            ctx.respError(err);
        }
    }

};
