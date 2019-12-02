
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

        // 问题
        question: {
            type: String,
            trim: true,
            maxlength: 300,
            required: true,
        },

        // 关键词
        keywords: {
            type: Array,
            required: true,
        },

        // 答案
        answer: {
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

        // 有用
        useful: {
            type: Number,
            trim: true,
            default: 0,
        },

        // 无用
        useless: {
            type: Number,
            trim: true,
            default: 0,
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
    return mongoose.model('fqa', postSchema);
};
