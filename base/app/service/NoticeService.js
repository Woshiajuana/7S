
'use strict';

const { Service } = require('egg');

module.exports = class HandleServer extends Service {

    // 数量
    async count (data) {
        const { ctx, app } = this;
        const { user } = data;
        let filter = {};
        if (user) {
            delete data.user;
            filter.user = app.mongoose.Types.ObjectId(user);
        }
        return await ctx.model.NoticeModel.count(Object.assign(filter, data));
    }

    // 创建
    async create (data) {
        const { ctx } = this;
        await ctx.model.NoticeModel.create(data);
    }

    // 更新
    async update (data) {
        const { ctx, app } = this;
        const { id, user } = data;
        delete data.id;
        let objFilter = { _id: app.mongoose.Types.ObjectId(id) };
        if (user) {
            objFilter.user = app.mongoose.Types.ObjectId(user);
        }
        await ctx.model.NoticeModel.update(objFilter, data);
    }

    // 根据 id 查询
    async findById (id) {
        const { ctx } = this;
        return await ctx.model.NoticeModel.findById(id).lean();
    }

    // 删除
    async del ({ id, user }) {
        const { ctx, app } = this;
        let objFilter = { _id: app.mongoose.Types.ObjectId(id) };
        if (user) {
            objFilter.user = app.mongoose.Types.ObjectId(user);
        }
        await ctx.model.NoticeModel.remove(objFilter);
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
            filter.$or.push({ content: { $regex: keyword, $options: '$i' } });
        }
        if (!filter.$or.length) delete filter.$or;
        const total = await ctx.model.NoticeModel.count(filter);
        const list = await ctx.model.NoticeModel
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
