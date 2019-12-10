'use strict';


const Client = require('ftp');

function createClient(config, app) {
    return {
        put () {
            console.log('ftp put')
        }
    }
    // return {new Validate(app, config)};
}

module.exports = app => {
    app.addSingleton('ftp', createClient);
};
