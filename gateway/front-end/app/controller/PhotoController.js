
'use strict';

const { Controller } = require('egg');

module.exports = class HandleController extends Controller {

    static route (app, middleware, controller) {
        app.router.mount('/api/v1/app/photo/list', middleware.tokenMiddleware(), controller.list)
            .mount('/api/v1/app/photo/create', middleware.tokenMiddleware(), controller.create)
            .mount('/api/v1/app/photo/del', middleware.tokenMiddleware(), controller.del)
            .mount('/api/v1/app/photo/update', middleware.tokenMiddleware(), controller.update)
            .mount('/api/v1/app/photo/info', middleware.tokenMiddleware(), controller.info)
        ;
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/app/photo/list 照片列表
     * @apiDescription  照片模块
     * @apiGroup  文件
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/app/photo/list
     */
    async list () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                startTime: [],
                endTime: [],
            });
            const { id: user } = ctx.state.token;
            const data = await service.transformService.curl('api/v1/photo/list', {
                data: { user, ...objParams },
            });
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }


    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/app/photo/create 照片上传
     * @apiDescription  照片上传
     * @apiGroup  照片
     * @apiParam  {String} [photo] 照片文件 id
     * @apiParam  {String} [title] 照片标题
     * @apiParam  {String} [nature] 照片性质
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/app/photo/create
     */
    async create () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                photo: [ 'nonempty' ],
                title: [ 'nonempty' ],
                nature: [ 'nonempty', (v) => [ 'PRIVACY', 'PUBLIC' ].indexOf(v) > -1 ],
            });
            const { id: user } = ctx.state.token;
            await service.transformService.curl('api/v1/photo/create', {
                data: { user, ...objParams },
            });
            ctx.respSuccess();
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/app/photo/info 照片详情
     * @apiDescription  照片模块
     * @apiGroup  文件
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/app/photo/info
     */
    async info () {
        const { ctx, service, app } = this;
        try {
            let {
                id,
            } = await ctx.validateBody({
                id: [ 'nonempty' ],
            });
            const { id: user } = ctx.state.token;
            const data = await service.transformService.curl('api/v1/photo/info', {
                data: { id },
            });
            data.volume++;
            await service.transformService.curl('api/v1/photo/update', {
                data: { id, volume: data.volume },
            });
            const { user: author } = data.user;
            data.user = await service.transformService.curl('api/v1/user/info', {
                data: { id: data.user },
            });
            data.user.follow = user === author
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/app/photo/del 照片删除
     * @apiDescription  照片模块
     * @apiGroup  文件
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/app/photo/del
     */
    async del () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                id: [ 'nonempty' ],
            });
            const { id: user } = ctx.state.token;
            await service.transformService.curl('api/v1/photo/del', {
                data: { user, ...objParams },
            });
            ctx.respSuccess();
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/app/photo/update 照片更新
     * @apiDescription  照片模块
     * @apiGroup  文件
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/app/photo/update
     */
    async update () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                id: [ 'nonempty' ],
                photo: [ 'nonempty' ],
                title: [ 'nonempty' ],
                nature: [ 'nonempty', (v) => [ 'PRIVACY', 'PUBLIC' ].indexOf(v) > -1 ],
            });
            const { id: user } = ctx.state.token;
            await service.transformService.curl('api/v1/photo/update', {
                data: { user, ...objParams },
            });
            ctx.respSuccess();
        } catch (err) {
            ctx.respError(err);
        }
    }
};
