
'use strict';

const { Service } = require('egg');

module.exports = class HandleServer extends Service {

    // 数量
    async count (data) {
        let { user, photo } = data;
        let filter = {};
        if (user) {
            filter.user = app.mongoose.Types.ObjectId(user);
        }
        if (photo) {
            filter.photo = app.mongoose.Types.ObjectId(photo);
        }
        return await ctx.model.HistoryModel.count(filter);
    }

    // 创建
    async create (data) {
        const { ctx } = this;
        await ctx.model.HistoryModel.create(data);
    }

    // 根据 id 查询
    async findOne (data) {
        const { ctx } = this;
        let { user, photo } = data;
        return await ctx.model.HistoryModel.findOne({
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
        await ctx.model.HistoryModel.remove(filter);
    }

    // 列表
    async list (data) {
        const { ctx, app } = this;
        let { numIndex, numSize, photo, user } = data;
        numIndex = +numIndex;
        numSize = +numSize;
        let filter = { $or: [] }; // 多字段匹配
        if (user) {
            filter.user = app.mongoose.Types.ObjectId(user);
        }
        if (photo) {
            filter.photo = app.mongoose.Types.ObjectId(photo);
        }
        if (!filter.$or.length) delete filter.$or;
        const total = await ctx.model.HistoryModel.count(filter);
        const list = await ctx.model.HistoryModel
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
