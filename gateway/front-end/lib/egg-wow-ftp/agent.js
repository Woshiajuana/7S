'use strict';

const ftp = require('./lib/ftp');

module.exports = agent => {
    const useAgent = agent.config.ftp.useAgent;
    if (useAgent) {
        ftp(agent);
    }
};
