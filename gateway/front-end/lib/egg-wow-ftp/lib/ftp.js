'use strict';


const Client = require('ftp');

function createClient(config, app) {
    const ftp = new Client();
    ftp.connect(config);
    ftp.on('ready', () => {
        this.app.logger.info(`[egg-wow-ftp] connect success`);
    });
    return ftp;
}

module.exports = app => {
    app.addSingleton('ftp', createClient);
};
