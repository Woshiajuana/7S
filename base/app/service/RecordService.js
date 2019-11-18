
'use strict';

const { Service } = require('egg');


module.exports = class HandleServer extends Service {

    // 评价
    async appraise ({ record, appraise }) {
        let { appraise: strAppraise } = await this.findById(record);
        if (strAppraise) throw 'F20001';
        await this.update({ id: record, appraise: +appraise ? '满意' : '不满意' });
    }

    // 创建
    async create (data) {
        const { ctx } = this;
        return await ctx.model.RecordModel.create(data);
    }

    // 根据 id 查询
    async findById (id) {
        const { ctx } = this;
        return await ctx.model.RecordModel.findById(id).lean();
    }

    // 查询
    async findOne (data) {
        const { ctx } = this;
        return await ctx.model.RecordModel.findOne(data).lean();
    }

    // 列表
    async list ({ numIndex, numSize, application, keyword }) {
        const { ctx, app } = this;
        numIndex = +numIndex;
        numSize = +numSize;
        if (numIndex && numSize) {
            let filter = { $or: [] }; // 多字段匹配
            if (application) {
                filter.application = app.mongoose.Types.ObjectId(application);
            }
            if (keyword) {
                filter.$or.push({ question: { $regex: keyword, $options: '$i' } });
            }
            if (!filter.$or.length) delete filter.$or;
            const numTotal = await ctx.model.RecordModel.count(filter);
            const arrData = await ctx.model.RecordModel
                .find(filter)
                .sort('-created_at')
                .skip((numIndex - 1) * numSize)
                .limit(numSize)
                .populate([{ path: 'application' }, { path: 'fqa' }])
                .lean();
            return {
                arrData,
                numTotal,
                numIndex,
                numSize,
            }
        } else {
            return await ctx.model.RecordModel.find().sort('-created_at')
                .populate().lean();
        }
    }

    // 删除
    async del (id) {
        const { ctx, app } = this;
        await ctx.model.RecordModel.remove({ _id: app.mongoose.Types.ObjectId(id) });
    }

    // 更新
    async update (data) {
        const { ctx, app } = this;
        const { id } = data;
        delete data.id;
        await ctx.model.RecordModel.update({ _id: app.mongoose.Types.ObjectId(id) }, data);
    }
};
