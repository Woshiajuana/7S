
'use strict';

module.exports = app => {
    const mongoose = app.mongoose;
    const Schema = mongoose.Schema;
    const postSchema = new Schema({

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
    return mongoose.model('application', postSchema);
};