
'use strict';

const { Controller } = require('egg');

module.exports = class HandleController extends Controller {

    static route (app, middleware, controller) {
        app.router.mount('/api/v1/app/user/login', controller.login)
            .mount('/api/v1/app/user/register', controller.register)
            .mount('/api/v1/app/user/info', middleware.tokenMiddleware(), controller.info)
            .mount('/api/v1/app/user/update', middleware.tokenMiddleware(), controller.update)
        ;

    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/app/user/login 用户登录
     * @apiDescription  User 用户模块
     * @apiGroup 用户
     * @apiParam  {String} [account] 账号
     * @apiParam  {String} [password] 密码
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/app/user/login
     */
    async login () {
        const { ctx, service, app } = this;
        try {
            let {
                redis,
                config,
            } = app;
            let {
                maxTimes,
            } = config.auth;
            let {
                account,
                password,
                captcha,
            } = await ctx.validateBody({
                account: [ 'nonempty' ],
                password: [ 'nonempty' ],
                captcha: [ ],
            });
            // 首先判断密码验证次数
            let numTimes = +(await redis.get(`${account} auth password times`) || 0);
            if (numTimes >= maxTimes) {
                if (!(await service.captchaService.validate(account, captcha))) {
                    throw { code: 'F50001', data: await service.captchaService.generate(account), msg: '图形验证码错误' }
                }
                await redis.del(`${account} auth password times`);
            }
            ctx.logger.info(`用户登录，查询是否有该用户：请求参数=> ${account}`);
            let objUser = await service.transformService.curl('api/v1/user/one', {
                data: { email: account },
            });
            if (!objUser) {
                ctx.logger.info(`用户登录，查询是否有该用户：返回结果=> 无该账号`);
                throw '账号不存在';
            }
            let { _id, password: pwd, disabled, lock } = objUser;
            if (disabled) {
                ctx.logger.info(`用户登录，账号已禁用：用户账号=> ${account}`);
                throw '账号已禁用';
            }
            if (lock) {
                ctx.logger.info(`用户登录，账号已锁定：用户账号=> ${account}`);
                throw '账号已锁定';
            }
            if (password !== pwd) {
                ctx.logger.info(`用户登录，密码错误：用户账号=> ${account}`);
                await redis.set(`${account} auth password times`, ++numTimes);
                throw numTimes >= maxTimes ? { code: 'F50001', data: await service.captchaService.generate(account), msg: '密码错误次数过多，请输入图形验证码' } : '密码输入错误';
            }
            delete objUser.password;
            const { accessToken } = await ctx.generateToken({ id: _id, user: objUser });
            objUser.accessToken = accessToken;
            await ctx.kickOutUserById(_id);
            ctx.respSuccess(objUser);
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/app/user/register 用户注册
     * @apiDescription  User 用户模块
     * @apiGroup 用户
     * @apiParam  {String} [email] 账号
     * @apiParam  {String} [password] 密码
     * @apiParam  {String} [code] 验证码
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/app/user/register
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
     * @api {get} /api/app/user/info 用户信息
     * @apiDescription  User 用户信息
     * @apiGroup 用户
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/app/user/info
     * */
    async info () {
        const { ctx, service } = this;
        try {
            const { id } = ctx.state.token;
            ctx.logger.info(`用户信息：请求参数=> ${id}`);
            const data = await service.transformService.curl('api/v1/user/info', {
                data: { id },
            });
            ctx.logger.info(`用户信息：请求返回=> ${data}`);
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/app/user/update 用户修改信息
     * @apiDescription  User 用户模块
     * @apiGroup 用户
     * @apiParam  {String} [nickname] nickname
     * @apiParam  {String} [password] password
     * @apiParam  {String} [avatar] avatar
     * @apiParam  {String} [sex] sex
     * @apiParam  {String} [signature] signature
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/app/user/update
     * */
    async update () {
        const { ctx, service } = this;
        try {
            let objParams = await ctx.validateBody({
                nickname: [],
                password: [],
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

};
