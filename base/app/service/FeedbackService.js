
'use strict';

const { Service } = require('egg');


module.exports = class HandleServer extends Service {

    // 创建
    async create (data) {
        const { ctx } = this;
        await ctx.model.FeedbackModel.create(data);
    }

    // 根据 id 查询
    async findById (id) {
        const { ctx } = this;
        return await ctx.model.FeedbackModel.findById(id).lean();
    }

    // 查询
    async findOne (data) {
        const { ctx } = this;
        return await ctx.model.FeedbackModel.findOne(data).lean();
    }

    // 列表
    async list ({ numIndex, numSize, application, keyword, content }) {
        const { ctx, app } = this;
        numIndex = +numIndex;
        numSize = +numSize;
        if (numIndex && numSize) {
            let filter = {
                $or: [],
            }; // 多字段匹配
            if (application) {
                filter.application = app.mongoose.Types.ObjectId(application);
            }
            if (keyword) {
                filter.$or.push({ name: { $regex: keyword, $options: '$i' } });
                filter.$or.push({ phone: { $regex: keyword, $options: '$i' } });
                filter.$or.push({ email: { $regex: keyword, $options: '$i' } });
            }
            if (!filter.$or.length) delete filter.$or;
            const numTotal = await ctx.model.FeedbackModel.count(filter);
            const arrData = await ctx.model.FeedbackModel
                .find(filter)
                .sort('-created_at')
                .skip((numIndex - 1) * numSize)
                .limit(numSize)
                .populate([{ path: 'application' }])
                .lean();
            return {
                arrData,
                numTotal,
                numIndex,
                numSize,
            }
        } else {
            return await ctx.model.FeedbackModel.find().sort('-created_at')
                .populate().lean();
        }
    }

    // 删除
    async del (id) {
        const { ctx, app } = this;
        await ctx.model.FeedbackModel.remove({ _id: app.mongoose.Types.ObjectId(id) });
    }

    // 更新
    async update (data) {
        const { ctx, app } = this;
        const { id } = data;
        delete data.id;
        await ctx.model.FeedbackModel.update({ _id: app.mongoose.Types.ObjectId(id) }, data);
    }
};
