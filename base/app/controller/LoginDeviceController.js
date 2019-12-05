
'use strict';

const { Controller } = require('egg');

module.exports = class HandleController extends Controller {

    static route (app, middleware, controller) {
        app.router.mount('/api/v1/login-device/create', controller.create)
            .mount('/api/v1/login-device/info', controller.info)
            .mount('/api/v1/login-device/list', controller.list)
            .mount('/api/v1/login-device/del', controller.del)
        ;
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/login-device/create 创建登录设备
     * @apiDescription 创建登录设备
     * @apiGroup 登录设备
     * @apiParam  {String} [user] 用户 id
     * @apiParam  {String} [device] 设备信息
     * @apiParam  {String} [remark] 备注
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/login-device/create
     */
    async create () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                user: [ 'nonempty' ],
                device: [ 'nonempty' ],
                remark: [],
            });
            ctx.logger.info(`创建登录设备：请求参数=> ${JSON.stringify(objParams)} `);
            await service.loginDeviceService.create(objParams);
            ctx.logger.info(`创建登录设备：返回结果=> 成功`);
            ctx.respSuccess();
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/login-device/info 查询登录设备
     * @apiDescription 更新登录设备
     * @apiGroup 登录设备
     * @apiParam  {String} [user] 用户 id
     * @apiParam  {String} [device] 设备信息
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/login-device/info
     */
    async info () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                user: [ 'nonempty' ],
                device: [ 'nonempty' ],
            });
            ctx.logger.info(`查询登录设备信息：请求参数=> ${JSON.stringify(objParams)} `);
            const data = await service.loginDeviceService.findOne(objParams);
            ctx.logger.info(`查询登录设备信息：返回结果=> ${JSON.stringify(data)} `);
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/login-device/del 删除登录设备
     * @apiDescription 删除登录设备
     * @apiGroup 登录设备
     * @apiParam  {String} [user] 用户 id
     * @apiParam  {String} [device] 设备信息
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/login-device/del
     */
    async del () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                user: [ 'nonempty' ],
                device: [ 'nonempty' ],
            });
            ctx.logger.info(`删除登录设备信息：请求参数=> ${JSON.stringify(objParams)} `);
            const data = await service.loginDeviceService.del(objParams);
            ctx.logger.info(`删除登录设备信息：返回结果=> 成功 `);
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/login-device/list 查询登录设备列表
     * @apiDescription 查询登录设备列表
     * @apiGroup APP基础
     * @apiParam  {String} [numIndex] 页数
     * @apiParam  {String} [numSize] 大小
     * @apiParam  {String} [user] 用户 id
     * @apiParam  {String} [device] 设备信息
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/login-device/list
     */
    async list () {
        const { ctx, service, app } = this;
        try {
            const objParams = await ctx.validateBody({
                numIndex: [ 'nonempty' ],
                numSize: [ 'nonempty' ],
                user: [ ],
                device: [ ],
            });
            const data = await service.loginDeviceService.list(objParams);
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

};
