
'use strict';

const { Controller } = require('egg');

module.exports = class HandleController extends Controller {

    static route (app, middleware, controller) {
        app.router.mount('/api/v1/application/list', controller.list)
            .mount('/api/v1/application/create', controller.create)
            .mount('/api/v1/application/update', controller.update)
            .mount('/api/v1/application/delete', controller.del)
        ;
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/application/create 创建应用
     * @apiDescription 创建应用
     * @apiGroup 应用
     * @apiParam  {String} [name] 应用名称
     * @apiParam  {String} [logo] logo
     * @apiParam  {String} [remark] 备注
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/application/create
     */
    async create () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                name: [ 'nonempty' ],
                logo: [ 'nonempty' ],
                remark: [ 'nonempty' ],
            });
            await service.applicationService.create(objParams);
            ctx.respSuccess();
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/application/delete 删除应用
     * @apiDescription 删除应用
     * @apiGroup 应用
     * @apiParam  {String} [id] id
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/application/delete
     */
    async del () {
        const { ctx, service, app } = this;
        try {
            let {
                id,
            } = await ctx.validateBody({
                id: [ 'nonempty' ],
            });
            await service.applicationService.del(id);
            ctx.respSuccess();
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/application/update 更新应用
     * @apiDescription 更新应用
     * @apiGroup 应用
     * @apiParam  {String} [id] id
     * @apiParam  {String} [name] 应用名称
     * @apiParam  {String} [logo] logo
     * @apiParam  {String} [remark] 备注
     * @apiSampleRequest /api/v1/application/update
     */
    async update () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                id: [ 'nonempty' ],
                name: [ 'nonempty' ],
                logo: [ 'nonempty' ],
                remark: [ 'nonempty' ],
            });
            await service.applicationService.update(objParams);
            ctx.respSuccess();
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/application/list 查询应用列表
     * @apiDescription 查询应用列表
     * @apiGroup 应用
     * @apiParam  {String} [numIndex] 页数
     * @apiParam  {String} [numSize] 大小
     * @apiParam  {String} [id] id
     * @apiParam  {String} [name] 应用名称
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/application/list
     */
    async list () {
        const { ctx, service, app } = this;
        try {
            const objParams = await ctx.validateBody({
                numIndex: [ ],
                numSize: [ ],
                name: [ ],
                id: [ ],
            });
            const data = await service.applicationService.list(objParams);
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }
};
