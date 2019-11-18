
'use strict';

const { Controller } = require('egg');

module.exports = class HandleController extends Controller {

    static route (app, middleware, controller) {
        app.router.mount('/api/v1/record/list', controller.list)
            .mount('/api/v1/record/create', controller.create)
            .mount('/api/v1/record/update', controller.update)
            .mount('/api/v1/record/delete', controller.del)
        ;
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/record/create 创建问题记录
     * @apiDescription 创建问题记录
     * @apiGroup 问题记录
     * @apiParam  {String} [question] 问题
     * @apiParam  {String} [application] 应用
     * @apiParam  {String} [fqa] 问题
     * @apiParam  {String} [appraise] 评价
     * @apiParam  {String} [account] 账号
     * @apiParam  {String} [remark] 备注
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/record/create
     */
    async create () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                question: [ 'nonempty' ],
                application: [ 'nonempty' ],
                fqa: [ ],
                appraise: [ ],
                account: [ ],
                remark: [ ],
            });
            await service.recordService.create(objParams);
            ctx.respSuccess();
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/record/delete 删除问题记录
     * @apiDescription 删除问题记录
     * @apiGroup 问题记录
     * @apiParam  {String} [id] id
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/record/delete
     */
    async del () {
        const { ctx, service, app } = this;
        try {
            let {
                id,
            } = await ctx.validateBody({
                id: [ 'nonempty' ],
            });
            await service.recordService.del(id);
            ctx.respSuccess();
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/record/update 更新问题记录
     * @apiDescription 更新问题记录
     * @apiGroup 问题记录
     * @apiParam  {String} [id] id
     * @apiParam  {String} [question] 问题
     * @apiParam  {String} [application] 应用
     * @apiParam  {String} [fqa] 问题
     * @apiParam  {String} [appraise] 评价
     * @apiParam  {String} [account] 账号
     * @apiParam  {String} [remark] 备注
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/record/update
     */
    async update () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                id: [ 'nonempty' ],
                question: [ 'nonempty' ],
                application: [ 'nonempty' ],
                fqa: [ ],
                appraise: [ ],
                account: [ ],
                remark: [ ],
            });
            await service.recordService.update(objParams);
            ctx.respSuccess();
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/record/list 查询问题记录列表
     * @apiDescription 查询问题记录列表
     * @apiGroup 问题记录
     * @apiParam  {String} [numIndex] 页数
     * @apiParam  {String} [numSize] 大小
     * @apiParam  {String} [application] 应用
     * @apiParam  {String} [keyword] keyword
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/record/list
     */
    async list () {
        const { ctx, service, app } = this;
        try {
            const objParams = await ctx.validateBody({
                numIndex: [ ],
                numSize: [ ],
                keyword: [ ],
                application: [ ],
            });
            const data = await service.recordService.list(objParams);
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }
};
