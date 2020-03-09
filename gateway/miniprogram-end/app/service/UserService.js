
'use strict';

const { Service } = require('egg');
const crypto = require('crypto');

module.exports = class UserService extends Service {
    // 解密UnionID
    async decryptData (options) {
        let {
            appId,
            sessionKey,
            encryptedData,
            iv,
        } = options;
        // base64 decode
        sessionKey = new Buffer(sessionKey, 'base64');
        encryptedData = new Buffer(encryptedData, 'base64');
        iv = new Buffer(iv, 'base64');
        let decoded = '';
        try {
            // 解密
            let decipher = crypto.createDecipheriv('aes-128-cbc', sessionKey, iv);
            // 设置自动 padding 为 true，删除填充补位
            decipher.setAutoPadding(true);
            decoded = decipher.update(encryptedData, 'binary', 'utf8');
            decoded += decipher.final('utf8');
            decoded = JSON.parse(decoded);
        } catch (err) {
            throw new Error('Illegal Buffer')
        }
        if (decoded.watermark.appid !== appId) {
            throw new Error('Illegal Buffer')
        }
        return decoded
    }
};
