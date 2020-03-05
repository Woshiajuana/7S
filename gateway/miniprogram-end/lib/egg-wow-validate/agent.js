'use strict';

const validate = require('./lib/validate');

module.exports = agent => {
    if (agent.config.validate.agent) validate(agent);
};
