
'use strict';

const { Controller } = require('egg');

module.exports = class HandleController extends Controller {

    static route (app, middleware, controller) {
        app.router.mount('/api/v1/application/list', controller.list)
            .mount('/api/v1/application/create', controller.create)
            .mount('/api/v1/application/update', controller.update)
            .mount('/api/v1/application/delete', controller.del)
        ;
    }


};
