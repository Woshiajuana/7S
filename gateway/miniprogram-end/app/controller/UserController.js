
'use strict';

const { Controller } = require('egg');

module.exports = class HandleController extends Controller {

    static route (app, middleware, controller) {
        app.router.mount('/api/v1/wx/user/login', controller.login)
            .mount('/api/v1/wx/user/register', controller.register)
            .mount('/api/v1/wx/user/info', middleware.tokenMiddleware(), controller.info)
            .mount('/api/v1/wx/user/update', middleware.tokenMiddleware(), controller.update)
            .mount('/api/v1/wx/user/change/password', middleware.tokenMiddleware(), controller.changePassword)
            .mount('/api/v1/wx/user/reset/password', controller.resetPassword)
            .mount('/api/v1/wx/user/reset/captcha', controller.resetCaptcha)
        ;

    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/wx/user/login 用户登录
     * @apiDescription  User 用户模块
     * @apiGroup 用户
     * @apiParam  {String} [account] 账号
     * @apiParam  {String} [password] 密码
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/wx/user/login
     */
    async login () {
        const { ctx, service, app } = this;
        try {
            let {
                code,
                encryptedData,
                iv,
            } = await ctx.validateBody({
                code: [ 'nonempty' ],
                iv: [ 'nonempty' ],
                encryptedData: [ 'nonempty' ],
                avatarUrl: [ 'nonempty' ],
                nickName: [ 'nonempty' ],
                city: [ ],
                country: [ ],
                gender: [ ],
                language: [ ],
                province: [ ],
            });
            const {
                session_key,
            } = await service.wxTransformService.curl('sns/jscode2session', {
                method: 'GET',
                data: {
                    appid: 'wxc571b8a3f4169f60',
                    secret: 'd2fe0262a7f752e3035baaf89c82723c',
                    js_code: code,
                    grant_type: 'authorization_code',
                },
            });
            const data = await service.userService.decryptData({
                appId: 'wxc571b8a3f4169f60',
                sessionKey: session_key,
                encryptedData,
                iv,
            });
            let objUser = await service.transformService.curl('api/v1/user/wx/login', { data });
            const { accessToken } = await ctx.generateToken({ id: objUser._id, user: objUser });
            objUser.accessToken = accessToken;
            await ctx.kickOutUserById(objUser._id);
            ctx.respSuccess(objUser);
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/wx/user/register 用户注册
     * @apiDescription  User 用户模块
     * @apiGroup 用户
     * @apiParam  {String} [email] 账号
     * @apiParam  {String} [password] 密码
     * @apiParam  {String} [captcha] 验证码
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/wx/user/register
     * */
    async register () {
        const { ctx, service } = this;
        try {
            let {
                email,
                password,
                captcha,
            } = await ctx.validateBody({
                email: [ 'nonempty' ],
                password: [ 'nonempty' ],
                captcha: [ 'nonempty' ],
            });
            ctx.logger.info(`用户注册，验证邮箱验证码：请求参数=> email: ${email} captcha: ${captcha}`);
            await service.emailService.validate({email, template: '1', captcha});
            ctx.logger.info(`用户注册，查询邮箱是否已注册：请求参数=> ${email}`);
            const data = await service.transformService.curl('api/v1/user/one', {
                data: { email },
            });
            if (data) {
                ctx.logger.info(`用户注册，查询邮箱是否已注册：请求结果=> 已注册 ${JSON.stringify(data)}`);
                throw '该邮箱已注册';
            }
            ctx.logger.info(`用户注册：请求参数=> ${email}`);
            await service.transformService.curl('api/v1/user/create', {
                data: { email, password },
            });
            ctx.logger.info(`用户注册：请求返回=> 注册成功`);
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/wx/user/info 用户信息
     * @apiDescription  User 用户信息
     * @apiGroup 用户
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/wx/user/info
     * */
    async info () {
        const { ctx, service } = this;
        try {
            let {
                id,
            } = await ctx.validateBody({
                id: [],
            });

            const { id: user } = ctx.state.token;
            let isSame = !id || id === user;
            ctx.logger.info(`用户信息：请求参数=> ${id || user}`);
            const data = await service.transformService.curl('api/v1/user/info', {
                data: Object.assign({ id: id || user }, isSame ? {} : { nature: 'PUBLIC' }),
            });
            // 当查询不是自己下信息是需要查询下是否有关注信息
            if (!isSame) {
                const objFollow = await service.transformService.curl('api/v1/following/info', {
                    data: { user, following: id },
                });
                data.follower = objFollow ? objFollow._id : '';
            }
            ctx.logger.info(`用户信息：请求返回=> ${data}`);
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/wx/user/update 用户修改信息
     * @apiDescription  User 用户模块
     * @apiGroup 用户
     * @apiParam  {String} [nickname] nickname
     * @apiParam  {String} [avatar] avatar
     * @apiParam  {String} [sex] sex
     * @apiParam  {String} [signature] signature
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/wx/user/update
     * */
    async update () {
        const { ctx, service } = this;
        try {
            let objParams = await ctx.validateBody({
                nickname: [],
                avatar: [],
                sex: [],
                signature: [],
            });
            const { id } = ctx.state.token;
            ctx.logger.info(`用户修改信息：请求参数=> ${JSON.stringify(objParams)}`);
            await service.transformService.curl('api/v1/user/update', {
                data: { ...objParams, id },
            });
            ctx.logger.info(`用户修改信息：请求返回=> 修改成功`);
            ctx.respSuccess();
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/wx/user/change/password 用户修改密码
     * @apiDescription  User 用户模块
     * @apiGroup 用户
     * @apiParam  {String} [password]  新密码
     * @apiParam  {String} [oldPassword] 旧密码
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/wx/user/change/password
     * */
    async changePassword () {
        const { ctx, service } = this;
        try {
            let {
                password,
                oldPassword,
            } = await ctx.validateBody({
                password: [ 'nonempty' ],
                oldPassword: [ 'nonempty' ],
            });
            const { id } = ctx.state.token;
            let objUser = await service.transformService.curl('api/v1/user/one', {
                data: { id: id },
            });
            let { password: pwd } = objUser;
            if (pwd !== oldPassword) throw '密码不正确';
            await service.transformService.curl('api/v1/user/update', {
                data: { password, id },
            });
            ctx.respSuccess();
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/wx/user/reset/password 用户重置密码
     * @apiDescription  User 用户模块
     * @apiGroup 用户
     * @apiParam  {String} [password] 密码
     * @apiParam  {String} [captcha] 验证码
     * @apiParam  {String} [email]  邮箱
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/wx/user/reset/password
     * */
    async resetPassword () {
        const { ctx, service } = this;
        try {
            let objParams = await ctx.validateBody({
                email: [ 'nonempty' ],
                password: [ 'nonempty' ],
                captcha: [ 'nonempty' ],
            });
            await service.emailService.validate({ ...objParams, template: '2' });
            await service.transformService.curl('api/v1/user/update', {
                data: objParams,
            });
            ctx.respSuccess();
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     *
     * */
    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/wx/user/reset/captcha 用户重置图形验证码
     * @apiDescription  User 用户模块
     * @apiGroup 用户
     * @apiParam  {String} [account]  邮箱账号
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/wx/user/reset/captcha
     * */
    async resetCaptcha () {
        const { ctx, service } = this;
        try {
            let {
                account,
            } = await ctx.validateBody({
                account: [ 'nonempty' ],
            });
            const data = await service.captchaService.generate(account);
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }
};
