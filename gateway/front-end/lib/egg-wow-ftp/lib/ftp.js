'use strict';

const Client = require('ftp');

function createClient(config, app) {
    if (!app.ftp) {
        const ftp = new Client();
        ftp.connect(config);
        ftp.on('ready', () => {
            this.app.logger.info(`[egg-wow-ftp] connect success`);
        });
        ftp.tryDir = (path) => new Promise((resolve, reject) => {
            path = path.substr(0, path.lastIndexOf('/'));
            ftp.list(path, (err, list) => {
                if (err) return reject(err);
                if (!list) return resolve();
                ftp.mkdir(path, true, (err) => {
                    err ? reject(err) : resolve();
                });
            });
        });
        ftp.putPlus = (input, output) => new Promise(async (resolve, reject) => {
            await ftp.tryDir(output);
            ftp.put(input, output, (err) => {
                // ftp.end();
                err ? reject(err) : resolve();
            });
        });
        return ftp;
    }
    return app.ftp;
}

module.exports = app => {
    app.addSingleton('ftp', createClient);
};
