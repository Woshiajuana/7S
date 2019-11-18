
'use strict';

const { Service } = require('egg');

module.exports = class HandleServer extends Service {

    // 推荐
    async recommend (application) {
        const { ctx, app } = this;
        return await ctx.model.FqaModel.aggregate([
            {
                $match: { application: app.mongoose.Types.ObjectId(application) }
            },
            {
                $sample: { size: 5 }
            },
        ]);
    }

    // 评价
    async appraise ({ id, appraise }) {
        let data = await this.findById(id);
        +appraise ? data.useful++ : data.useless++;
        await this.update(data);
    }

    // 根据关键字查询
    async searchByKeyWord ({ application, keyword }) {
        const { ctx, app } = this;
        let filter = {
            $or: [
                { question: { $regex: keyword, $options: '$i' } },
                { keywords: { $elemMatch: { $regex: keyword, $options: '$i' } } },
            ],
            application: app.mongoose.Types.ObjectId(application),
        };
        return await ctx.model.FqaModel
            .find(filter)
            .sort('-created_at')
            .limit(10)
            .select('question')
            .lean();
    }

    // 根据关键字查询
    async searchByQuestion ({ application, question }) {
        const { ctx, app } = this;
        let filter = {
            $or: [
                { question: { $regex: question, $options: '$i' } },
                { keywords: { $elemMatch: { $regex: question, $options: '$i' } } }
            ],
            application: app.mongoose.Types.ObjectId(application),
        };
        let [data] = await ctx.model.FqaModel
            .find(filter)
            .sort('-created_at')
            .limit(1)
            .lean();
        if (data) return data;
        return {
            recommend: await this.recommend(application)
        }
    }

    // 创建
    async create (data) {
        const { ctx } = this;
        await ctx.model.FqaModel.create(data);
    }

    // 根据 id 查询
    async findById (id) {
        const { ctx } = this;
        return await ctx.model.FqaModel.findById(id).lean();
    }

    // 查询
    async findOne (data) {
        const { ctx } = this;
        return await ctx.model.FqaModel.findOne(data).lean();
    }

    // 列表
    async list ({ numIndex, numSize, application, keyword }) {
        const { ctx, app } = this;
        numIndex = +numIndex;
        numSize = +numSize;
        let filter = { $or: [] };
        if (application) {
            filter.application = app.mongoose.Types.ObjectId(application);
        }
        if (keyword) {
            filter.$or.push({ question: { $regex: keyword, $options: '$i' } });
            filter.$or.push({ keywords: { $elemMatch: { $regex: keyword, $options: '$i' } } });
        }
        if (!filter.$or.length) delete filter.$or;
        if (numIndex && numSize) {
            const numTotal = await ctx.model.FqaModel.count(filter);
            const arrData = await ctx.model.FqaModel
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
            return await ctx.model.FqaModel.find().sort('-created_at')
                .populate().lean();
        }
    }

    // 删除
    async del (id) {
        const { ctx, app } = this;
        await ctx.model.FqaModel.remove({ _id: app.mongoose.Types.ObjectId(id) });
    }

    // 更新
    async update (data) {
        const { ctx, app } = this;
        let id = data.id || data._id;
        delete data.id;
        delete data._id;
        await ctx.model.FqaModel.update({ _id: app.mongoose.Types.ObjectId(id) }, data);
    }
};
