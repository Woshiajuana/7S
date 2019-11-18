
'use strict';

const { Controller } = require('egg');

module.exports = class HandleController extends Controller {

    static route (app, middleware, controller) {
        app.router.mount('/api/v1/feedback/list', controller.list)
            .mount('/api/v1/feedback/create', controller.create)
            .mount('/api/v1/feedback/update', controller.update)
            .mount('/api/v1/feedback/delete', controller.del)
        ;
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/feedback/create 创建问题反馈
     * @apiDescription 创建问题反馈
     * @apiGroup 问题反馈
     * @apiParam  {String} [application] 应用 id
     * @apiParam  {String} [name] 反馈人的姓名
     * @apiParam  {String} [phone] 反馈人的手机
     * @apiParam  {String} [email] 反馈人的邮箱
     * @apiParam  {String} [content] 反馈的内容
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/feedback/create
     */
    async create () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                application: [ 'nonempty' ],
                name: [ 'nonempty' ],
                phone: [ 'nonempty' ],
                email: [ 'nonempty' ],
                content: [ 'nonempty' ],
            });
            await service.feedbackService.create(objParams);
            ctx.respSuccess();
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/feedback/delete 删除问题反馈
     * @apiDescription 删除问题反馈
     * @apiGroup 问题反馈
     * @apiParam  {String} [id] id
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/feedback/delete
     */
    async del () {
        const { ctx, service, app } = this;
        try {
            let {
                id,
            } = await ctx.validateBody({
                id: [ 'nonempty' ],
            });
            await service.feedbackService.del(id);
            ctx.respSuccess();
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/feedback/update 更新问题反馈
     * @apiDescription 更新问题反馈
     * @apiGroup 问题反馈
     * @apiParam  {String} [id] id
     * @apiParam  {String} [application] 应用 id
     * @apiParam  {String} [name] 反馈人的姓名
     * @apiParam  {String} [phone] 反馈人的手机
     * @apiParam  {String} [email] 反馈人的邮箱
     * @apiParam  {String} [content] 反馈的内容
     * @apiSampleRequest /api/v1/feedback/update
     */
    async update () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                id: [ 'nonempty' ],
                application: [ 'nonempty' ],
                name: [ 'nonempty' ],
                phone: [ 'nonempty' ],
                email: [ 'nonempty' ],
                content: [ 'nonempty' ],
            });
            await service.feedbackService.update(objParams);
            ctx.respSuccess();
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/feedback/list 查询问题反馈列表
     * @apiDescription 查询问题反馈列表
     * @apiGroup 问题反馈
     * @apiParam  {String} [numIndex] 页数
     * @apiParam  {String} [numSize] 大小
     * @apiParam  {String} [application] 应用 id
     * @apiParam  {String} [keyword] keyword
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/feedback/list
     */
    async list () {
        const { ctx, service, app } = this;
        try {
            const objParams = await ctx.validateBody({
                numIndex: [ ],
                numSize: [ ],
                application: [ ],
                keyword: [ ],
            });
            const data = await service.feedbackService.list(objParams);
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }
};
