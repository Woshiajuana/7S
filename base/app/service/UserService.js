
'use strict';

const { Service } = require('egg');

module.exports = class HandleServer extends Service {

    // 创建
    async create (data) {
        const { ctx } = this;
        return await ctx.model.UserModel.create(data);
    }

    // 更新
    async update (data) {
        const { ctx, app } = this;
        const { id, email } = data;
        let filter = {};
        if (id) {
            filter._id = app.mongoose.Types.ObjectId(id);
        } else if (email) {
            filter.email = email;
        }
        delete data.id;
        delete data.email;
        await ctx.model.UserModel.update(filter, data);
    }


    // 根据 id 查询
    async findById (id) {
        const { ctx } = this;
        return await ctx.model.UserModel.findById(id).lean();
    }

    // 根据条件查
    async findOne (data) {
        const { ctx } = this;
        let { id, email, uid } = data;
        let objUser;
        if (id) objUser = await ctx.model.UserModel.findById(id).lean();
        else if (email) objUser = await ctx.model.UserModel.findOne({ email }).lean();
        else if (uid) objUser = await ctx.model.UserModel.findOne({ uid }).lean();
        else objUser = await ctx.model.UserModel.findOne(data).lean();
        return objUser;
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
        let filter = { $or: [] }; // 多字段匹配
        if (keyword) {
            filter.$or.push({ email: { $regex: keyword, $options: '$i' } });
            filter.$or.push({ uid: { $regex: keyword, $options: '$i' } });
            filter.$or.push({ nickname: { $regex: keyword, $options: '$i' } });
        }
        if (!filter.$or.length) delete filter.$or;
        const total = await ctx.model.UserModel.count(filter);
        if (numSize && numIndex) {
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
        } else {
            return await ctx.model.UserModel
                .find(filter)
                .sort('-created_at')
                .populate()
                .lean();
        }

    }
};
