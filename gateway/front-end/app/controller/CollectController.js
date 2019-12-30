
'use strict';

const { Controller } = require('egg');

module.exports = class HandleController extends Controller {

    static route (app, middleware, controller) {
        app.router.mount('/api/v1/app/collect/create', middleware.tokenMiddleware(), controller.create)
            .mount('/api/v1/app/collect/list', middleware.tokenMiddleware(), controller.list)
            .mount('/api/v1/app/collect/del', middleware.tokenMiddleware(), controller.del)
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
            ctx.logger.info(`创建收藏：返回结果=> 成功`);
            ctx.respSuccess();
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/app/collect/list 查询收藏
     * @apiDescription 更新收藏
     * @apiGroup 收藏
     * @apiParam  {String} [numIndex] 页数
     * @apiParam  {String} [numSize] 大小
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/app/collect/list
     */
    async list () {
        const { ctx, service, app } = this;
        try {
            const objParams = await ctx.validateBody({
                numIndex: [ 'nonempty' ],
                numSize: [ 'nonempty' ],
            });
            const { id } = ctx.state.token;
            const data = await service.transformService.curl('api/v1/collect/list', {
                data: { ...objParams, user: id },
            });
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/app/collect/del 删除收藏
     * @apiDescription 删除收藏
     * @apiGroup 收藏
     * @apiParam  {String} [id] id
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/app/collect/del
     */
    async del () {
        const { ctx, service, app } = this;
        try {
            const objParams = await ctx.validateBody({
                id: [ 'nonempty' ],
            });
            const { id } = ctx.state.token;
            const data = await service.transformService.curl('api/v1/collect/del', {
                data: { ...objParams, user: id },
            });
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }



};
