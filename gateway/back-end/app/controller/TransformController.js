
'use strict';

const { Controller } = require('egg');

module.exports = class HandleController extends Controller {

    static route (app, middleware, controller) {
        app.router.mount(
            { name: '7S后台管理', path: '/boss/*' },
            middleware.tokenMiddleware(),
            middleware.authMiddleware(),
            controller.transform,
        );
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /boss/* 7S后台管理 分发路由
     * @apiDescription 7S后台管理 分发路由
     * @apiGroup APP基础
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /boss/*
     */
    async transform () {
        const { ctx, service, app } = this;
        try {
            const {
                params,
                method = '',
                request,
            } = ctx;
            const strTargetUrl = params[0] || '';
            const data = await service.transformService.curl(strTargetUrl,  {
                method,
                data: method === 'get' ? request.query : request.body,
            });
            ctx.respSuccess(data);
        } catch (err) {
            ctx.respError(err);
        }
    }

};
