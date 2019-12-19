
'use strict';

const { Controller } = require('egg');

module.exports = class HandleController extends Controller {

    static route (app, middleware, controller) {
        app.router.mount('/api/v1/following/create', controller.create)
            .mount('/api/v1/following/info', controller.info)
            .mount('/api/v1/following/list', controller.list)
            .mount('/api/v1/following/del', controller.del)
        ;
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/following/create 创建关注
     * @apiDescription 创建关注
     * @apiGroup 关注
     * @apiParam  {String} [user] 用户 id
     * @apiParam  {String} [following] 粉丝
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/following/create
     */
    async create () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                user: [ 'nonempty' ],
                following: [ 'nonempty' ],
            });
            ctx.logger.info(`创建关注：请求参数=> ${JSON.stringify(objParams)} `);
            const data = await service.followingService.create(objParams);
            ctx.logger.info(`创建关注：返回结果=> 成功`);
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/following/info 查询关注
     * @apiDescription 更新关注
     * @apiGroup 关注
     * @apiParam  {String} [user] 用户 id
     * @apiParam  {String} [following] 关注
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/following/info
     */
    async info () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                user: [ 'nonempty' ],
                following: [ 'nonempty' ],
            });
            ctx.logger.info(`查询关注信息：请求参数=> ${JSON.stringify(objParams)} `);
            const data = await service.followingService.findOne(objParams);
            ctx.logger.info(`查询关注信息：返回结果=> ${JSON.stringify(data)} `);
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/following/del 删除关注
     * @apiDescription 删除关注
     * @apiGroup 关注
     * @apiParam  {String} [user] 用户 id
     * @apiParam  {String} [following] 关注
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/following/del
     */
    async del () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                user: [ 'nonempty' ],
                following: [ 'nonempty' ],
            });
            ctx.logger.info(`删除关注信息：请求参数=> ${JSON.stringify(objParams)} `);
            const data = await service.followingService.del(objParams);
            ctx.logger.info(`删除关注信息：返回结果=> 成功 `);
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/following/list 查询关注列表
     * @apiDescription 查询关注列表
     * @apiGroup APP基础
     * @apiParam  {String} [numIndex] 页数
     * @apiParam  {String} [numSize] 大小
     * @apiParam  {String} [user] 用户 id
     * @apiParam  {String} [following] 关注
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/following/list
     */
    async list () {
        const { ctx, service, app } = this;
        try {
            const objParams = await ctx.validateBody({
                numIndex: [ 'nonempty' ],
                numSize: [ 'nonempty' ],
                user: [ ],
                following: [ ],
            });
            const data = await service.followingService.list(objParams);
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

};
