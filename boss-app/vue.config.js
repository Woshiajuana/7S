'use strict';

const path = require('path');

function resolve(dir) {
    return path.join(__dirname, dir);
}

// 具体配置参数 https://cli.vuejs.org/config/
module.exports = {
    publicPath: './',
    // outputDir: 'dist',
    // assetsDir: 'static',
    lintOnSave: false,
    productionSourceMap: false,
    configureWebpack: {
        name: 'Wow-Admin',
        resolve: {
            alias: {
                '@': resolve('src'),
                '@components': resolve('src/components'),
                '@router': resolve('src/router'),
                '@store': resolve('src/store'),
                '@layout': resolve('src/layout'),
                '@assets': resolve('src/assets'),
                '@views': resolve('src/views'),
                '@utils': resolve('src/utils'),
            }
        }
    },
    chainWebpack (config) {
        config.module
            .rule('svg')
            .exclude.add(resolve('src/assets/icons'))
            .end();
        config.module
            .rule('icons')
            .test(/\.svg$/)
            .include.add(resolve('src/assets/icons'))
            .end()
            .use('svg-sprite-loader')
            .loader('svg-sprite-loader')
            .options({
                symbolId: 'icon-[name]'
            })
            .end();
    },
};
