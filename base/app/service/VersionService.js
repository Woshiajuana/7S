
'use strict';

const { Service } = require('egg');

module.exports = class HandleServer extends Service {

    // 数量
    async count (data) {
        const { ctx } = this;
        return await ctx.model.VersionModel.count(data);
    }

    // 创建
    async create (data) {
        const { ctx } = this;
        await ctx.model.VersionModel.create(data);
    }

    // 更新
    async update (filter, data) {
        const { ctx, app } = this;
        if (!data) {
            data = {...filter};
            delete data._id;
        }
        if (filter.id) {
            filter._id = app.mongoose.Types.ObjectId(data.id);
            delete filter.id;
        }
        await ctx.model.VersionModel.update(filter, data);
    }

    // 根据 id 查询
    async findById (id) {
        const { ctx } = this;
        return await ctx.model.VersionModel.findById(id).lean();
    }

    // 根据条件查询
    async findOne (data) {
        const { ctx, app } = this;
        if (data.id) {
            data._id = app.mongoose.Types.ObjectId(data.id);
            delete data.id;
        }
        return await ctx.model.VersionModel.findOne(data).lean();
    }

    // 删除
    async del ({ id, user }) {
        const { ctx, app } = this;
        await ctx.model.VersionModel.remove({
            _id: app.mongoose.Types.ObjectId(id),
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
            filter.$or.push({ filename: { $regex: keyword, $options: '$i' } });
        }
        if (!filter.$or.length) delete filter.$or;
        const total = await ctx.model.VersionModel.count(filter);
        const list = await ctx.model.VersionModel
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
