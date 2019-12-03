
'use strict';

module.exports = app => {
    const mongoose = app.mongoose;
    const Schema = mongoose.Schema;
    const postSchema = new Schema({

        // 邮箱
        email: {
            type: String,
            trim: true,
            maxlength: 50,
            required: true,
        },

        // 7S-ID
        uid: {
            type: String,
            maxlength: 7,
            default: '',
        },

        // 密码
        password: {
            type: String,
            maxlength: 32,
            required: true,
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
            type: Schema.Types.ObjectId,
            ref: 'file',
            trim: true,
            default: null,
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
