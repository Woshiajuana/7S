
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

        // 收藏
        photo: {
            type: Schema.Types.ObjectId,
            ref: 'photo',
            trim: true,
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
    return mongoose.model('history', postSchema);
};
