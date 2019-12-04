
'use strict';

const { Controller } = require('egg');

module.exports = class HandleController extends Controller {

    static route (app, middleware, controller) {
        app.router.mount('/api/v1/video/create', controller.create)
            .mount('/api/v1/video/update', controller.update)
            .mount('/api/v1/video/info', controller.info)
            .mount('/api/v1/video/list', controller.list)
            .mount('/api/v1/video/del', controller.del)
        ;
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/video/create 创建视频
     * @apiDescription 创建视频
     * @apiGroup 视频
     * @apiParam  {String} [user] 用户 id
     * @apiParam  {String} [video] 视频文件 id
     * @apiParam  {String} [cover] 视频封面文件 id
     * @apiParam  {String} [title] 视频标题 id
     * @apiParam  {String} [nature] 视频性质
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/video/create
     */
    async create () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                user: [ 'nonempty' ],
                video: [ 'nonempty' ],
                cover: [ 'nonempty' ],
                title: [ 'nonempty' ],
                nature: [ 'nonempty' ],
            });
            ctx.logger.info(`创建视频：请求参数=> ${JSON.stringify(objParams)} `);
            await service.videoService.create(objParams);
            ctx.logger.info(`创建视频：返回结果=> 成功`);
            ctx.respSuccess();
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/video/update 更新视频
     * @apiDescription 更新视频
     * @apiGroup 视频
     * @apiParam  {String} [id] 视频 id
     * @apiParam  {String} [user] 用户 id
     * @apiParam  {String} [video] 视频文件 id
     * @apiParam  {String} [cover] 视频封面文件 id
     * @apiParam  {String} [title] 视频标题 id
     * @apiParam  {String} [nature] 视频性质
     * @apiParam  {String} [volume] 播放量
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/video/update
     */
    async update () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                user: [ 'nonempty' ],
                id: [ 'nonempty' ],
                video: [],
                cover: [],
                title: [],
                volume: [],
                nature: [],
            });
            ctx.logger.info(`更新视频信息：请求参数=> ${JSON.stringify(objParams)} `);
            await service.videoService.update(objParams);
            ctx.logger.info(`更新视频信息：返回结果=> 成功 `);
            ctx.respSuccess();
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/video/info 查询视频
     * @apiDescription 更新视频
     * @apiGroup 视频
     * @apiParam  {String} [id] 视频 id
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/video/info
     */
    async info () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                id: [ 'nonempty' ],
            });
            ctx.logger.info(`查询视频信息：请求参数=> ${JSON.stringify(objParams)} `);
            const data = await service.videoService.findById(objParams);
            ctx.logger.info(`查询视频信息：返回结果=> ${JSON.stringify(data)} `);
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/video/del 删除视频
     * @apiDescription 删除视频
     * @apiGroup 视频
     * @apiParam  {String} [id] 视频 id
     * @apiParam  {String} [user] 用户
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/video/del
     */
    async del () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                id: [ 'nonempty' ],
                user: [ 'nonempty' ],
            });
            ctx.logger.info(`删除视频信息：请求参数=> ${JSON.stringify(objParams)} `);
            const data = await service.videoService.del(objParams);
            ctx.logger.info(`删除视频信息：返回结果=> 成功 `);
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/video/list 查询视频列表
     * @apiDescription 查询视频列表
     * @apiGroup APP基础
     * @apiParam  {String} [numIndex] 页数
     * @apiParam  {String} [numSize] 大小
     * @apiParam  {String} [keyword] 标题 / 时间
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/video/list
     */
    async list () {
        const { ctx, service, app } = this;
        try {
            const objParams = await ctx.validateBody({
                numIndex: [ 'nonempty' ],
                numSize: [ 'nonempty' ],
                user: [],
                keyword: [],
            });
            const data = await service.videoService.list(objParams);
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

};
