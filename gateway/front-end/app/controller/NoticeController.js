
'use strict';

const { Controller } = require('egg');

module.exports = class HandleController extends Controller {

    static route (app, middleware, controller) {
        app.router.mount('/api/v1/app/notice/list', middleware.tokenMiddleware(), controller.list)
            .mount('/api/v1/app/notice/info', middleware.tokenMiddleware(), controller.info)
        ;
    }


    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/app/notice/list 消息列表
     * @apiDescription  通讯消息模块
     * @apiGroup  文件
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/app/notice/list
     */
    async list () {
        const { ctx, service, app } = this;
        try {
            let {
                type,
            } = await ctx.validateBody({
                // 类型 [ AVATAR: 头像, VIDEO: 视频,  PHOTO: 照片, COVER: 封面 ]
                type: [ 'nonempty', (v) => ['AVATAR', 'VIDEO', 'PHOTO', 'COVER'].indexOf(v) > -1 ],
            });
            ctx.respSuccess();
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/app/notice/info 消息详情
     * @apiDescription  通讯消息模块
     * @apiGroup  文件
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/app/notice/info
     */
    async info () {
        const { ctx, service, app } = this;
        try {
            let {
                type,
            } = await ctx.validateBody({
                // 类型 [ AVATAR: 头像, VIDEO: 视频,  PHOTO: 照片, COVER: 封面 ]
                type: [ 'nonempty', (v) => ['AVATAR', 'VIDEO', 'PHOTO', 'COVER'].indexOf(v) > -1 ],
            });
            ctx.respSuccess();
        } catch (err) {
            ctx.respError(err);
        }
    }

};
