<template>
    <div class="view-wrap">
        <filter-view
            :filter-form="objFilterForm"
            :filter-button="arrFilterButton"
            @filter="reqTableDataList"
            @init="handleInit"
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
                        <el-form-item label="邮箱">
                            <span>{{ props.row.email }}</span>
                        </el-form-item>
                        <el-form-item label="昵称">
                            <span>{{ props.row.nickname }}</span>
                        </el-form-item>
                        <el-form-item label="头像">
                            <img v-if="props.row.avatar" :src="props.row.avatar"  class="avatar"/>
                            <span v-else>无</span>
                        </el-form-item>
                        <el-form-item label="性别">
                            <span>{{ objSex[props.row.sex] }}</span>
                        </el-form-item>
                        <el-form-item label="签名">
                            <span>{{ props.row.signature }}</span>
                        </el-form-item>
                    </el-form>
                </template>
            </el-table-column>
            <el-table-column
                prop="email"
                label="邮箱">
            </el-table-column>
            <el-table-column
                prop="nickname"
                label="昵称">
            </el-table-column>
            <el-table-column
                prop="path"
                label="性别">
                <template slot-scope="scope">
                    <span>{{ objSex[scope.row.sex] }}</span>
                </template>
            </el-table-column>
            <el-table-column
                prop="created_at"
                label="注册日期">
                <template slot-scope="scope">
                    <span>{{ scope.row.created_at | filterDate }}</span>
                </template>
            </el-table-column>
        </table-view>
    </div>
</template>

<script>
    import FilterMixin                          from '@/mixins/filter'
    import DataMixin                            from './data.mixin'

    export default {
        name: 'Member',
        mixins: [
            DataMixin,
            FilterMixin,
        ],
        created () {
            this.reqTableDataList();
        },
        methods: {
            reqTableDataList (callback) {
                let options = this.$verify.input(this.objFilterForm);
                this.objQuery.isLoading = true;
                this.$curl(this.$appConst.REQ_MEMBER_LIST, {
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
            handleInit () {
                this.$confirm(`确定刷新初始化获取最新API ?`, '温馨提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    this.$curl(this.$appConst.DO_INIT_API_ROUTE).then(() => {
                    }).null().finally(() => this.reqTableDataList());
                }).null();

            },
        },
    }
</script>

<style lang="scss">
    .avatar{
        width: 20px;
        height: 20px;
    }
</style>
