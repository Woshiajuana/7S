
'use strict';

const { Controller } = require('egg');

module.exports = class HandleController extends Controller {

    static route (app, middleware, controller) {
        app.router.mount('/api/v1/app/photo/list', middleware.tokenMiddleware(), controller.list)
        ;
    }


    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/app/photo/list 照片列表
     * @apiDescription  照片模块
     * @apiGroup  文件
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/app/photo/list
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

};
