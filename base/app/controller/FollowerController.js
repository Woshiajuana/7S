
'use strict';

const { Controller } = require('egg');

module.exports = class HandleController extends Controller {

    static route (app, middleware, controller) {
        app.router.mount('/api/v1/follower/create', controller.create)
            .mount('/api/v1/follower/info', controller.info)
            .mount('/api/v1/follower/list', controller.list)
            .mount('/api/v1/follower/del', controller.del)
        ;
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/follower/create 创建粉丝
     * @apiDescription 创建粉丝
     * @apiGroup 粉丝
     * @apiParam  {String} [user] 用户 id
     * @apiParam  {String} [follower] 关注
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/follower/create
     */
    async create () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                user: [ 'nonempty' ],
                follower: [ 'nonempty' ],
            });
            ctx.logger.info(`创建粉丝：请求参数=> ${JSON.stringify(objParams)} `);
            const data = await service.followerService.create(objParams);
            ctx.logger.info(`创建粉丝：返回结果=> 成功`);
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/follower/info 查询粉丝
     * @apiDescription 更新粉丝
     * @apiGroup 粉丝
     * @apiParam  {String} [user] 用户 id
     * @apiParam  {String} [follower] 关注
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/follower/info
     */
    async info () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                user: [ 'nonempty' ],
                follower: [ 'nonempty' ],
            });
            ctx.logger.info(`查询粉丝信息：请求参数=> ${JSON.stringify(objParams)} `);
            const data = await service.followerService.findOne(objParams);
            ctx.logger.info(`查询粉丝信息：返回结果=> ${JSON.stringify(data)} `);
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/follower/del 删除粉丝
     * @apiDescription 删除粉丝
     * @apiGroup 粉丝
     * @apiParam  {String} [user] 用户 id
     * @apiParam  {String} [follower] 关注
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/follower/del
     */
    async del () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                user: [ 'nonempty' ],
                follower: [ 'nonempty' ],
            });
            ctx.logger.info(`删除粉丝信息：请求参数=> ${JSON.stringify(objParams)} `);
            const data = await service.followerService.del(objParams);
            ctx.logger.info(`删除粉丝信息：返回结果=> 成功 `);
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/follower/list 查询粉丝列表
     * @apiDescription 查询粉丝列表
     * @apiGroup APP基础
     * @apiParam  {String} [numIndex] 页数
     * @apiParam  {String} [numSize] 大小
     * @apiParam  {String} [user] 用户 id
     * @apiParam  {String} [follower] 粉丝
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/follower/list
     */
    async list () {
        const { ctx, service, app } = this;
        try {
            const objParams = await ctx.validateBody({
                numIndex: [ 'nonempty' ],
                numSize: [ 'nonempty' ],
                user: [ ],
                follower: [ ],
            });
            const data = await service.followerService.list(objParams);
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

};
