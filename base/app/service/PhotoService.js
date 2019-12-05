
'use strict';

const { Service } = require('egg');

module.exports = class HandleServer extends Service {

    // 视频数量
    async count (data) {
        const { ctx, app } = this;
        const { user } = data;
        return await ctx.model.PhotoModel.count({
            user: app.mongoose.Types.ObjectId(user),
        });
    }

    // 创建
    async create (data) {
        const { ctx } = this;
        await ctx.model.PhotoModel.create(data);
    }

    // 更新
    async update (data) {
        const { ctx, app } = this;
        const { id, user } = data;
        delete data.id;
        await ctx.model.PhotoModel.update({
            _id: app.mongoose.Types.ObjectId(id),
            user: app.mongoose.Types.ObjectId(user),
        }, data);
    }

    // 根据 id 查询
    async findById (id) {
        const { ctx } = this;
        return await ctx.model.PhotoModel.findById(id).lean();
    }

    // 删除
    async del ({ id, user }) {
        const { ctx, app } = this;
        await ctx.model.PhotoModel.remove({
            _id: app.mongoose.Types.ObjectId(id),
            user: app.mongoose.Types.ObjectId(user),
        });
    }

    // 列表
    async list (data) {
        const { ctx, app } = this;
        let { numIndex, numSize, keyword, user } = data;
        numIndex = +numIndex;
        numSize = +numSize;
        let filter = { $or: [] }; // 多字段匹配
        if (user) {
            filter.user = app.mongoose.Types.ObjectId(user);
        }
        if (keyword) {
            filter.$or.push({ title: { $regex: keyword, $options: '$i' } });
        }
        if (!filter.$or.length) delete filter.$or;
        const total = await ctx.model.PhotoModel.count(filter);
        const list = await ctx.model.PhotoModel
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
