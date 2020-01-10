<template>
    <div class="view-wrap">
        <filter-view
            :filter-form="objFilterForm"
            :filter-button="arrFilterButton"
            @filter="reqTableDataList"
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
                        <el-form-item label="上传ip">
                            <span>{{ props.row.ip }}</span>
                        </el-form-item>
                        <el-form-item label="设备">
                            <span>{{ props.row.device }}</span>
                        </el-form-item>
                        <el-form-item label="原文件">
                            <span>{{ props.row.source }}</span>
                        </el-form-item>
                        <el-form-item label="服务器">
                            <span>{{ props.row.base }}</span>
                        </el-form-item>
                        <el-form-item label="路径">
                            <span>{{ props.row.path }}</span>
                        </el-form-item>
                    </el-form>
                </template>
            </el-table-column>
            <el-table-column
                prop="user"
                label="用户">
                <template slot-scope="scope">
                    <span>{{ scope.row.user.nickname || scope.row.user.email }}</span>
                </template>
            </el-table-column>
            <el-table-column
                prop="filename"
                label="文件名">
            </el-table-column>
            <el-table-column
                prop="type"
                label="类型">
                <template slot-scope="scope">
                    <span>{{ objType[scope.row.type] }}</span>
                </template>
            </el-table-column>
            <el-table-column
                prop="created_at"
                label="上传日期">
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
                        @click="handleDialogDisplay({ data: scope.row })"
                    >预览</el-button>
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

