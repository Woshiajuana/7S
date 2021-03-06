
'use strict';

module.exports = app => {
    const mongoose = app.mongoose;
    const Schema = mongoose.Schema;
    const postSchema = new Schema({

        // openId
        openId: {
            type: String,
            trim: true,
            default: '',
        },

        // unionId
        unionId: {
            type: String,
            trim: true,
            default: '',
        },

        // nickName
        nickName: {
            type: String,
            trim: true,
            maxlength: 20,
            default: '',
        },

        // avatarUrl
        avatarUrl: {
            type: String,
            trim: true,
            default: '',
        },

        // 邮箱
        email: {
            type: String,
            trim: true,
            maxlength: 50,
        },

        // 密码
        password: {
            type: String,
            maxlength: 32,
        },

        // 预留字段
        phone: {
            type: String,
            trim: true,
            maxlength: 11,
            default: '',
        },

        // 昵称
        nickname: {
            type: String,
            trim: true,
            maxlength: 20,
            default: '',
        },

        // 头像
        avatar: {
            type: String,
            trim: true,
            default: '',
        },

        // 性别 [ 0: 保密, 1: 男, 2: 女  ]
        sex: {
            type: String,
            trim: true,
            default: '0',
        },

        // 禁用
        disabled: {
            type: Boolean,
            trim: true,
            default: false,
        },

        // 锁定
        lock: {
            type: Boolean,
            trim: true,
            default: false,
        },

        // 个性签名
        signature: {
            type: String,
            trim: '',
            maxlength: 40,
        },

        // 创建时间
        created_at: {
            type: Date,
            default: Date.now,
        },

        // 更新时间
        updated_at: {
            type: Date,
            default: Date.now,
        },

    });
    return mongoose.model('user', postSchema);
};
