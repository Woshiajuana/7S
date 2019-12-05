
'use strict';

const { Service } = require('egg');
const ms = require('ms');

module.exports = class TransFormService extends Service {

    // 生成图形验证码
    async generateCaptcha (data) {
        const { redis } = this.app;
        let { email, subject } = data;
        let strCaptcha = randomNum(6);
        await this.send({ email, subject, html: `您的验证码：${ strCaptcha }` });
        await redis.set(`${email} captcha`, strCaptcha, 'PX', ms('5m'));
        this.logger.info(`生成验证码=> email: ${email} 验证码：${strCaptcha}`);
        return data;
    }

    // 验证图形验证码
    async validateCaptcha (email, captcha) {
        const { redis } = this.app;
        let strCaptcha = await redis.get(`${email} captcha`);
        this.logger.info(`生成图形验证码=> key: ${email} 请求验证码：${captcha} 验证码：${strCaptcha}`);
        return strCaptcha === captcha;
    }

    // 发送邮件
    async send (options) {
        const { app } = this;
        await app.email.send(options);
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
