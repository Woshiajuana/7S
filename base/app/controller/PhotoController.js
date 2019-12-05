
'use strict';

const { Controller } = require('egg');

module.exports = class HandleController extends Controller {

    static route (app, middleware, controller) {
        app.router.mount('/api/v1/photo/create', controller.create)
            .mount('/api/v1/photo/update', controller.update)
            .mount('/api/v1/photo/info', controller.info)
            .mount('/api/v1/photo/list', controller.list)
            .mount('/api/v1/photo/del', controller.del)
        ;
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/photo/create 创建照片
     * @apiDescription 创建照片
     * @apiGroup 照片
     * @apiParam  {String} [user] 用户 id
     * @apiParam  {String} [photo] 照片文件 id
     * @apiParam  {String} [title] 照片标题 id
     * @apiParam  {String} [nature] 照片性质
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/photo/create
     */
    async create () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                user: [ 'nonempty' ],
                photo: [ 'nonempty' ],
                title: [ 'nonempty' ],
                nature: [ 'nonempty' ],
            });
            ctx.logger.info(`创建照片：请求参数=> ${JSON.stringify(objParams)} `);
            await service.photoService.create(objParams);
            ctx.logger.info(`创建照片：返回结果=> 成功`);
            ctx.respSuccess();
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/photo/update 更新照片
     * @apiDescription 更新照片
     * @apiGroup 照片
     * @apiParam  {String} [id] 照片 id
     * @apiParam  {String} [user] 用户 id
     * @apiParam  {String} [photo] 照片文件 id
     * @apiParam  {String} [title] 照片标题 id
     * @apiParam  {String} [nature] 照片性质
     * @apiParam  {String} [volume] 播放量
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/photo/update
     */
    async update () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                user: [ 'nonempty' ],
                id: [ 'nonempty' ],
                photo: [],
                title: [],
                volume: [],
                nature: [],
            });
            ctx.logger.info(`更新照片信息：请求参数=> ${JSON.stringify(objParams)} `);
            await service.photoService.update(objParams);
            ctx.logger.info(`更新照片信息：返回结果=> 成功 `);
            ctx.respSuccess();
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/photo/info 查询照片
     * @apiDescription 更新照片
     * @apiGroup 照片
     * @apiParam  {String} [id] 照片 id
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/photo/info
     */
    async info () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                id: [ 'nonempty' ],
            });
            ctx.logger.info(`查询照片信息：请求参数=> ${JSON.stringify(objParams)} `);
            const data = await service.photoService.findById(objParams);
            await service.photoService.update({ ...data, volume: data.volume + 1 });
            ctx.logger.info(`查询照片信息：返回结果=> ${JSON.stringify(data)} `);
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/photo/del 删除照片
     * @apiDescription 删除照片
     * @apiGroup 照片
     * @apiParam  {String} [id] 照片 id
     * @apiParam  {String} [user] 用户
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/photo/del
     */
    async del () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                id: [ 'nonempty' ],
                user: [ 'nonempty' ],
            });
            ctx.logger.info(`删除照片信息：请求参数=> ${JSON.stringify(objParams)} `);
            const data = await service.photoService.del(objParams);
            ctx.logger.info(`删除照片信息：返回结果=> 成功 `);
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/photo/list 查询照片列表
     * @apiDescription 查询照片列表
     * @apiGroup APP基础
     * @apiParam  {String} [numIndex] 页数
     * @apiParam  {String} [numSize] 大小
     * @apiParam  {String} [keyword] 标题 / 时间
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/photo/list
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
            const data = await service.photoService.list(objParams);
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

};