'use strict';

const validate = require('./lib/validate');

module.exports = app => {
    if (app.config.validate.app) validate(app);
};

