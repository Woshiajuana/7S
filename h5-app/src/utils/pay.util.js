import Toast            from 'utils/toast.util'
import Http             from 'utils/http.util'
// import Config           from 'config/env.config'

export default {

    unionPay (workId, txnAmt, cipherText) {
        let that = this;
        return new Promise((resolve, reject) => {
            that._fetchInfo(workId, txnAmt, cipherText).then((result) => {
                let payObject = JSON.parse(result);
                window.location.href = payObject.redirectUrl;
            }).catch((err) => {
                reject(err);
            })
        }).finally(() => {
            Toast.hide();
        });
    },

    // 支付宝支付 ALIPAY 支付宝
    ALIPAY (workId, txnAmt, cipherText) {
        let that = this;
        return new Promise((resolve, reject) => {
            that._fetchInfo(workId, txnAmt, cipherText, 'ALIPAY').then((result) => {
                AlipayJSBridge.call('tradePay', {
                    tradeNO: result,
                    displayPayResult: true
                }, (data) => {
                    console.log(data);
                    if (data.resultCode !='9000')
                        return reject(data);
                    resolve();
                    // let url = 'https://interaction.bayimob.com/gameHtml?appkey=124f420f1605c38eb2901bd1812feddd&adSpaceKey=fd5a8d1af52100cc62bd677288a937f0&1=1';
                    // window.location.href = url;
                });
            }).catch((err) => {
                reject(err);
            })
        }).finally(() => {
            Toast.hide();
        });
    },

    // 微信支付 WECHAT  微信
    WECHAT (workId, txnAmt, cipherText) {
        let that = this;
        return new Promise((resolve, reject) => {
            that._fetchInfo(workId, txnAmt, cipherText, 'WECHAT').then((result) => {
                if (typeof WeixinJSBridge  !== 'undefined')
                    return this._handleWeChat(result, resolve, reject);
                if( document.addEventListener ){
                    document.addEventListener('WeixinJSBridgeReady', () => {
                        that._handleWeChat(result, resolve, reject);
                    }, false);
                } else if (document.attachEvent){
                    document.attachEvent('WeixinJSBridgeReady', () => {
                        that._handleWeChat(result, resolve, reject);
                    });
                    document.attachEvent('onWeixinJSBridgeReady', () => {
                        that._handleWeChat(result, resolve, reject);
                    });
                }
            }).catch((err) => {
                reject(err);
            })
        })
    },

    // 微信支付处理
    _handleWeChat (result, resolve, reject) {
        WeixinJSBridge.invoke(
            'getBrandWCPayRequest', $.parseJSON(result),
            (res) => {
                console.log(res)
                // res = {err_code: '-1', err_desc: ''}
                if (res.err_msg !== 'get_brand_wcpay_request:ok')
                    return reject(res);
                resolve();
                // 使用以上方式判断前端返回,微信团队郑重提示：res.err_msg将在用户支付成功后返回    ok，但并不保证它绝对可靠。
            }
        );
    },

    // 获取信息
    _fetchInfo (workId, txnAmt, cipherText, productCode) {
        Toast.show();
        return new Promise((resolve, reject) => {
            Http(Http.API.DO_JS_CREATED_ORDER, {
                txnAmt,
                workId,
                productCode,
                cipherText,
                clientIp: '127.0.0.1',
                imei: '123',
            }).then((res) => {
                console.log(res);
                // console.log('xxx=>',res.pubNumPayInfo);
                resolve(res.pubNumPayInfo);
            }).catch((err) => {
                Toast.msg(err);
                reject(err);
            });
        }).catch((err) => {
            console.log(err);
        }).finally(() => {
            Toast.hide();
        });
    }
}
