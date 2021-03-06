
'use strict';

const { Controller } = require('egg');

module.exports = class HandleController extends Controller {

    static route (app, middleware, controller) {
        app.router.mount('/api/v1/wx/history/list', middleware.tokenMiddleware(), controller.list)
            .mount('/api/v1/wx/history/clear', middleware.tokenMiddleware(), controller.clear)
        ;
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/wx/history/list 查询观看历史列表
     * @apiDescription 查询观看历史列表
     * @apiGroup APP基础
     * @apiParam  {String} [numIndex] 页数
     * @apiParam  {String} [numSize] 大小
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/wx/history/list
     */
    async list () {
        const { ctx, service, app } = this;
        try {
            const objParams = await ctx.validateBody({
                numIndex: [ 'nonempty' ],
                numSize: [ 'nonempty' ],
            });
            const { id } = ctx.state.token;
            const data = await service.transformService.curl('api/v1/history/list', {
                data: { ...objParams, user: id },
            });
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/wx/history/clear 清除观看历史列表
     * @apiDescription 删除观看历史列表
     * @apiGroup APP基础
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/wx/history/clear
     */
    async clear () {
        const { ctx, service, app } = this;
        try {
            const { id: user } = ctx.state.token;
            const data = await service.transformService.curl('api/v1/history/clear', {
                data: { user },
            });
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

};
