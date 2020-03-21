
'use strict';

const { Controller } = require('egg');

module.exports = class HandleController extends Controller {

    static route (app, middleware, controller) {
        app.router.mount('/api/v1/wx/search/preview', middleware.tokenMiddleware({ mode: 'lazy' }), controller.preview)
        ;
    }

    /**
     * @apiVersion 1.0.0
     * @api {get} /api/v1/wx/user/change/password 用户修改密码
     * @apiDescription  User 用户模块
     * @apiGroup 用户
     * @apiParam  {String} [password]  新密码
     * @apiParam  {String} [oldPassword] 旧密码
     * @apiSuccess (成功) {Object} data
     * @apiSampleRequest /api/v1/app/user/change/password
     * */
    async preview () {
        const { ctx, service } = this;
        try {
            const objParams = await ctx.validateBody({
                keyword: [ 'nonempty' ],
                numIndex: [ ],
                numSize: [ ],
            });
            const arrPhoto = await service.transformService.curl('api/v1/photo/list', {
                data: objParams,
            });
            ctx.respSuccess(arrPhoto);
        } catch (err) {
            ctx.respError(err);
        }
    }

};
