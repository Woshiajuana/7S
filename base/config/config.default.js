/* eslint valid-jsdoc: "off" */

'use strict';

const path = require('path');

module.exports = appInfo => {

    const config = exports = {};

    // 端口
    config.cluster = {
        listen: {
            path: '',
            port: 10002,
            hostname: '0.0.0.0',
        }
    };

    // use for cookie sign key, should change to your own and keep security
    config.keys = appInfo.name + '_1557904782826_8085';

    // add your middleware config here
    config.middleware = [];

    // add cors
    config.cors = {
        origin: '*', // 访问白名单,根据你自己的需要进行设置
        allowMethods: 'GET,HEAD,PUT,POST,DELETE,PATCH'
    };

    // add mongoose
    config.mongoose = {
        url: 'mongodb://154.8.209.13:37017/qimiao',
        options: {
            user: '',
            pass: '',
        },
    };

    // add security
    config.security = {
        csrf: {
            enable: false,
        },
    };

    // add validate
    config.validate = {
        client: {
            regular: {},
        },
    };

    // add response
    config.response = {
        codes: {
            F00001: 'APP未设置，请先设置',
            F40000: 'TOKEN未设置',
            F40001: 'TOKEN无效，请重新登录',
            F40002: 'TOKEN已过期，请重新登录',
            F40003: '无权限访问，请联系管理员',
            F20001: '亲~您已经评价过了哦...',
        },
    };

    // normal oss bucket
    exports.oss = {
        client: {
            accessKeyId: 'LTAI4FvEhVK64GMNLnHprJfj',
            accessKeySecret: 'sTLXiroBfc0qyIs8Il69ascip2vRcj',
            bucket: 'h5-mk',
            endpoint: 'oss-cn-shanghai.aliyun.com',
            timeout: '60s',
        },
    };

    // add log
    config.logger = {
        level: 'INFO',
        dir: path.join(__dirname, '../logs/') // 保存路径为工程路径下`logs/prod/app`
    };

    return config;
};
