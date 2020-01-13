<template>
    <div class="view-wrap">
        <filter-view
            :filter-form="objFilterForm"
            :filter-button="arrFilterButton"
            @filter="reqTableDataList"
            @add="handleDialogDisplay()"
        ></filter-view>
        <table-view
            @refresh="reqTableDataList"
            :table-query="objQuery"
            :table-data="arrTable">
            <el-table-column type="expand">
                <template slot-scope="props">
                    <el-form
                        size="mini"
                        label-position="left"
                        inline
                        class="demo-table-expand">
                        <el-form-item label="内容">
                            <span>{{ props.row.content.join(';') }}</span>
                        </el-form-item>
                        <el-form-item label="下载地址">
                            <span>{{ props.row.address }}</span>
                        </el-form-item>
                        <el-form-item label="备注">
                            <span>{{ props.row.remark }}</span>
                        </el-form-item>
                    </el-form>
                </template>
            </el-table-column>
            <el-table-column
                prop="version"
                label="版本">
            </el-table-column>
            <el-table-column
                prop="platform"
                label="平台">
                <template slot-scope="scope">
                    <span>{{ objPlatform[scope.row.platform] }}</span>
                </template>
            </el-table-column>
            <el-table-column
                prop="max"
                label="最新版本">
                <template slot-scope="scope">
                    <span :class="[ scope.row.max && 'color' ]">{{ scope.row.max ? '是' : '否' }}</span>
                </template>
            </el-table-column>
            <el-table-column
                prop="min"
                label="强更版本">
                <template slot-scope="scope">
                    <span :class="[ scope.row.min && 'color' ]">{{ scope.row.min ? '是' : '否' }}</span>
                </template>
            </el-table-column>
            <el-table-column
                prop="created_at"
                label="创建日期">
                <template slot-scope="scope">
                    <span>{{ scope.row.created_at | filterDate }}</span>
                </template>
            </el-table-column>
            <el-table-column
                label="操作"
                width="130">
                <template slot-scope="scope">
                    <el-button
                        :disabled="scope.row.source === 'INIT'"
                        type="text"
                        size="mini"
                        @click="handleDialogDisplay({ type: 'edit', data: scope.row })"
                    >编辑</el-button>
                </template>
            </el-table-column>
        </table-view>
        <!--    新增    -->
        <details-drawer
            @refresh="reqTableDataList"
            :display.sync="objDialog.is"
            :data="objDialog"
        ></details-drawer>
    </div>
</template>

<script>
    import DialogMixin                          from '@/mixins/dialog'
    import FilterMixin                          from '@/mixins/filter'
    import DetailsDrawer                        from './details-drawer'
    import DataMixin                            from './data.mixin'

    export default {
        name: 'Member',
        mixins: [
            DataMixin,
            FilterMixin,
            DialogMixin,
        ],
        created () {
            this.reqTableDataList();
        },
        methods: {
            reqTableDataList (callback) {
                let options = this.$verify.input(this.objFilterForm);
                this.objQuery.isLoading = true;
                this.$curl(this.$appConst.REQ_VERSION_LIST, {
                    ...this.objQuery,
                    ...options,
                }).then((res) => {
                    let { list = [], total } = res || {};
                    this.arrTable = list;
                    this.objQuery.numTotal = total;
                }).toast().finally(() => {
                    typeof callback === 'function' && callback();
                    this.objQuery.isLoading = false;
                });
            },
        },
        components: {
            DetailsDrawer,
        },
    }
</script>

<style>
    .color{
        color: red;
    }
</style>
