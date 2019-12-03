
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

        // ip
        ip: {
            type: String,
            trim: '',
            maxlength: 20,
            default: '',
        },

        // 类型 [ AVATAR: 头像, VIDEO: 视频,  PHOTO: 照片, COVER: 封面 ]
        type: {
            type: String,
            trim: '',
            required: true,
        },

        // 路径
        path: {
            type: String,
            trim: '',
            required: true,
        },

        // 服务器
        base: {
            type: String,
            trim: '',
            required: true,
        },

        // 文件名
        filename: {
            type: String,
            trim: '',
            required: true,
            maxlength: 30,
        },

        // 设备信息
        device: {
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
    return mongoose.model('file', postSchema);
};
