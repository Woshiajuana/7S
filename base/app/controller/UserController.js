
'use strict';

const { Controller } = require('egg');

module.exports = class HandleController extends Controller {

    static route (app, middleware, controller) {
        app.router.mount('/api/v1/user/create', controller.create)
            .mount('/api/v1/user/update', controller.update)
            .mount('/api/v1/user/info', controller.info)
            .mount('/api/v1/user/one', controller.one)
            .mount('/api/v1/user/list', controller.list)
        ;
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/user/create 创建用户
     * @apiDescription 创建用户
     * @apiGroup 用户
     * @apiParam  {String} [email] 邮箱
     * @apiParam  {String} [password] 密码
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/user/create
     */
    async create () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                email: [ 'nonempty' ],
                password: [ 'nonempty' ],
            });
            ctx.logger.info(`创建用户：请求参数=> ${JSON.stringify({email: objParams.email})} `);
            await service.userService.create(objParams);
            ctx.logger.info(`创建用户：返回结果=> 成功`);
            ctx.respSuccess();
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/user/update 更新用户
     * @apiDescription 更新用户
     * @apiGroup 用户
     * @apiParam  {String} [id] 用户 id
     * @apiParam  {String} [nickname] 昵称
     * @apiParam  {String} [password] 密码
     * @apiParam  {String} [avatar] 头像
     * @apiParam  {String} [sex] 性别
     * @apiParam  {String} [signature] 个性签名
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/user/update
     */
    async update () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                id: ['nonempty'],
                nickname: [],
                password: [],
                avatar: [],
                sex: [],
                signature: [],
                disabled: [],
                lock: [],
            });
            await service.userService.update(objParams);
            ctx.respSuccess();
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/user/info  查询用户信息
     * @apiDescription 更新用户
     * @apiGroup 用户
     * @apiParam  {String} [id] 用户 id
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/user/info
     */
    async info () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                id: [ 'nonempty' ],
            });
            ctx.logger.info(`查询用户信息：请求参数=> ${JSON.stringify(objParams)} `);
            const data = await service.userService.findOne(objParams);
            ctx.logger.info(`查询用户信息：返回结果=> ${JSON.stringify(data)} `);
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/user/one  查询用户基本信息
     * @apiDescription 更新用户
     * @apiGroup 用户
     * @apiParam  {String} [id] 用户 id
     * @apiParam  {String} [email] 查询用户基本信息
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/user/one
     */
    async one () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                email: [ ],
            });
            ctx.logger.info(`查询用户基本信息：请求参数=> ${JSON.stringify(objParams)} `);
            const data = await service.userService.findOne(objParams);
            ctx.logger.info(`查询用户基本信息：返回结果=> ${JSON.stringify(data)} `);
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/user/list 查询用户列表
     * @apiDescription 查询用户列表
     * @apiGroup APP基础
     * @apiParam  {String} [numIndex] 页数
     * @apiParam  {String} [numSize] 大小
     * @apiParam  {String} [keyword] 邮箱 / 昵称
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/user/list
     */
    async list () {
        const { ctx, service, app } = this;
        try {
            const objParams = await ctx.validateBody({
                numIndex: [ 'nonempty' ],
                numSize: [ 'nonempty' ],
                keyword: [],
            });
            const data = await service.userService.list(objParams);
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

};
