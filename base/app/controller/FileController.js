
'use strict';

const { Controller } = require('egg');

module.exports = class HandleController extends Controller {

    static route (app, middleware, controller) {
        app.router.mount('/api/v1/file/create', controller.create)
            .mount('/api/v1/file/info', controller.info)
            .mount('/api/v1/file/list', controller.list)
            .mount('/api/v1/file/del', controller.del)
        ;
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/file/create 创建文件
     * @apiDescription 创建文件
     * @apiGroup 文件
     * @apiParam  {String} [user] 用户 id
     * @apiParam  {String} [ip] ip
     * @apiParam  {String} [type] 文件类型
     * @apiParam  {String} [path] 路径
     * @apiParam  {String} [base] 服务器路径
     * @apiParam  {String} [filename] 文件名
     * @apiParam  {String} [source] 原文件名
     * @apiParam  {String} [device] 设备信息
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/file/create
     */
    async create () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                user: [ 'nonempty' ],
                ip: [ 'nonempty' ],
                type: [ 'nonempty' ],
                path: [ 'nonempty' ],
                base: [ 'nonempty' ],
                filename: [ 'nonempty' ],
                device: [ 'nonempty' ],
                source: [ 'nonempty' ],
            });
            ctx.logger.info(`创建文件：请求参数=> ${JSON.stringify(objParams)} `);
            const data = await service.fileService.create(objParams);
            ctx.logger.info(`创建文件：返回结果=> 成功`);
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/file/info 查询文件
     * @apiDescription 更新文件
     * @apiGroup 文件
     * @apiParam  {String} [id] 文件 id
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/file/info
     */
    async info () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                id: [ 'nonempty' ],
            });
            ctx.logger.info(`查询文件信息：请求参数=> ${JSON.stringify(objParams)} `);
            const data = await service.fileService.findById(objParams);
            ctx.logger.info(`查询文件信息：返回结果=> ${JSON.stringify(data)} `);
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/file/del 删除文件
     * @apiDescription 删除文件
     * @apiGroup 文件
     * @apiParam  {String} [id] 文件 id
     * @apiParam  {String} [user] 用户
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/file/del
     */
    async del () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                id: [ 'nonempty' ],
                user: [ 'nonempty' ],
            });
            ctx.logger.info(`删除文件信息：请求参数=> ${JSON.stringify(objParams)} `);
            const data = await service.fileService.del(objParams);
            ctx.logger.info(`删除文件信息：返回结果=> 成功 `);
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/file/list 查询文件列表
     * @apiDescription 查询文件列表
     * @apiGroup APP基础
     * @apiParam  {String} [numIndex] 页数
     * @apiParam  {String} [numSize] 大小
     * @apiParam  {String} [keyword] 标题 / 时间
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/file/list
     */
    async list () {
        const { ctx, service, app } = this;
        try {
            const objParams = await ctx.validateBody({
                numIndex: [ 'nonempty' ],
                numSize: [ 'nonempty' ],
                user: [],
                keyword: [],
                type: [ (v) => !v || [ 'AVATAR', 'PHOTO' ].indexOf(v) > -1 ],
            });
            const { keyword } = objParams;
            let arrUser = [];
            if (keyword) {
                arrUser = await service.userService.list({ keyword });
                arrUser.map((item) => item._id);
            }
            const data = await service.fileService.list({ ...objParams, arrUser });
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

};
