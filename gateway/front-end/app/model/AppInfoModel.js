
'use strict';

module.exports = app => {
    const mongoose = app.mongoose;
    const Schema = mongoose.Schema;
    const postSchema = new Schema({

        // 名称
        name: {
            type: String,
            trim: true,
            maxlength: 100,
            required: true,
            default: '',
        },

        // logo
        logo: {
            type: String,
            trim: true,
            maxlength: 100,
        },

        // 背景图
        bg: {
            type: String,
            maxlength: 200,
            trim: true,
            default: '',
        },

        // 覆盖色
        color: {
            type: String,
            trim: true,
            max: 100,
            default: '',
        },

        // 所有权
        ownership: {
            type: String,
            trim: true,
            maxlength: 200,
            required: true,
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
    return mongoose.model('app_info', postSchema);
};
