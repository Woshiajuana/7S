
'use strict';

const { Controller } = require('egg');

module.exports = class HandleController extends Controller {

    static route (app, middleware, controller) {
        app.router.mount('/api/v1/history/create', controller.create)
            .mount('/api/v1/history/list', controller.list)
            .mount('/api/v1/history/clear', controller.clear)
        ;
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/history/create 创建观看历史
     * @apiDescription 创建观看历史
     * @apiGroup 观看历史
     * @apiParam  {String} [user] 用户 id
     * @apiParam  {String} [photo] 照片
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/history/create
     */
    async create () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                user: [ 'nonempty' ],
                photo: [ 'nonempty' ],
            });
            ctx.logger.info(`创建观看历史：请求参数=> ${JSON.stringify(objParams)} `);
            await service.historyService.del(objParams);
            await service.historyService.create(objParams);
            ctx.logger.info(`创建观看历史：返回结果=> 成功`);
            ctx.respSuccess();
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/history/clear 删除观看历史
     * @apiDescription 删除观看历史
     * @apiGroup 观看历史
     * @apiParam  {String} [user] 用户 id
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/history/clear
     */
    async clear () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                user: [ 'nonempty' ],
            });
            ctx.logger.info(`删除观看历史信息：请求参数=> ${JSON.stringify(objParams)} `);
            const data = await service.historyService.del(objParams);
            ctx.logger.info(`删除观看历史信息：返回结果=> 成功 `);
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/history/list 查询观看历史列表
     * @apiDescription 查询观看历史列表
     * @apiGroup APP基础
     * @apiParam  {String} [numIndex] 页数
     * @apiParam  {String} [numSize] 大小
     * @apiParam  {String} [user] 用户 id
     * @apiParam  {String} [photo] 照片
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/history/list
     */
    async list () {
        const { ctx, service, app } = this;
        try {
            const objParams = await ctx.validateBody({
                numIndex: [ 'nonempty' ],
                numSize: [ 'nonempty' ],
                user: [ ],
                photo: [ ],
            });
            const data = await service.historyService.list(objParams);
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

};
