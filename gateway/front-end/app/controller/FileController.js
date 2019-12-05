
'use strict';

const { Controller } = require('egg');
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
            let {
                ip,
                userAgent = {},
            } = ctx;
            let {
                bucket,
                endpoint,
                rootDir,
            } = app.config.oss.client;
            let {
                id,
            } = ctx.state.token;
            let {
                type,
            } = await ctx.validateBody({
                // 类型 [ AVATAR: 头像, VIDEO: 视频,  PHOTO: 照片, COVER: 封面 ]
                type: [ 'nonempty', (v) => ['AVATAR', 'VIDEO', 'PHOTO', 'COVER'].indexOf(v) > -1 ],
            });
            let result;
            let { filepath, filename } = file;
            let strPath = `${rootDir}/${id}/${type}/`;
            let strName = `${moment().format('YYYYMMDDHHmmss')}.${filename.split('.')[1]}`;
            try {
                result = await ctx.oss.put(`${strPath}${strName}`, filepath);
            } catch (e) {
                this.logger.info(`上传OSS失败=> ${result.toString()}`);
            } finally {
                await fs.unlink(filepath);
            }
            if (!result) throw '文件上传失败';
            const {
                _id
            } = await service.transformService.curl('api/v1/file/create', {
                data: {
                    user: id,
                    type,
                    ip,
                    base: `https://${bucket}.${endpoint}/`,
                    path: strPath,
                    filename: strName,
                    device: JSON.stringify(userAgent),
                    source: filename,
                },
            });
            ctx.respSuccess({
                url: `https://${bucket}.${endpoint}/${strPath}${strName}`,
                file: _id,
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
