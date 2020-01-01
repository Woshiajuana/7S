
'use strict';

const { Controller } = require('egg');

module.exports = class HandleController extends Controller {

    static route (app, middleware, controller) {
        app.router.mount('/api/v1/collect/create', controller.create)
            .mount('/api/v1/collect/info', controller.info)
            .mount('/api/v1/collect/list', controller.list)
            .mount('/api/v1/collect/del', controller.del)
        ;
    }



    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/collect/create 创建收藏
     * @apiDescription 创建收藏
     * @apiGroup 收藏
     * @apiParam  {String} [user] 用户 id
     * @apiParam  {String} [photo] 照片
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/collect/create
     */
    async create () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                user: [ 'nonempty' ],
                photo: [ 'nonempty' ],
            });
            ctx.logger.info(`创建收藏：请求参数=> ${JSON.stringify(objParams)} `);
            await service.collectService.create(objParams);
            ctx.logger.info(`创建收藏：返回结果=> 成功`);
            ctx.respSuccess();
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/collect/info 查询收藏
     * @apiDescription 更新收藏
     * @apiGroup 收藏
     * @apiParam  {String} [user] 用户 id
     * @apiParam  {String} [photo] 照片
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/collect/info
     */
    async info () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                user: [ 'nonempty' ],
                photo: [ 'nonempty' ],
            });
            ctx.logger.info(`查询收藏信息：请求参数=> ${JSON.stringify(objParams)} `);
            const data = await service.collectService.findOne(objParams);
            ctx.logger.info(`查询收藏信息：返回结果=> ${JSON.stringify(data)} `);
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/collect/del 删除收藏
     * @apiDescription 删除收藏
     * @apiGroup 收藏
     * @apiParam  {String} [user] 用户 id
     * @apiParam  {String} [photo] 照片
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/collect/del
     */
    async del () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                user: [ 'nonempty' ],
                photo: [ 'nonempty' ],
            });
            ctx.logger.info(`删除收藏信息：请求参数=> ${JSON.stringify(objParams)} `);
            const data = await service.collectService.del(objParams);
            ctx.logger.info(`删除收藏信息：返回结果=> 成功 `);
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/collect/list 查询收藏列表
     * @apiDescription 查询收藏列表
     * @apiGroup APP基础
     * @apiParam  {String} [numIndex] 页数
     * @apiParam  {String} [numSize] 大小
     * @apiParam  {String} [user] 用户 id
     * @apiParam  {String} [photo] 照片
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/collect/list
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
            const data = await service.collectService.list(objParams);
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

};
