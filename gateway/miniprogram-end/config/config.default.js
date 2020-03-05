/* eslint valid-jsdoc: "off" */

'use strict';

const path = require('path');

module.exports = appInfo => {

    const config = exports = {};

    // 端口
    config.cluster = {
        listen: {
            path: '',
            port: 9004,
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

    // add redis
    config.redis = {
        client: {
            host: '154.8.209.13',
            port: '36379',
            db: '3',
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

    // add token
    config.token = {
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
        maxTimes: 5,
    };

    // add curl
    config.curl = {
        TransformService: {
            name: '转发 DEMO 服务器示例',
            baseUrl: 'http://127.0.0.1:10002/',
        },
        WxTransformService: {
            name: '微信',
            baseUrl: 'https://api.weixin.qq.com/',
        },
    };

    // normal oss bucket
    config.oss = {
        client: {
            accessKeyId: 'LTAI4FvEhVK64GMNLnHprJfj',
            accessKeySecret: 'sTLXiroBfc0qyIs8Il69ascip2vRcj',
            bucket: 'h5-mk',
            endpoint: 'oss-cn-shanghai.aliyuncs.com',
            timeout: '60s',
            rootDir: 'qimiao',
        },
    };

    // 文件
    config.multipart = {
        mode: 'file',
        fileExtensions: [
            '.jpg',
            '.jpeg',
            '.png',
            '.gif',
            '.xls',
            '.xlsx',
            '.txt',
            '.7z',
            '.rar',
            '.zip',

            '.apk',
            '.js',
            '.crx',

            /* 公钥私钥文件格式*/
            '.cer',
            '.crt',
            '.key',
            '.csr',
            '.der',
            '.store',
            '.pfx',
            '.pem',
            '.p12',
            '.properties',
            '.json',
            '.crl',
            '.jks',
            '.csv',
        ],
    };

    // add ftp
    config.ftp = {
        client: {
            host: '154.8.209.13',
            port: '21',
            user: 'ftp',
            password: 'ftpliujiaoyan1120',
            rootDir: 'qimiao',
            baseUrl: 'http://154.8.209.13:40002/'
        },
    };

    // add log
    config.logger = {
        level: 'INFO',
        dir: path.join(__dirname, '../logs/') // 保存路径为工程路径下`logs/prod/app`
    };

    return config;
};
