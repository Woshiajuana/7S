
'use strict';

const { Service } = require('egg');
const ms = require('ms');

module.exports = class TransFormService extends Service {

    // 生成图形验证码
    async sendCaptcha (data) {
        const { redis } = this.app;
        let { email, template } = data;
        const objTemplate = {
            '1': '7S-欢迎注册',
            '2': '7S-重置密码',
        };
        let strCaptcha = randomNum(6);
        await this.send({ to: email, subject: objTemplate[template], html: `您的验证码：${ strCaptcha }，有效期5分钟` });
        await redis.set(`${email} ${template} captcha`, strCaptcha, 'PX', ms('5m'));
        this.logger.info(`生成验证码=> email: ${email} 验证码：${strCaptcha}`);
        return data;
    }

    // 验证图形验证码
    async validate (data) {
        const { redis } = this.app;
        let { email, template, captcha} = data;
        let strCaptcha = await redis.get(`${email} ${template} captcha`);
        this.logger.info(`生成图形验证码=> key: ${email} 请求验证码：${captcha} 验证码：${strCaptcha}`);
        if (strCaptcha !== captcha)
            throw '验证码错误';
        await redis.del(`${email} ${template} captcha`);
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
