
'use strict';

const { Controller } = require('egg');

module.exports = class HandleController extends Controller {

    static route (app, middleware, controller) {
        app.router.mount('/api/v1/app/follow/update', middleware.tokenMiddleware(), controller.update)
            .mount('/api/v1/app/follower/list', middleware.tokenMiddleware(), controller.followerList)
            .mount('/api/v1/app/following/list', middleware.tokenMiddleware(), controller.followingList)
        ;
    }


    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/app/follow/update 关注 or 取消关注
     * @apiDescription  关注模块
     * @apiGroup  关注
     * @apiParam  {String} [following]  用户 id
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/app/follow/update
     */
    async update () {
        const { ctx, service, app } = this;
        try {
            let {
                following,
                operate,
            } = await ctx.validateBody({
                following: [ 'nonempty' ],
                operate: [ 'nonempty' ]
            });
            const { id: user } = ctx.state.token;
            let data;
            if (operate) {
                data = await service.transformService.curl('api/v1/following/create', {
                    data: { user: following, follower: user },
                });
                await service.transformService.curl('api/v1/follower/create', {
                    data: { user, following },
                });
            } else {
                await service.transformService.curl('api/v1/following/del', {
                    data: { user: following, follower: user },
                });
                await service.transformService.curl('api/v1/follower/del', {
                    data: { user, following },
                });
            }
            ctx.respSuccess(data ? data._id : '');
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/app/follower/list 粉丝列表
     * @apiDescription  关注模块
     * @apiGroup  关注
     * @apiParam  {String} [numIndex] 页数
     * @apiParam  {String} [numSize] 每页数量
     * @apiParam  {String} [following]  用户 id
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/app/follower/list
     */
    async followerList () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                numIndex: [ 'nonempty' ],
                numSize: [ 'nonempty' ],
            });
            const { id: user } = ctx.state.token;
            const data = await service.transformService.curl('api/v1/follower/list', {
                data: { user, ...objParams },
            });
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/app/follower/list 粉丝列表
     * @apiDescription  关注模块
     * @apiGroup  关注
     * @apiParam  {String} [numIndex] 页数
     * @apiParam  {String} [numSize] 每页数量
     * @apiParam  {String} [following]  用户 id
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/app/follower/list
     */
    async followingList () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                numIndex: [ 'nonempty' ],
                numSize: [ 'nonempty' ],
            });
            const { id: user } = ctx.state.token;
            const data = await service.transformService.curl('api/v1/following/list', {
                data: { user, ...objParams },
            });
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }


};
