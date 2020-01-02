
'use strict';

const { Controller } = require('egg');
const moment = require('moment');

module.exports = class HandleController extends Controller {

    static route (app, middleware, controller) {
        app.router.mount('/api/v1/app/thumb/do', middleware.tokenMiddleware(), controller.do)
            .mount('/api/v1/app/thumb/list', middleware.tokenMiddleware(), controller.list)
        ;
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/thumb/do 点赞 or 取消
     * @apiDescription 点赞 or 取消
     * @apiGroup 点赞
     * @apiParam  {String} [photo] 照片
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/thumb/do
     */
    async do () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                photo: [ 'nonempty' ],
            });
            ctx.logger.info(`创建点赞：请求参数=> ${JSON.stringify(objParams)} `);
            const { id: user } = ctx.state.token;
            const { nickname, email } = ctx.state.token.user;
            let data = await service.transformService.curl('api/v1/thumb/info', {
                data: { ...objParams, user },
            });
            // 查询作者用户
            let { user: author, title, created_at } = await service.transformService.curl('api/v1/photo/info', {
                data: { id: objParams.photo },
            });
            if (data) {
                // 取消
                await service.transformService.curl('api/v1/thumb/del', {
                    data: { ...objParams, user },
                });
                data = '';
            } else {
                // 创建
                data = await service.transformService.curl('api/v1/thumb/create', {
                    data: { ...objParams, user },
                });
            }
            // 通知作者用户已有人取消 or 点赞
            await service.transformService.curl('api/v1/notice/create', {
                data: {
                    user: author._id,
                    title: data ? `用户 ${nickname || email} 点赞了` : `用户 ${nickname || email} 取消了点赞`,
                    content: data ? `用户 ${nickname || email} 点赞了您于${moment(created_at).format('YYYY-MM-DD HH:mm:ss')}发布的作品《${title}》。`
                        : `用户 ${nickname || email} 取消了您于${moment(created_at).format('YYYY-MM-DD HH:mm:ss')}发布的作品《${title}》的点赞。` ,
                    type: 'TEXT',
                    nature: 'PRIVATE',
                    push: true,
                },
            });
            ctx.logger.info(`创建点赞：返回结果=> 成功`);
            ctx.respSuccess(data ? data._id : '');
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/app/thumb/list 查询点赞
     * @apiDescription 更新点赞
     * @apiGroup 点赞
     * @apiParam  {String} [numIndex] 页数
     * @apiParam  {String} [numSize] 大小
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/app/thumb/list
     */
    async list () {
        const { ctx, service, app } = this;
        try {
            const objParams = await ctx.validateBody({
                numIndex: [ 'nonempty' ],
                numSize: [ 'nonempty' ],
            });
            const { id } = ctx.state.token;
            const data = await service.transformService.curl('api/v1/thumb/list', {
                data: { ...objParams, user: id },
            });
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

};
