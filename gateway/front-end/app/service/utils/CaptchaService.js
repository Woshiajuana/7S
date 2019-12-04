
'use strict';

const { Service } = require('egg');
const CaptchaPng = require('captchapng');
const ms = require('ms');

module.exports = class TransFormService extends Service {

    // 生成图形验证码
    async generate (key) {
        const { redis } = this.app;
        let strCaptcha = randomNum(6);
        let captchaPng = new CaptchaPng(80, 30, strCaptcha);
        captchaPng.color(255, 255, 255, 0);
        captchaPng.color(80, 80, 80, 255);
        let data = captchaPng.getBase64();
        await redis.set(`${key} captcha`, strCaptcha, 'PX', ms('5m'));
        return data;
    }

    // 验证图形验证码
    async validate (key, captcha) {
        const { redis } = this.app;
        let strCaptcha = await redis.get(`${key} captcha`);
        return strCaptcha === captcha;
    }

};

function randomNum (len) {
    let result = '';
    while (len > 0) {
        len--;
        result += Math.floor(Math.random() * 10)
    }
    return result;
}
