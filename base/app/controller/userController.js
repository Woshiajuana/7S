
'use strict';

const { Controller } = require('egg');

module.exports = class HandleController extends Controller {

    static route (app, middleware, controller) {
        app.router.mount('/api/v1/user/create', controller.create),
        app.router.mount('/api/v1/user/update', controller.update)
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

    




};
