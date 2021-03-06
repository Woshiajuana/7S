
'use strict';

const { Controller } = require('egg');

module.exports = class HandleController extends Controller {

    static route (app, middleware, controller) {
        app.router.mount('/api/v1/wx/dislike/do', middleware.tokenMiddleware(), controller.do)
            .mount('/api/v1/wx/dislike/list', middleware.tokenMiddleware(), controller.list)
        ;
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/dislike/do 不喜欢 or 取消
     * @apiDescription 不喜欢 or 取消
     * @apiGroup 不喜欢
     * @apiParam  {String} [photo] 照片
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/dislike/do
     */
    async do () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                photo: [ 'nonempty' ],
            });
            ctx.logger.info(`创建不喜欢：请求参数=> ${JSON.stringify(objParams)} `);
            const { id: user } = ctx.state.token;
            let data = await service.transformService.curl('api/v1/dislike/info', {
                data: { ...objParams, user },
            });
            if (data) {
                // 取消
                await service.transformService.curl('api/v1/dislike/del', {
                    data: { ...objParams, user },
                });
                data = '';
            } else {
                // 创建
                data = await service.transformService.curl('api/v1/dislike/create', {
                    data: { ...objParams, user },
                });
            }
            ctx.logger.info(`创建不喜欢：返回结果=> 成功`);
            ctx.respSuccess(data ? data._id : '');
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/wx/dislike/list 查询不喜欢
     * @apiDescription 更新不喜欢
     * @apiGroup 不喜欢
     * @apiParam  {String} [numIndex] 页数
     * @apiParam  {String} [numSize] 大小
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/wx/dislike/list
     */
    async list () {
        const { ctx, service, app } = this;
        try {
            const objParams = await ctx.validateBody({
                numIndex: [ 'nonempty' ],
                numSize: [ 'nonempty' ],
            });
            const { id } = ctx.state.token;
            const data = await service.transformService.curl('api/v1/dislike/list', {
                data: { ...objParams, user: id },
            });
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

};
