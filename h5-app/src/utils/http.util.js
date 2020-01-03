
import Toast                            from 'utils/toast.util'
import Config                           from 'config/env.config'
import Api                              from 'config/api.config'
import Store                            from 'utils/store.util'
import BaseConfig                       from 'config/base.config'
import DateUtil                         from 'utils/date.util'

const {
    TENANT_ID,
    ENCRYPT_KEY,
} = BaseConfig;

function Http (url, data, options) {
    this.fn = options.fn || 'fetch';
    this.data = Object.assign({
        randomStr: new Date().getTime().toString(),
        reqDate: DateUtil.formatData('yyyyMMdd'),
        reqTime: DateUtil.formatData('yyyyMMddhhmmss'),
        tenantId: TENANT_ID,
    }, data);
    this.options = options;
    this.url = url;
    console.log(22222)
    return this[this.fn]();
}

// 注册流程
Http.prototype.fetch = function () {
    let { access_token } = Store.dataToSessionStorageOperate.achieve('ACCESS_TOKEN') || {};
    this.url = `${Config.API_URL_FETCH}${this.url}`;
    this.data.signature = signatureGenerate(this.data);
    console.log(3333)
    console.log(this.url, '请求参数 => ', this.data);
    let headers = {
        'TENANT_ID': TENANT_ID,
        'Authorization': access_token ? `bearer ${access_token}` : 'Basic c2hyZXc6c2hyZXc=' ,
        'Content-Type': 'application/json;charset=UTF-8',
    };
    return new Promise((resolve, reject) => {
        $.ajax({
            type: 'POST',
            timeout: 60 * 1000,
            url: this.url,
            data: JSON.stringify(this.data),
            dataType: 'json',
            headers,
            ...this.options,
            success: (response) => {
                console.log(this.url, '请求返回 => ', response);
                let { code, msg, data } = response;
                if (code !== 0)
                    return reject(msg);
                console.log(this.url, '请求返回格式化 => ', data);
                resolve(data);
            },
            error: (err = '') => {
                console.log(this.url, '请求错误 => ', err);
                let { response, status } = err;
                let msg = '网络繁忙，请稍后再试';
                try {
                    response = JSON.parse(response);
                    msg = response.msg;
                } catch (e) {
                    msg = '网络繁忙，请稍后再试';
                } finally {
                    if (status === 401) {
                        Store.dataToSessionStorageOperate.clear();
                    }
                    reject(msg);
                }
            }
        })
    });
};

const fn = (url, data = {}, options = {}) => {
    let { loading } = options;
    if (loading !== false) Toast.show(loading);
    return new Http(url, data, options).finally(() => {
        loading !== false && Toast.hide();
    });
};

fn.API = Api;

export default fn;

function signatureGenerate(data) {
    let keys = Object.keys(data).sort();
    let stringSignTemp = '';
    keys.forEach((key) => {
        let value = data[key];
        if (!value || typeof value === 'object' || key === 'password') return null;
        stringSignTemp = stringSignTemp
            ? `${stringSignTemp}&${key}=${value}`
            : `${key}=${value}`;
    });
    stringSignTemp = stringSignTemp
        ? `${stringSignTemp}&key=${ENCRYPT_KEY}`
        : `key=${ENCRYPT_KEY}`;
    console.log('stringSignTemp=>', stringSignTemp);
    return CryptoJS.SHA256(stringSignTemp).toString().toLocaleUpperCase();
}



