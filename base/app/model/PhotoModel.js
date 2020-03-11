
'use strict';

module.exports = app => {
    const mongoose = app.mongoose;
    const Schema = mongoose.Schema;
    const postSchema = new Schema({

        // 用户
        user: {
            type: Schema.Types.ObjectId,
            ref: 'user',
            trim: true,
            required: true,
        },

        // 照片
        photo: {
            type: Schema.Types.ObjectId,
            ref: 'file',
            trim: true,
            required: true,
        },

        // 标题
        title: {
            type: String,
            maxlength: 100,
            trim: '',
            required: true,
        },

        //  描述
        desc: {
            type: String,
            maxlength: 500,
            trim: '',
            required: true,
        },

        // 观看量
        volume: {
            type: Number,
            default: 0,
        },

        // 性质 [ PRIVACY: 隐私  PUBLIC: 公开 ]
        nature: {
            type: String,
            maxlength: 100,
            trim: '',
            default: ''
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
    return mongoose.model('photo', postSchema);
};
