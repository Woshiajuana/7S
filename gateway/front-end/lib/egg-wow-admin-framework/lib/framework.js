'use strict';

const path = require('path');
const egg = require('egg');
const EGG_PATH = Symbol.for('egg#eggPath');

class Application extends egg.Application {
    get [EGG_PATH]() {
        return path.dirname(__dirname);
    }
}

class Agent extends egg.Agent {
    get [EGG_PATH]() {
        return path.dirname(__dirname);
    }
}

class CurlService extends egg.Service {

    constructor(ctx, options = {}) {
        super(ctx);
        this.strName = options.name || this.constructor.name;
        this.options = Object.assign({}, ctx.app.config.curl[this.strName] || {}, options);
    }

    async afterRequest (response) {
        let {
            status,
            statusMessage,
            data,
        } = response;
        const strErrMsg = data.msg || data.message || statusMessage;
        if (status >= 300 || status < 200 || data.code !== 'S00000')
            throw `[${status}]：${strErrMsg}`;
        return response.data ? response.data.data : response;
    }

    async beforeRequest (options) {
        return options;
    }

    async curl (url, options) {
        options = Object.assign({
            method: 'POST',
            dataType: 'json',
            contentType: 'json',
            timeout: 30 * 1000,
        }, this.options, options);
        let {
            baseUrl,
            method,
            data,
        } = options = await this.beforeRequest(options);
        url = `${baseUrl}${url}`;
        this.logger.info(`[${this.strName}] => 调用服务:${url} 方式:${method} 请求参数:${JSON.stringify(data)}`);
        let response = await this.ctx.curl(url, options);
        if (response.status >= 300 || response.status < 200) {
            this.logger.info(`[${this.strName}] => 调用服务:${url} 方式:${method} 请求失败【${response.status}】结果: ${JSON.stringify(response)}`);
        } else {
            this.logger.info(`[${this.strName}] => 调用服务:${url} 方式:${method} 请求成功【${response.status}】结果: ${JSON.stringify(response.data)}`);
        }
        response = await this.afterRequest(response);
        return response;
    }
}

module.exports = Object.assign(egg, {
    Application,
    Agent,
    CurlService,
});
