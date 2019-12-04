
'use strict';

const { Controller } = require('egg');

module.exports = class HandleController extends Controller {

    static route (app, middleware, controller) {
        app.router.mount('/api/v1/user/create', controller.create)
            .mount('/api/v1/user/update', controller.update)
            .mount('/api/v1/user/info', controller.info)
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
            await service.userService.create(objParams);
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
                id: [],
                nickname: [] ,
                password: [] ,
                avatar: [] ,
                sex: [] ,
                signature: [] ,
            });
            await service.userService.update(objParams);
            ctx.respSuccess();
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/user/info  查询用户
     * @apiDescription 更新用户
     * @apiGroup 用户
     * @apiParam  {String} [id] 用户 id
     * @apiParam  {String} [email] 用户邮箱
     * @apiParam  {String} [uid] 7S-ID
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/user/info
     */
    async info () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                id: [ ],
                email: [ ],
                uid: [ ],
            });
            await service.userService.findOne(objParams);
            ctx.respSuccess();
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
     * @apiParam  {String} [keyword] 邮箱 / 昵称 / uid
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
