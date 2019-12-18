
'use strict';

const { Service } = require('egg');

module.exports = class HandleServer extends Service {

    // 数量
    async count (data) {
        const { ctx, app } = this;
        const { user } = data;
        return await ctx.model.FollowerModel.count({
            user: app.mongoose.Types.ObjectId(user),
        });
    }


    // 创建
    async create (data) {
        const { ctx } = this;
        await ctx.model.FollowerModel.create(data);
    }

    // 根据 id 查询
    async findOne (data) {
        const { ctx, app } = this;
        let { user, following } = data;
        return await ctx.model.FollowerModel.findOne({
            user: app.mongoose.Types.ObjectId(user),
            following: app.mongoose.Types.ObjectId(following),
        }).lean();
    }

    // 删除
    async del ({ user, following }) {
        const { ctx, app } = this;
        await ctx.model.FollowerModel.remove({
            user: app.mongoose.Types.ObjectId(user),
            following: app.mongoose.Types.ObjectId(following),
        });
    }

    // 列表
    async list (data) {
        const { ctx, app } = this;
        let { numIndex, numSize, user } = data;
        numIndex = +numIndex;
        numSize = +numSize;
        let filter = { $or: [] }; // 多字段匹配
        if (user) {
            filter.user = app.mongoose.Types.ObjectId(user);
        }
        if (!filter.$or.length) delete filter.$or;
        const total = await ctx.model.FollowerModel.count(filter);
        const list = await ctx.model.FollowerModel
            .find(filter)
            .sort('-created_at')
            .skip((numIndex - 1) * numSize)
            .limit(numSize)
            .populate()
            .lean();
        return {
            list,
            total,
            numIndex,
            numSize,
        }
    }
};
