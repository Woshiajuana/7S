'use strict';

const path = require('path');

// redis
exports.redis = {
    enable: true,
    package: 'egg-redis',
};

// 跨域
exports.cors = {
    enable: true,
    package: 'egg-cors',
};

// token
exports.token = {
    enable: true,
    package: 'egg-wow-token',
    // path: path.join(__dirname, '../lib/egg-wow-token')
};

// 验证参数
exports.validate = {
    enable: true,
    package: 'egg-wow-validate',
    // path: path.join(__dirname, '../lib/egg-wow-validate')
};

// 响应
exports.response = {
    enable: true,
    package: 'egg-wow-response',
    // path: path.join(__dirname, '../lib/egg-wow-response')
};
