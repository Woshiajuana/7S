'use strict';

const path = require('path');

// 跨域
exports.cors = {
    enable: true,
    package: 'egg-cors',
};

// 数据库mongoose
exports.mongoose = {
    enable: true,
    package: 'egg-mongoose',
};

// 验证参数
exports.validate = {
    enable: true,
    package: 'egg-wow-validate',
};

// 响应
exports.response = {
    enable: true,
    package: 'egg-wow-response',
};
