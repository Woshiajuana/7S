
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




        // 应用名称
        name: {
            type: String,
            trim: true,
            maxlength: 30,
            required: true,
        },

        // logo
        logo: {
            type: String,
            trim: true,
            required: true,
        },

        // 备注
        remark: {
            type: String,
            trim: true,
            maxlength: 100,
            default: '',
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
