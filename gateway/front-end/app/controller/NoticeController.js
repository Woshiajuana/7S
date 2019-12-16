
'use strict';

const { Controller } = require('egg');

module.exports = class HandleController extends Controller {

    static route (app, middleware, controller) {
        app.router.mount('/api/v1/app/notice/list', middleware.tokenMiddleware(), controller.list)
            .mount('/api/v1/app/notice/info', middleware.tokenMiddleware(), controller.info)
            .mount('/api/v1/app/notice/create', controller.create)
        ;
    }


    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/app/notice/list 消息列表
     * @apiDescription  通讯消息模块
     * @apiGroup  文件
     * @apiParam  {String} [numIndex] 页数
     * @apiParam  {String} [numSize] 每页数量
     * @apiParam  {String} [nature]  性质
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/app/notice/list
     */
    async list () {
        const { ctx, service, app } = this;
        try {
            let {
                numIndex,
                numSize,
                nature,
            } = await ctx.validateBody({
                numIndex: [ 'nonempty' ],
                numSize: [ 'nonempty' ],
                nature: [ 'nonempty', (v) => ['PRIVATE', 'PUBLIC'].indexOf(v) > -1 ],
            });
            const { id } = ctx.state.token;
            const data = await service.transformService.curl('api/v1/notice/list', {
                data: { numIndex, numSize, nature, user: id },
            });
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/app/notice/create 消息创建
     * @apiDescription  通讯消息模块
     * @apiGroup  文件
     * @apiParam  {String} [user] 用户 id
     * @apiParam  {String} [title] 消息标题
     * @apiParam  {String} [nature] 消息性质
     * @apiParam  {String} [type] 消息类型
     * @apiParam  {String} [content] 消息内容
     * @apiParam  {String} [push]  推送状态
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/app/notice/create
     */
    async create () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                user: [ 'nonempty' ],
                title: [ 'nonempty' ],
                nature: [ 'nonempty', (v) => ['PRIVATE', 'PUBLIC'].indexOf(v) > -1 ],
                type: [ 'nonempty', (v) => ['LINK', 'TEXT'].indexOf(v) > -1 ],
                content: [ 'nonempty' ],
                push: [ 'nonempty' ],
            });
            await service.transformService.curl('api/v1/notice/create', { data: objParams });
            ctx.respSuccess();
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/app/notice/info 消息详情
     * @apiDescription  通讯消息模块
     * @apiParam  {String} [id] 消息 id
     * @apiGroup  文件
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/app/notice/info
     */
    async info () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                id: [ 'nonempty' ],
            });
            const data = await service.transformService.curl('api/v1/notice/info', { data: objParams });
            if (data.unread) {
                await service.transformService.curl('api/v1/notice/update', {
                    data: { id: objParams.id, user: ctx.state.token.id, unread: false},
                });
            }
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

};
