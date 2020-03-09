'use strict';

/**
 * jwt default config
 * @author Ajuan <979703986@qq.com>
 * @member Config#jwt
 * @property {String} SOME_KEY - some description
 */
exports.token = {
    maxAge: '5m',
    secret: '123456',
    maxUser: 1,
    getClientInfo (ctx) {
        const { request, ips = [], ip = '' } = ctx;
        const deviceUUID = request.headers['device-uuid'] || '';
        const userAgent = ctx.get('user-agent') || '';
        const ipAddress = ips && ips.length ? ips.join('-') : ip || '';
        console.log('ipAddress => ', ipAddress);
        console.log('userAgent => ', userAgent);
        console.log('deviceUUID => ', deviceUUID);
        return `${ipAddress}:${userAgent}:${deviceUUID}`;
    }
};
