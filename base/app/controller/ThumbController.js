
'use strict';

const { Controller } = require('egg');

module.exports = class HandleController extends Controller {

    static route (app, middleware, controller) {
        app.router.mount('/api/v1/thumb/create', controller.create)
            .mount('/api/v1/thumb/info', controller.info)
            .mount('/api/v1/thumb/list', controller.list)
            .mount('/api/v1/thumb/del', controller.del)
        ;
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/thumb/create 创建点赞
     * @apiDescription 创建点赞
     * @apiGroup 点赞
     * @apiParam  {String} [user] 用户 id
     * @apiParam  {String} [video] 视频
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/thumb/create
     */
    async create () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                user: [ 'nonempty' ],
                video: [ 'nonempty' ],
            });
            ctx.logger.info(`创建点赞：请求参数=> ${JSON.stringify(objParams)} `);
            await service.thumbService.create(objParams);
            ctx.logger.info(`创建点赞：返回结果=> 成功`);
            ctx.respSuccess();
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/thumb/info 查询点赞
     * @apiDescription 更新点赞
     * @apiGroup 点赞
     * @apiParam  {String} [user] 用户 id
     * @apiParam  {String} [video] 视频
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/thumb/info
     */
    async info () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                user: [ 'nonempty' ],
                video: [ 'nonempty' ],
            });
            ctx.logger.info(`查询点赞信息：请求参数=> ${JSON.stringify(objParams)} `);
            const data = await service.thumbService.findOne(objParams);
            ctx.logger.info(`查询点赞信息：返回结果=> ${JSON.stringify(data)} `);
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/thumb/del 删除点赞
     * @apiDescription 删除点赞
     * @apiGroup 点赞
     * @apiParam  {String} [user] 用户 id
     * @apiParam  {String} [video] 视频
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/thumb/del
     */
    async del () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                user: [ 'nonempty' ],
                video: [ 'nonempty' ],
            });
            ctx.logger.info(`删除点赞信息：请求参数=> ${JSON.stringify(objParams)} `);
            const data = await service.thumbService.del(objParams);
            ctx.logger.info(`删除点赞信息：返回结果=> 成功 `);
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/thumb/list 查询点赞列表
     * @apiDescription 查询点赞列表
     * @apiGroup APP基础
     * @apiParam  {String} [numIndex] 页数
     * @apiParam  {String} [numSize] 大小
     * @apiParam  {String} [user] 用户 id
     * @apiParam  {String} [video] 视频
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/thumb/list
     */
    async list () {
        const { ctx, service, app } = this;
        try {
            const objParams = await ctx.validateBody({
                numIndex: [ 'nonempty' ],
                numSize: [ 'nonempty' ],
                user: [ ],
                video: [ ],
            });
            const data = await service.thumbService.list(objParams);
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

};
