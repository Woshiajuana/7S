
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
            default: null,
        },

        // 消息标题
        title: {
            type: String,
            trim: '',
            required: true,
        },

        // 性质 [ PRIVATE 私有   PUBLIC 公共  ]
        nature: {
            type: String,
            trim: '',
            required: true,
        },

        // 消息类型 [ LINK: 链接, TEXT: 文案 ]
        type: {
            type: String,
            trim: '',
            required: true,
        },

        // 消息内容
        content: {
            type: String,
            trim: '',
            required: true,
        },

        // 已读未读
        unread: {
            type: Boolean,
            default: false,
        },

        // 发送状态
        push: {

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
    return mongoose.model('notice', postSchema);
};
