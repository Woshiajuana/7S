'use strict';

const Client = require('ftp');

function createClient(config, app) {
    return {
        put: (input, output) => new Promise((resolve, reject) => {
            const client = new Client();
            client.on('ready', () => {
                let path = output.substr(0, output.lastIndexOf('/'));
                client.get(path, (err) => {
                    if (err) {
                        client.mkdir(path, true, (err) => {
                            err ? reject(err) : client.put(input, output, (err) => {
                                client.end();
                                err ? reject(err) : resolve();
                            });
                        });
                    } else {
                        client.put(input, output, (err) => {
                            client.end();
                            err ? reject(err) : resolve();
                        });
                    }
                })
            });
            client.on('error', (err) => {
                console.log(err);
                client.end();
            });
            client.connect(config);
        }),
    };
}

module.exports = app => {
    app.addSingleton('ftp', createClient);
};
