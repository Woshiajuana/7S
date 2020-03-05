
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
                id,
            } = await ctx.validateBody({
                id: [ 'nonempty' ],
            });
            const { id: user } = ctx.state.token;
            const { nickname, email } = ctx.state.token.user;
            if (id === user)
                throw '不能关注自己';
            let objFollowingData = await service.transformService.curl('api/v1/following/info', {
                data: { user, following: id },
            });
            let objFollowerData = await service.transformService.curl('api/v1/follower/info', {
                data: { user: id, follower: user },
            });
            if (!objFollowingData && !objFollowerData) {
                // 取消关注
                objFollowingData = await service.transformService.curl('api/v1/following/create', {
                    data: { user, following: id },
                });
                objFollowerData = await service.transformService.curl('api/v1/follower/create', {
                    data: { user: id, follower: user },
                });
            } else {
                // 取消关注
                await service.transformService.curl('api/v1/following/del', {
                    data: { user, following: id },
                });
                await service.transformService.curl('api/v1/follower/del', {
                    data: { user: id, follower: user },
                });
                objFollowingData = '';
                objFollowerData = '';
            }
            // 通知作者用户已有人关注 or 取消关注
            await service.transformService.curl('api/v1/notice/create', {
                data: {
                    user: id,
                    title: objFollowerData ? `用户 ${nickname || email} 关注了您` : `用户 ${nickname || email} 取消了关注`,
                    content: objFollowerData ? `恭喜您，用户 ${nickname || email} 关注了您，您又新增了一位粉丝哦。`
                        : `哦豁...用户 ${nickname || email} 取消了关注。` ,
                    type: 'TEXT',
                    nature: 'PRIVATE',
                    push: true,
                },
            });
            ctx.respSuccess(objFollowingData ? objFollowingData._id : '');
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
            let data = await service.transformService.curl('api/v1/follower/list', {
                data: { user, ...objParams },
            });
            if (data) {
                data.list = data.list.map(({_id, follower, created_at, updated_at}) => Object.assign({}, follower, { created_at, updated_at }));
            }
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/app/following/list  关注列表
     * @apiDescription  关注模块
     * @apiGroup  关注
     * @apiParam  {String} [numIndex] 页数
     * @apiParam  {String} [numSize] 每页数量
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/app/following/list
     */
    async followingList () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                numIndex: [ 'nonempty' ],
                numSize: [ 'nonempty' ],
            });
            const { id: user } = ctx.state.token;
            let data = await service.transformService.curl('api/v1/following/list', {
                data: { user, ...objParams },
            });
            if (data) {
                data.list = data.list.map(({_id, following, created_at, updated_at}) => Object.assign({}, following, { created_at, updated_at }));
            }
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }


};
