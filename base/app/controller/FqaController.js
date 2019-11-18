
'use strict';

const { Controller } = require('egg');

module.exports = class HandleController extends Controller {

    static route (app, middleware, controller) {
        app.router.mount('/api/v1/fqa/list', controller.list)
            .mount('/api/v1/fqa/create', controller.create)
            .mount('/api/v1/fqa/update', controller.update)
            .mount('/api/v1/fqa/delete', controller.del)
            .mount('/api/v1/fqa/search/keywords', controller.searchByKeyWord)
            .mount('/api/v1/fqa/search/id', controller.searchById)
            .mount('/api/v1/fqa/search/question', controller.searchByQuestion)
            .mount('/api/v1/fqa/appraise', controller.appraise)
            .mount('/api/v1/fqa/recommend', controller.recommend)
        ;
    }

    async recommend () {
        const { ctx, service, app } = this;
        try {
            let {
                application
            } = await ctx.validateBody({
                application: [ 'nonempty' ],
            });
            let arrRecommend = await service.fqaService.recommend(application);
            let app = await service.applicationService.findById(application);
            ctx.respSuccess({
                application: app || {},
                recommend: arrRecommend,
            });
        } catch (err) {
            ctx.respError(err);
        }
    }

    async appraise () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                id: [ 'nonempty' ],
                application: [ 'nonempty' ],
                appraise: [ 'nonempty' ],
                record: [ 'nonempty' ],
            });
            await service.recordService.appraise(objParams);
            await service.fqaService.appraise(objParams);
            ctx.respSuccess();
        } catch (err) {
            ctx.respError(err);
        }
    }

    async searchByQuestion () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                question: [ 'nonempty' ],
                application: [ 'nonempty' ],
                account: [ ],
            });
            let data = await service.fqaService.searchByQuestion(objParams);
            let { recommend, _id } = data;
            let objRecordItem = { ...objParams };
            if (!recommend) {
                objRecordItem.fqa = _id;
            }
            let { _id: recordId } = await service.recordService.create(objRecordItem);
            data.recordId = recordId;
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

    async searchById () {
        const { ctx, service, app } = this;
        try {
            let {
                id,
                application,
                account = '',
            } = await ctx.validateBody({
                id: [ 'nonempty' ],
                application: [ 'nonempty' ],
                account: [ ],
            });
            let data = await service.fqaService.findById(id);
            let { question, _id } = data;
            let { _id: recordId } = await service.recordService.create({
                account,
                question,
                application,
                fqa: _id,
            });
            ctx.respSuccess({ recordId, ...data });
        } catch (err) {
            ctx.respError(err);
        }
    }

    async searchByKeyWord () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                application: [ 'nonempty' ],
                keyword: [ 'nonempty' ],
            });
            let data = await service.fqaService.searchByKeyWord(objParams);
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/fqa/create 创建FQA
     * @apiDescription 创建FQA
     * @apiGroup FQA
     * @apiParam  {String} [application] 应用
     * @apiParam  {String} [question] 问题
     * @apiParam  {Array} [keywords] 关键词
     * @apiParam  {String} [answer] 答案
     * @apiParam  {String} [remark] 备注
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/fqa/create
     */
    async create () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                application: [ 'nonempty' ],
                question: [ 'nonempty' ],
                keywords: [ 'nonempty' ],
                answer: [ 'nonempty' ],
                remark: [ ],
            });
            await service.fqaService.create(objParams);
            ctx.respSuccess();
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/fqa/delete 删除FQA
     * @apiDescription 删除FQA
     * @apiGroup FQA
     * @apiParam  {String} [id] id
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/fqa/delete
     */
    async del () {
        const { ctx, service, app } = this;
        try {
            let {
                id,
            } = await ctx.validateBody({
                id: [ 'nonempty' ],
            });
            await service.fqaService.del(id);
            ctx.respSuccess();
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/fqa/update 更新FQA
     * @apiDescription 更新FQA
     * @apiGroup FQA
     * @apiParam  {String} [id] id
     * @apiParam  {String} [application] 应用
     * @apiParam  {String} [question] 问题
     * @apiParam  {Array} [keywords] 关键词
     * @apiParam  {String} [answer] 答案
     * @apiParam  {String} [remark] 备注
     * @apiSampleRequest /api/v1/fqa/update
     */
    async update () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                id: [ 'nonempty' ],
                application: [ 'nonempty' ],
                question: [ 'nonempty' ],
                keywords: [ 'nonempty' ],
                answer: [ 'nonempty' ],
                remark: [ ],
            });
            await service.fqaService.update(objParams);
            ctx.respSuccess();
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/fqa/list 查询FQA列表
     * @apiDescription 查询FQA列表
     * @apiGroup FQA
     * @apiParam  {String} [numIndex] 页数
     * @apiParam  {String} [numSize] 大小
     * @apiParam  {String} [application] 应用
     * @apiParam  {String} [keyword] keyword
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/fqa/list
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
            const data = await service.fqaService.list(objParams);
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }
};
