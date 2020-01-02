
'use strict';

const { Controller } = require('egg');

module.exports = class HandleController extends Controller {

    static route (app, middleware, controller) {
        app.router.mount('/api/v1/version/create', controller.create)
            .mount('/api/v1/version/info', controller.info)
            .mount('/api/v1/version/list', controller.list)
            .mount('/api/v1/version/del', controller.del)
            .mount('/api/v1/version/check', controller.check)
        ;
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/version/create 创建版本
     * @apiDescription 创建版本
     * @apiGroup 版本
     * @apiParam  {String} [version] 版本
     * @apiParam  {String} [platform] 平台[ android, iOS ]
     * @apiParam  {String} [content] 内容
     * @apiParam  {String} [remark] 备注
     * @apiParam  {String} [min] 最低
     * @apiParam  {String} [max] 最高
     * @apiParam  {String} [address] 下载地址
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/version/create
     */
    async create () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                version: [ 'nonempty' ],
                platform: [ 'nonempty', (v) => ['android', 'iOS'].indexOf(v) > -1 ],
                content: [ 'nonempty' ],
                remark: [ 'nonempty' ],
                min: [ 'nonempty' ],
                max: [ 'nonempty' ],
                address: [ 'nonempty' ],
            });
            ctx.logger.info(`创建版本：请求参数=> ${JSON.stringify(objParams)} `);
            let { min, max, platform, version } = objParams;
            let data = service.versionService.count({ platform, version });
            if (data) throw '该版本已存在哦';
            if (min) {
                await service.versionService.update({ min: true }, { min: false });
            }
            if (max) {
                await service.versionService.update({ max: true }, { max: false });
            }
            await service.versionService.create(objParams);
            ctx.logger.info(`创建版本：返回结果=> 成功`);
            ctx.respSuccess();
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/version/info 查询版本
     * @apiDescription 更新版本
     * @apiGroup 版本
     * @apiParam  {String} [id] 版本 id
     * @apiParam  {String} [version] 版本
     * @apiParam  {String} [platform] 平台[ android, iOS ]
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/version/info
     */
    async info () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                id: [ ],
                version: [ ],
                platform: [ ],
            });
            ctx.logger.info(`查询版本信息：请求参数=> ${JSON.stringify(objParams)} `);
            const data = await service.versionService.findById(objParams);
            ctx.logger.info(`查询版本信息：返回结果=> ${JSON.stringify(data)} `);
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/version/del 删除版本
     * @apiDescription 删除版本
     * @apiGroup 版本
     * @apiParam  {String} [id] 版本 id
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/version/del
     */
    async del () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                id: [ 'nonempty' ],
            });
            ctx.logger.info(`删除版本信息：请求参数=> ${JSON.stringify(objParams)} `);
            const data = await service.versionService.del(objParams);
            ctx.logger.info(`删除版本信息：返回结果=> 成功 `);
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/version/list 查询版本列表
     * @apiDescription 查询版本列表
     * @apiGroup APP基础
     * @apiParam  {String} [numIndex] 页数
     * @apiParam  {String} [numSize] 大小
     * @apiParam  {String} [keyword] 标题 / 时间
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/version/list
     */
    async list () {
        const { ctx, service, app } = this;
        try {
            const objParams = await ctx.validateBody({
                numIndex: [ 'nonempty' ],
                numSize: [ 'nonempty' ],
                version: [],
                platform: [],
            });
            const data = await service.versionService.list(objParams);
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/version/check 检测版本
     * @apiDescription 检测版本
     * @apiGroup 版本
     * @apiParam  {String} [platform] 平台
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/version/check
     */
    async check () {
        const { ctx, service, app } = this;
        try {
            let {
                platform,
            } = await ctx.validateBody({
                platform: [ 'nonempty', (v) => ['android', 'iOS'].indexOf(v) > -1 ],
            });
            ctx.logger.info(`检测版本信息：请求参数=> ${platform} `);
            // 查询最小版本
            const objMin = await service.versionService.findOne({
                platform,
                min: true,
            });
            // 查询最新版本
            const data = await service.versionService.findOne({
                platform,
                max: true,
            });
            if (data) {
                data.minVersion = objMin ? objMin.version : '';
            }
            ctx.logger.info(`检测版本信息：返回结果=> 成功 `);
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }


};
