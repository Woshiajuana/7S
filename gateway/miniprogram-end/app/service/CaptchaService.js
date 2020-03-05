
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
        const data = captchaPng.getBase64();
        await redis.set(`${key} captcha`, strCaptcha, 'PX', ms('5m'));
        this.logger.info(`生成图形验证码=> key: ${key} 验证码：${strCaptcha}`);
        return data;
    }

    // 验证图形验证码
    async validate (key, captcha) {
        const { redis } = this.app;
        let strCaptcha = await redis.get(`${key} captcha`);
        this.logger.info(`生成图形验证码=> key: ${key} 请求验证码：${captcha} 验证码：${strCaptcha}`);
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
