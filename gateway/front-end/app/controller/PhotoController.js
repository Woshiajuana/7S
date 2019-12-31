
'use strict';

const { Controller } = require('egg');
const moment = require('moment');

module.exports = class HandleController extends Controller {

    static route (app, middleware, controller) {
        app.router.mount('/api/v1/app/photo/list', middleware.tokenMiddleware(), controller.list)
            .mount('/api/v1/app/photo/create', middleware.tokenMiddleware(), controller.create)
            .mount('/api/v1/app/photo/del', middleware.tokenMiddleware(), controller.del)
            .mount('/api/v1/app/photo/update', middleware.tokenMiddleware(), controller.update)
            .mount('/api/v1/app/photo/info', middleware.tokenMiddleware(), controller.info)
            .mount('/api/v1/app/photo/recommend', middleware.tokenMiddleware(), controller.recommend)
        ;
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/app/photo/recommend 照片推荐列表
     * @apiDescription  照片模块
     * @apiGroup  文件
     * @apiParam  {String} [user] 用户 id
     * @apiParam  {String} [limit] 用户 限制
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/app/photo/recommend
     */
    async recommend () {
        const { ctx, service, app } = this;
        try {
            let {
                user,
                exclude,
                limit,
                useFollowing,
            } = await ctx.validateBody({
                user: [],
                exclude: [],
                limit: [ 'nonempty', (v) => v <= 20 && v > 0 ],
                useFollowing: [],
            });
            const { id } = ctx.state.token;
            let arrUser = [];
            if (useFollowing) {
                arrUser = await service.transformService.curl('api/v1/following/list', {
                    data: { user: id },
                });
                arrUser = arrUser.map((item) => item.following._id);
            }
            if (user) arrUser = [ user ];
            let data;
            if (useFollowing && !arrUser.length) {
                data = [];
            } else {
                data = await service.transformService.curl('api/v1/photo/recommend', {
                    data: Object.assign({
                        users: arrUser,
                        exclude,
                        limit,
                        useAppend: !useFollowing,
                    }, { nature: 'PUBLIC' }),
                });
            }
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }


    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/app/photo/list 照片列表
     * @apiDescription  照片模块
     * @apiGroup  文件
     * @apiParam  {String} [numIndex] 照片文件 页码
     * @apiParam  {String} [numSize] 照片文件 页数
     * @apiParam  {String} [startTime] 照片文件 开始时间
     * @apiParam  {String} [endTime] 照片文件 截止时间
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/app/photo/list
     */
    async list () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                numIndex: [ ],
                numSize: [ ],
                startTime: [],
                endTime: [],
                user: [],
            });
            const { id } = ctx.state.token;
            let { user } = objParams;
            let isSame = !user || id === user;
            const data = await service.transformService.curl('api/v1/photo/list', {
                data: Object.assign(objParams, { user: user || id }, isSame ? {} : { nature: 'PUBLIC' }),
            });
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }


    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/app/photo/create 照片上传
     * @apiDescription  照片上传
     * @apiGroup  照片
     * @apiParam  {String} [photo] 照片文件 id
     * @apiParam  {String} [title] 照片标题
     * @apiParam  {String} [nature] 照片性质
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/app/photo/create
     */
    async create () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                photo: [ 'nonempty' ],
                title: [ 'nonempty' ],
                nature: [ 'nonempty', (v) => [ 'PRIVACY', 'PUBLIC' ].indexOf(v) > -1 ],
                created_at: [ (v) => !v || new Date(v).getTime() < new Date().getTime() ],
            });
            const { id: user } = ctx.state.token;
            let { created_at } = objParams;
            let startTime = `${moment().format('YYYY-MM-DD')} 00:00:00`;
            let endTime = `${moment().format('YYYY-MM-DD')} 23:59:59`;
            if (created_at) {
                startTime = `${moment(created_at).format('YYYY-MM-DD')} 00:00:00`;
                endTime = `${moment(created_at).format('YYYY-MM-DD')} 23:59:59`;
            }
            let data = await service.transformService.curl('api/v1/photo/list', {
                data: { user, startTime, endTime },
            });
            if (data.length) throw '这天已有作品了哦';
            data = await service.transformService.curl('api/v1/photo/create', {
                data: { user, ...objParams },
            });
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/app/photo/info 照片详情
     * @apiDescription  照片模块
     * @apiGroup  文件
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/app/photo/info
     */
    async info () {
        const { ctx, service, app } = this;
        try {
            let {
                id,
            } = await ctx.validateBody({
                id: [ 'nonempty' ],
            });
            const { id: user } = ctx.state.token;
            const data = await service.transformService.curl('api/v1/photo/info', {
                data: { id },
            });
            const { user: author } = data;
            let isSame = !author || author === user;
            if (!isSame && data.nature !== 'PUBLIC')
                throw '哦豁...不能查看哦';
            data.volume++;
            await service.transformService.curl('api/v1/photo/update', {
                data: { id, volume: data.volume },
            });
            data.user = await service.transformService.curl('api/v1/user/info', {
                data: { id: data.user },
            });
            if (user !== author) {
                const objFollow = await service.transformService.curl('api/v1/following/info', {
                    data: { user, following: author },
                });
                data.user.follower = objFollow ? objFollow._id : '';
            }
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/app/photo/del 照片删除
     * @apiDescription  照片模块
     * @apiGroup  文件
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/app/photo/del
     */
    async del () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                id: [ 'nonempty' ],
            });
            const { id: user } = ctx.state.token;
            await service.transformService.curl('api/v1/photo/del', {
                data: { user, ...objParams },
            });
            ctx.respSuccess();
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/app/photo/update 照片更新
     * @apiDescription  照片模块
     * @apiGroup  文件
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/app/photo/update
     */
    async update () {
        const { ctx, service, app } = this;
        try {
            let objParams = await ctx.validateBody({
                id: [ 'nonempty' ],
                photo: [ 'nonempty' ],
                title: [ 'nonempty' ],
                nature: [ 'nonempty', (v) => [ 'PRIVACY', 'PUBLIC' ].indexOf(v) > -1 ],
            });
            const { id: user } = ctx.state.token;
            const data = await service.transformService.curl('api/v1/photo/update', {
                data: { user, ...objParams },
            });
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }
};
