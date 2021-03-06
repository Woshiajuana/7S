
'use strict';

const { Service } = require('egg');

module.exports = class HandleServer extends Service {

    // 创建
    async create (data) {
        const { ctx } = this;
        return await ctx.model.DislikeModel.create(data);
    }


    // 根据 id 查询
    async findOne (data) {
        const { ctx, app } = this;
        let { user, photo } = data;
        return await ctx.model.DislikeModel.findOne({
            user: app.mongoose.Types.ObjectId(user),
            photo: app.mongoose.Types.ObjectId(photo),
        }).lean();
    }

    // 删除
    async del ({ user, photo }) {
        const { ctx, app } = this;
        let filter = {};
        if (user) {
            filter.user = app.mongoose.Types.ObjectId(user);
        }
        if (photo) {
            filter.photo = app.mongoose.Types.ObjectId(photo);
        }
        await ctx.model.DislikeModel.remove(filter);
    }

    // 列表
    async list (data) {
        const { ctx, app } = this;
        let { numIndex, numSize, photo, user } = data;
        let filter = { $or: [] }; // 多字段匹配
        if (user) {
            filter.user = app.mongoose.Types.ObjectId(user);
        }
        if (photo) {
            filter.photo = app.mongoose.Types.ObjectId(photo);
        }
        if (!filter.$or.length) delete filter.$or;
        const total = await ctx.model.DislikeModel.count(filter);
        const list = await ctx.model.DislikeModel
            .find(filter)
            .sort('-created_at')
            .skip((numIndex - 1) * numSize)
            .limit(numSize)
            .populate([
                { path: 'user', select: { password: 0 } },
                {
                    path: 'photo',
                    select: { password: 0 },
                    populate: [
                        { path: 'photo', select: 'base path filename'},
                        { path: 'user', select: { password: 0 } },
                    ],
                },
            ])
            .lean();
        return {
            list,
            total,
            numIndex,
            numSize,
        }
    }
};
