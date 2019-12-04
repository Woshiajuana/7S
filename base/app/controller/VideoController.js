
'use strict';

const { Controller } = require('egg');

module.exports = class HandleController extends Controller {

    static route (app, middleware, controller) {
        app.router.mount('/api/v1/video/create', controller.create)
            .mount('/api/v1/video/update', controller.update)
            .mount('/api/v1/video/info', controller.info)
            .mount('/api/v1/video/list', controller.list)
        ;
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/user/create 创建视频
     * @apiDescription 创建视频
     * @apiGroup 视频
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
            ctx.logger.info(`创建视频：请求参数=> ${JSON.stringify({email: objParams.email})} `);
            await service.userService.create(objParams);
            ctx.logger.info(`创建视频：返回结果=> 成功`);
            ctx.respSuccess();
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/user/update 更新视频
     * @apiDescription 更新视频
     * @apiGroup 视频
     * @apiParam  {String} [id] 视频 id
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
     * @api {get} /api/v1/user/info  查询视频
     * @apiDescription 更新视频
     * @apiGroup 视频
     * @apiParam  {String} [id] 视频 id
     * @apiParam  {String} [email] 视频邮箱
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
            ctx.logger.info(`查询视频信息：请求参数=> ${JSON.stringify(objParams)} `);
            const data = await service.userService.findOne(objParams);
            ctx.logger.info(`查询视频信息：返回结果=> ${JSON.stringify(data)} `);
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/user/list 查询视频列表
     * @apiDescription 查询视频列表
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
