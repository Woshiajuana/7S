
'use strict';

const { Service } = require('egg');
const ms = require('ms');

module.exports = class TransFormService extends Service {

    // 生成图形验证码
    async generateCaptcha (key) {
        const { redis } = this.app;
        let strCaptcha = randomNum(6);
        await redis.set(`${key} captcha`, strCaptcha, 'PX', ms('5m'));
        this.logger.info(`生成图形验证码=> key: ${key} 验证码：${strCaptcha}`);
        return data;
    }

    // 验证图形验证码
    async validateCaptcha (key, captcha) {
        const { redis } = this.app;
        let strCaptcha = await redis.get(`${key} captcha`);
        this.logger.info(`生成图形验证码=> key: ${key} 请求验证码：${captcha} 验证码：${strCaptcha}`);
        return strCaptcha === captcha;
    }

    // 发送邮件


};

function randomNum (len) {
    let result = '';
    while (len > 0) {
        len--;
        result += Math.floor(Math.random() * 10)
    }
    return result;
}
