
'use strict';

const { Controller } = require('egg');

module.exports = class HandleController extends Controller {

    static route (app, middleware, controller) {
        app.router.mount('/api/v1/app/dislike/create', middleware.tokenMiddleware(), controller.create)
            .mount('/api/v1/app/dislike/list', middleware.tokenMiddleware(), controller.list)
            .mount('/api/v1/app/dislike/del', middleware.tokenMiddleware(), controller.del)
        ;
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/dislike/create 创建不喜欢
     * @apiDescription 创建不喜欢
     * @apiGroup 不喜欢
     * @apiParam  {String} [user] 用户 id
     * @apiParam  {String} [photo] 照片
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/dislike/create
     */
    async create () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                user: [ 'nonempty' ],
                photo: [ 'nonempty' ],
            });
            ctx.logger.info(`创建不喜欢：请求参数=> ${JSON.stringify(objParams)} `);
            ctx.logger.info(`创建不喜欢：返回结果=> 成功`);
            ctx.respSuccess();
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/app/dislike/list 查询不喜欢
     * @apiDescription 更新不喜欢
     * @apiGroup 不喜欢
     * @apiParam  {String} [numIndex] 页数
     * @apiParam  {String} [numSize] 大小
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/app/dislike/list
     */
    async list () {
        const { ctx, service, app } = this;
        try {
            const objParams = await ctx.validateBody({
                numIndex: [ 'nonempty' ],
                numSize: [ 'nonempty' ],
            });
            const { id } = ctx.state.token;
            const data = await service.transformService.curl('api/v1/dislike/list', {
                data: { ...objParams, user: id },
            });
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/app/dislike/del 删除不喜欢
     * @apiDescription 删除不喜欢
     * @apiGroup 不喜欢
     * @apiParam  {String} [id] id
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/app/dislike/del
     */
    async del () {
        const { ctx, service, app } = this;
        try {
            const objParams = await ctx.validateBody({
                id: [ 'nonempty' ],
            });
            const { id } = ctx.state.token;
            const data = await service.transformService.curl('api/v1/dislike/del', {
                data: { ...objParams, user: id },
            });
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }



};
