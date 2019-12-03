
'use strict';

module.exports = app => {
    const mongoose = app.mongoose;
    const Schema = mongoose.Schema;
    const postSchema = new Schema({

        // 版本
        version: {
            type: String,
            trim: true,
            required: true,
        },

        // 平台 [ android, iOS ]
        platform: {
            type: String,
            trim: true,
            required: true,
        },

        // 内容
        content: {
            type: Array,
            required: true,
            default: [],
        },

        // 备注
        remark: {
            type: String,
            trim: true,
            maxlength: 100,
            default: '',
        },

        // 最低
        min: {
            type: Boolean,
            default: false,
        },

        // 最高
        max: {
            type: Boolean,
            default: false,
        },

        // 下载地址
        android: {
            type: String,
            trim: true,
            default: '',
        },

        // iOS:
        ios: {
            type: String,
            trim: true,
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
    return mongoose.model('version', postSchema);
};
