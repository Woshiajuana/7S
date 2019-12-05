
'use strict';

const { Controller } = require('egg');
const path = require('path');
const fs = require('mz/fs');
const moment = require('moment');

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
            let [
                file,
            ] = await ctx.validateFiles([
                [ 'nonempty' ]
            ]);
            console.log(`file =>`, file);
            let {
                ip,
                userAgent = {},
            } = ctx;
            console.log(`ip =>`, ip);
            console.log(`userAgent =>`, userAgent);
            let {
                bucket,
                endpoint,
                rootDir,
            } = app.config.oss.client;
            console.log(`bucket =>`, bucket);
            console.log(`endpoint =>`, endpoint);
            console.log(`rootDir =>`, rootDir);

            // user: [ 'nonempty' ],
            //     ip: [ 'nonempty' ],
            //     type: [ 'nonempty' ],
            //     path: [ 'nonempty' ],
            //     base: [ 'nonempty' ],
            //     filename: [ 'nonempty' ],
            //     device: [ 'nonempty' ],
            let {
                id,
            } = ctx.state.token;
            console.log(`id =>`, id);
            let {
                type,
            } = await ctx.validateBody({
                type: [ 'nonempty' ],
            });
            let result;
            let { filepath, filename } = file;
            let strPath = `${rootDir}/${id}/${type}`;
            let strName = `${moment().format('YYYYMMDDHHmmss')}.${filename.split('.')[1]}`;
            try {
                result = await ctx.oss.put(`${strPath}/${strName}`, filepath);
            } catch (e) {
                console.log('上出出错啦');
                console.log(e);
            } finally {
                await fs.unlink(filepath);
            }
            if (!result) throw '文件上传失败';
            // const data = await service.transformService.curl('api/v1/file/create', {
            //     data: { user: id, },
            // });
            console.log(`type =>`, type);
            ctx.respSuccess({
                path: `https://${bucket}.${endpoint}/${strPath}/${strName}`,
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
