
'use strict';

const { Controller } = require('egg');
const path = require('path');
const fs = require('mz/fs');

module.exports = class HandleController extends Controller {

    static route (app, middleware, controller) {
        app.router.mount('/api/v1/app/file/upload', middleware.tokenMiddleware(), controller.upload)
            .mount('/api/v1/app/file/upload-video', middleware.tokenMiddleware(), controller.uploadVideo)
            .mount('/api/v1/app/file/upload-image', middleware.tokenMiddleware(), controller.uploadImage)
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
            let file = ctx.request.files;
            console.log(`ctx.request =>`, ctx.request);
            console.log(`file1 =>`, file);
            let arrFile = await ctx.validateFiles([
                [
                    'nonempty',
                    {
                        rule: (file) => {
                            return file.size < 2 * 1000 * 1000;
                        },
                        prompt: '文件不能超过2M'
                    },
                ]
            ]);
            console.log(`arrFile =>`, arrFile);
            let {
                ip,
                userAgent = {},
            } = ctx;
            console.log(`ip =>`, ip);
            console.log(`userAgent =>`, userAgent);
            let {
                bucket,
                endpoint,
                root,
            } = app.config.oss.client;
            console.log(`bucket =>`, bucket);
            console.log(`endpoint =>`, endpoint);
            console.log(`root =>`, root);
            let {
                id,
            } = ctx.state.token;
            console.log(`id =>`, id);
            let {
                type,
            } = await ctx.validateBody({
                // user: [ 'nonempty' ],
                // ip: [ 'nonempty' ],
                type: [ 'nonempty' ],
                // path: [ 'nonempty' ],
                // base: [ 'nonempty' ],
                // filename: [ 'nonempty' ],
                // device: [ 'nonempty' ],
            });
            console.log(`type =>`, type);
            ctx.respSuccess({

            });
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/app/file/upload 上传视频文件
     * @apiDescription  File 文件模块
     * @apiGroup  文件
     * @apiParam  {String} [account] 账号
     * @apiParam  {String} [password] 密码
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/app/file/upload
     */
    async uploadVideo () {
        const { ctx, service, app } = this;
        try {
            let {
                file,
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

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/app/file/upload 上传视频文件
     * @apiDescription  File 文件模块
     * @apiGroup  文件
     * @apiParam  {String} [account] 账号
     * @apiParam  {String} [password] 密码
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/app/file/upload
     */
    async uploadImage () {
        const { ctx, service, app } = this;
        try {
            let {
                file,
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
