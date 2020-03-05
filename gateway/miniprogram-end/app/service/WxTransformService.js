
'use strict';

const { CurlService } = require('egg');

module.exports = class WxTransformService extends CurlService {

    constructor (ctx) {
        super(ctx);
    }

    async afterRequest (response) {
        const {
            status,
            statusMessage,
            data,
        } = response;
        const {
            errcode,
            errmsg,
        } = data || {};
        const objErrMsg = {
            '-1': '系统繁忙，请稍候再试',
            '40029': 'CODE无效',
            '45011': '请求频繁，请稍后再试',
        };
        if (status >= 300 || status < 200 || errcode)
            throw `[${status}]：${objErrMsg[errcode] || errmsg || statusMessage}`;
        return data ? data : response;
    }

    async beforeRequest (options) {
        return options;
    }

};
