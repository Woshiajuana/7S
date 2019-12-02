
'use strict';

module.exports = app => {
    const mongoose = app.mongoose;
    const Schema = mongoose.Schema;
    const postSchema = new Schema({

        // 应用
        application: {
            type: Schema.Types.ObjectId,
            ref: 'application',
            trim: true,
            required: true,
        },

        // 反馈人姓名
        name: {
            type: String,
            trim: true,
            maxlength: 20,
            default: '',
        },

        // 手机
        phone: {
            type: String,
            trim: true,
            maxlength: 13,
            default: '',
        },

        // 邮箱
        email: {
            type: String,
            trim: true,
            maxlength: 30,
            default: '',
        },

        // 内容
        content: {
            type: String,
            trim: true,
            maxlength: 300,
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
    return mongoose.model('feedback', postSchema);
};
