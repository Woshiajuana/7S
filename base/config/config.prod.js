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

    // add mongoose
    config.mongoose = {
        url: 'mongodb://154.8.209.13:37017/qimiao',
        options: {
            user: '',
            pass: '',
        },
    };

    // add log
    config.logger = {
        level: 'INFO',
        dir: '/workspace-logs/7S/base-service/' // 保存路径为工程路径下`logs/prod/app`
    };

    return config;
};
