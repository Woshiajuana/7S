
'use strict';

const { Controller } = require('egg');

module.exports = class HandleController extends Controller {

    static route (app, middleware, controller) {
        app.router.mount('/api/v1/notice/create', controller.create)
            .mount('/api/v1/notice/info', controller.info)
            .mount('/api/v1/notice/list', controller.list)
            .mount('/api/v1/notice/del', controller.del)
        ;
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/notice/create 创建消息
     * @apiDescription 创建消息
     * @apiGroup 消息
     * @apiParam  {String} [user] 用户 id
     * @apiParam  {String} [title] 消息标题
     * @apiParam  {String} [nature] 消息性质
     * @apiParam  {String} [type] 消息类型
     * @apiParam  {String} [content] 消息内容
     * @apiParam  {String} [push]  推送状态
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/notice/create
     */
    async create () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                user: [ ],
                title: [ 'nonempty' ],
                nature: [ 'nonempty' ],
                type: [ 'nonempty' ],
                content: [ 'nonempty' ],
                push: [ 'nonempty' ],
            });
            ctx.logger.info(`创建消息：请求参数=> ${JSON.stringify(objParams)} `);
            await service.noticeService.create(objParams);
            ctx.logger.info(`创建消息：返回结果=> 成功`);
            ctx.respSuccess();
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/video/update 更新消息
     * @apiDescription 更新消息
     * @apiGroup 消息
     * @apiParam  {String} [id] 消息 id
     * @apiParam  {String} [user] 用户 id
     * @apiParam  {String} [title] 消息标题
     * @apiParam  {String} [nature] 消息性质
     * @apiParam  {String} [type] 消息类型
     * @apiParam  {String} [content] 消息内容
     * @apiParam  {String} [unread] 已读未读
     * @apiParam  {String} [push]  推送状态
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/video/update
     */
    async update () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                id: [ 'nonempty' ],
                user: [],
                video: [],
                title: [],
                nature: [],
                type: [],
                content: [],
                push: [],
            });
            ctx.logger.info(`更新消息信息：请求参数=> ${JSON.stringify(objParams)} `);
            await service.videoService.update(objParams);
            ctx.logger.info(`更新消息信息：返回结果=> 成功 `);
            ctx.respSuccess();
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/notice/info 查询消息
     * @apiDescription 更新消息
     * @apiGroup 消息
     * @apiParam  {String} [id] 消息 id
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/notice/info
     */
    async info () {
        const { ctx, service, app } = this;
        try {
            let {
                id,
            } = await ctx.validateBody({
                id: [ 'nonempty' ],
            });
            ctx.logger.info(`查询消息信息：请求参数=> ${id} `);
            const data = await service.noticeService.findById(id);
            ctx.logger.info(`查询消息信息：返回结果=> ${JSON.stringify(data)} `);
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/notice/del 删除消息
     * @apiDescription 删除消息
     * @apiGroup 消息
     * @apiParam  {String} [id] 消息 id
     * @apiParam  {String} [user] 用户
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/notice/del
     */
    async del () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                id: [ 'nonempty' ],
                user: [ 'nonempty' ],
            });
            ctx.logger.info(`删除消息信息：请求参数=> ${JSON.stringify(objParams)} `);
            const data = await service.noticeService.del(objParams);
            ctx.logger.info(`删除消息信息：返回结果=> 成功 `);
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/notice/list 查询消息列表
     * @apiDescription 查询消息列表
     * @apiGroup APP基础
     * @apiParam  {String} [numIndex] 页数
     * @apiParam  {String} [numSize] 大小
     * @apiParam  {String} [user] 用户
     * @apiParam  {String} [keyword] 标题 / 内容
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/notice/list
     */
    async list () {
        const { ctx, service, app } = this;
        try {
            const objParams = await ctx.validateBody({
                numIndex: [ 'nonempty' ],
                numSize: [ 'nonempty' ],
                user: [],
                nature: [],
                keyword: [],
            });
            const data = await service.noticeService.list(objParams);
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

};
