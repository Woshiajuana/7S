/* eslint valid-jsdoc: "off" */

'use strict';

const path = require('path');

module.exports = appInfo => {

    const config = exports = {};

    // use for cookie sign key, should change to your own and keep security
    config.keys = appInfo.name + '_1557904782826_8085';

    // add your middleware config here
    config.middleware = [];

    // add cors
    config.cors = {
        origin: '*', // 访问白名单,根据你自己的需要进行设置
        allowMethods: 'GET,HEAD,PUT,POST,DELETE,PATCH'
    };

    // add redis
    config.redis = {
        client: {
            host: '154.8.209.13',
            port: '36379',
            db: '5',
            family: 'IPv4',
            password: '123456',
        },
    };

    // add email
    config.email = {
        client: {
            host: 'smtp.mxhichina.com', // 主机
            secureConnection: true, // 使用 SSL
            port: 465, // SMTP 端口
            auth: {
                user: 'zhigang.chen@owulia.com',
                pass: 'liujiaoyan1120/',
            },
        },
    };

    // add mongoose
    config.mongoose = {
        url: 'mongodb://154.8.209.13:37017/wow_admin',
        // url: 'mongodb://154.8.209.13:37017/fqa_gateway',
        options: {
            user: '',
            pass: '',
        },
    };

    // add token
    exports.token = {
        secret: 'wowadminajuan',
        maxAge: '100m',
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
            // F40004: '',
            F40005: '你的账号已被禁用，请联系管理员',
            F40006: '你的账号已被锁定，请联系管理员',
        },
    };

    // add auth 用户登录时验证最大次数
    config.auth = {
        maxTimes: 10,
    };

    // add curl
    config.curl = {
        TransFormService: {
            name: '转发 DEMO 服务器示例',
            baseUrl: 'http://127.0.0.1:7001/',
        }
    };

    // add log
    config.logger = {
        level: 'INFO',
        dir: path.join(__dirname, '../logs/') // 保存路径为工程路径下`logs/prod/app`
    };

    return config;
};
