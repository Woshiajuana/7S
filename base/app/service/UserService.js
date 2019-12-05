
'use strict';

const { Service } = require('egg');

module.exports = class HandleServer extends Service {

    // 创建
    async create (data) {
        const { ctx } = this;
        await ctx.model.UserModel.create(data);
    }

    // 更新
    async update (data) {
        const { ctx, app } = this;
        const { id } = data;
        delete data.id;
        await ctx.model.UserModel.update({ _id: app.mongoose.Types.ObjectId(id) }, data);
    }


    // 根据 id 查询
    async findById (id) {
        const { ctx } = this;
        return await ctx.model.UserModel.findById(id).populate([
            { path: 'avatar', select: 'base path filename'},
        ]).lean();
    }

    // 根据条件查
    async findOne (data) {
        const { ctx } = this;
        let { id, email, uid } = data;
        if (id) return await ctx.model.UserModel.findById(id).lean();
        if (email) return await ctx.model.UserModel.findOne({ email }).lean();
        if (uid) return await ctx.model.UserModel.findOne({ uid }).lean();
    }

    // 删除
    async del (id) {
        const { ctx, app } = this;
        await ctx.model.UserModel.remove({ _id: app.mongoose.Types.ObjectId(id) });
    }

    // 列表
    async list (data) {
        const { ctx, app } = this;
        let { numIndex, numSize, keyword } = data;
        numIndex = +numIndex;
        numSize = +numSize;
        let filter = { $or: [] }; // 多字段匹配
        if (keyword) {
            filter.$or.push({ email: { $regex: keyword, $options: '$i' } });
            filter.$or.push({ uid: { $regex: keyword, $options: '$i' } });
            filter.$or.push({ nickname: { $regex: keyword, $options: '$i' } });
        }
        if (!filter.$or.length) delete filter.$or;
        const total = await ctx.model.UserModel.count(filter);
        const list = await ctx.model.UserModel
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
