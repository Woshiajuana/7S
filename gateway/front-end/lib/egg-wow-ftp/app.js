'use strict';

const ftp = require('./lib/ftp');

module.exports = app => {
    ftp(app);
};
