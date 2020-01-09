
'use strict';

const CaptchaPng = require('captchapng');
const svgCaptcha = require('svg-captcha');
const { Service } = require('egg');

module.exports = class HandleServer extends Service {

    // 生成图形验证码
    async generate (key) {
        const { app, logger } = this;
        const { redis } = app;
        let value = randomNum(6);
        let captchaPng = new CaptchaPng(80, 30, value);
        captchaPng.color(255, 255, 255, 0);  // First color: background (red, green, blue, alpha)
        captchaPng.color(80, 80, 80, 255); // Second color: paint (red, green, blue, alpha)
        // let data = new Buffer(captchaPng.getBase64(), 'base64');
        let captcha = captchaPng.getBase64();
        // let {
        //     text,
        //     data,
        // } = svgCaptcha.create( {
        //     size: 5, // 验证码长度
        //     ignoreChars: '0o1i', // 验证码字符中排除 0o1i
        //     noise: 2, // 干扰线条的数量
        //     height: 44
        // });
        logger.info(`【${key}】生成图形验证码:【${value}】`);
        await redis.set(`${key} captcha`, value);
        return captcha;
    }

    // 验证验证图形码
    async check (key, captcha) {
        const { app, logger } = this;
        const { redis } = app;
        let value = await redis.get(`${key} captcha`);
        if (!value) return null;
        await redis.del(`${key} captcha`);
        const result = value !== captcha;
        if (result) {
            logger.info(`【${key}】图形验证码:【${captcha}】验证失败 期望值:【${value}】`);
        } else {
            logger.info(`【${key}】图形验证码:【${captcha}】验证成`);
        }
        return result;
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
