
'use strict';

module.exports = app => {
    const mongoose = app.mongoose;
    const Schema = mongoose.Schema;
    const postSchema = new Schema({

        // 问题
        question: {
            type: String,
            trim: true,
            maxlength: 100,
            required: true,
        },

        // 应用
        application: {
            type: Schema.Types.ObjectId,
            ref: 'application',
            trim: true,
            required: true,
        },

        // 问题
        fqa: {
            type: Schema.Types.ObjectId,
            ref: 'fqa',
            trim: true,
            default: null,
        },

        // 评价
        appraise: {
            type: String,
            trim: true,
            default: '',
        },

        // 账号
        account: {
            type: String,
            trim: true,
            default: '',
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
    return mongoose.model('record', postSchema);
};
