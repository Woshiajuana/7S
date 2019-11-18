
'use strict';

const { Service } = require('egg');


module.exports = class HandleServer extends Service {

    // 创建
    async create (data) {
        const { ctx } = this;
        await ctx.model.ApplicationModel.create(data);
    }

    // 根据 id 查询
    async findById (id) {
        const { ctx } = this;
        return await ctx.model.ApplicationModel.findById(id).lean();
    }

    // 查询
    async findOne (data) {
        const { ctx } = this;
        return await ctx.model.ApplicationModel.findOne(data).lean();
    }

    // 列表
    async list ({ numIndex, numSize, id, name }) {
        const { ctx, app } = this;
        numIndex = +numIndex;
        numSize = +numSize;
        if (numIndex && numSize) {
            let filter = { $or: [] }; // 多字段匹配
            if (id) {
                filter._id = app.mongoose.Types.ObjectId(id);
            }
            if (name) {
                filter.$or.push({ name: { $regex: name, $options: '$i' } });
            }
            if (!filter.$or.length) delete filter.$or;
            const numTotal = await ctx.model.ApplicationModel.count(filter);
            const arrData = await ctx.model.ApplicationModel
                .find(filter)
                .sort('-created_at')
                .skip((numIndex - 1) * numSize)
                .limit(numSize)
                .populate()
                .lean();
            return {
                arrData,
                numTotal,
                numIndex,
                numSize,
            }
        } else {
            return await ctx.model.ApplicationModel.find().sort('-created_at')
                .populate().lean();
        }
    }

    // 删除
    async del (id) {
        const { ctx, app } = this;
        await ctx.model.ApplicationModel.remove({ _id: app.mongoose.Types.ObjectId(id) });
    }

    // 更新
    async update (data) {
        const { ctx, app } = this;
        const { id } = data;
        delete data.id;
        await ctx.model.ApplicationModel.update({ _id: app.mongoose.Types.ObjectId(id) }, data);
    }
};
