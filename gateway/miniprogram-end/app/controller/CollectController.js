
'use strict';

const { Controller } = require('egg');
const moment = require('moment');

module.exports = class HandleController extends Controller {

    static route (app, middleware, controller) {
        app.router.mount('/api/v1/wx/collect/do', middleware.tokenMiddleware(), controller.do)
            .mount('/api/v1/wx/collect/list', middleware.tokenMiddleware(), controller.list)
        ;
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/collect/do 收藏 or 取消
     * @apiDescription 收藏 or 取消
     * @apiGroup 收藏
     * @apiParam  {String} [photo] 照片
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/collect/do
     */
    async do () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                photo: [ 'nonempty' ],
            });
            ctx.logger.info(`创建收藏：请求参数=> ${JSON.stringify(objParams)} `);
            const { id: user } = ctx.state.token;
            const { nickname, email } = ctx.state.token.user;
            let data = await service.transformService.curl('api/v1/collect/info', {
                data: { ...objParams, user },
            });
            // 查询作者用户
            let { user: author, title, created_at } = await service.transformService.curl('api/v1/photo/info', {
                data: { id: objParams.photo },
            });
            if (data) {
                // 取消
                await service.transformService.curl('api/v1/collect/del', {
                    data: { ...objParams, user },
                });
                data = '';
            } else {
                // 创建
                data = await service.transformService.curl('api/v1/collect/create', {
                    data: { ...objParams, user },
                });
            }
            // 通知作者用户已有人取消 or 收藏
            await service.transformService.curl('api/v1/notice/create', {
                data: {
                    user: author._id,
                    title: data ? `用户 ${nickname || email} 收藏了` : `用户 ${nickname || email} 取消了收藏`,
                    content: data ? `用户 ${nickname || email} 收藏了您于${moment(created_at).format('YYYY-MM-DD HH:mm:ss')}发布的作品《${title}》。`
                        : `用户 ${nickname || email} 取消了您于${moment(created_at).format('YYYY-MM-DD HH:mm:ss')}发布的作品《${title}》的收藏。` ,
                    type: 'TEXT',
                    nature: 'PRIVATE',
                    push: true,
                },
            });
            ctx.logger.info(`创建收藏：返回结果=> 成功`);
            ctx.respSuccess(data ? data._id : '');
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/wx/collect/list 查询收藏
     * @apiDescription 更新收藏
     * @apiGroup 收藏
     * @apiParam  {String} [numIndex] 页数
     * @apiParam  {String} [numSize] 大小
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/wx/collect/list
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

};
