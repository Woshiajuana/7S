
'use strict';

const { Service } = require('egg');

module.exports = class HandleServer extends Service {

    // 创建
    async create (data) {
        const { ctx } = this;
        await ctx.model.CollectModel.create(data);
    }

    // 根据 id 查询
    async findOne (data) {
        const { ctx } = this;
        let { user, video } = data;
        return await ctx.model.CollectModel.findOne({
            user: app.mongoose.Types.ObjectId(user),
            video: app.mongoose.Types.ObjectId(video),
        }).lean();
    }

    // 删除
    async del ({ user, video }) {
        const { ctx, app } = this;
        await ctx.model.CollectModel.remove({
            user: app.mongoose.Types.ObjectId(user),
            video: app.mongoose.Types.ObjectId(video),
        });
    }

    // 列表
    async list (data) {
        const { ctx, app } = this;
        let { numIndex, numSize, video, user } = data;
        numIndex = +numIndex;
        numSize = +numSize;
        let filter = { $or: [] }; // 多字段匹配
        if (user) {
            filter.user = app.mongoose.Types.ObjectId(user);
        }
        if (video) {
            filter.video = app.mongoose.Types.ObjectId(video);
        }
        if (!filter.$or.length) delete filter.$or;
        const total = await ctx.model.CollectModel.count(filter);
        const list = await ctx.model.CollectModel
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
