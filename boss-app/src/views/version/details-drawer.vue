
<template>
    <el-drawer
            class="drawer-view"
            :title="data.type === 'add' ? '新增版本' : '编辑版本'"
            :before-close="handleClose"
            :visible.sync="display"
            direction="rtl"
            size="50%"
            custom-class="demo-drawer"
            ref="drawer">
        <div class="demo-drawer__content">
            <el-form
                :model="ruleForm"
                :rules="rules"
                ref="ruleForm"
                label-width="60px"
                class="demo-ruleForm">
                <el-form-item label="名称" prop="name">
                    <el-input v-model.trim="ruleForm.name" clearable placeholder="请输入名称" maxlength="20"></el-input>
                </el-form-item>
                <el-form-item label="备注" prop="remark">
                    <el-input type="textarea" placeholder="请输入备注" clearable v-model.trim="ruleForm.remark" maxlength="100"></el-input>
                </el-form-item>
            </el-form>
            <div class="demo-drawer__footer">
                <el-button type="primary" :loading="loading" @click="handleSubmit">{{ loading ? '提交中...' : '确认' }}</el-button>
                <el-button @click="handleClose">关闭</el-button>
            </div>
        </div>
    </el-drawer>
</template>

<script>
    export default {
        data () {
            return {
                loading: false,
                ruleForm: {
                    name: '',
                    remark: '',
                },
                rules: {
                    name: [
                        { required: true, message: '请输入用户组名称', trigger: 'blur' },
                    ],
                    remark: [
                        { required: true, message: '请填写备注', trigger: 'blur' }
                    ],
                }
            }
        },
        watch: {
            display (val) {
                if (val) this.assignmentData();
            },
        },
        props: {
            display: { default: false },
            data: { default: '' },
        },
        methods: {
            handleClose () {
                this.$emit('update:display', false);
                this.$refs.ruleForm.resetFields();
            },
            handleSubmit () {
                this.$refs.ruleForm.validate((valid) => {
                    if (!valid) return false;
                    this.loading = true;
                    let { type, data } = this.data;
                    this.$curl(type === 'add'
                        ? this.$appConst._DO_CREATE_USER_GROUP
                        : this.$appConst._DO_UPDATE_USER_GROUP, this.ruleForm).then((res) => {
                        this.$modal.toast(type === 'add' ? '新增成功' : '编辑成功', 'success');
                        this.$emit('refresh');
                        this.handleClose();
                    }).toast().finally(() => this.loading = false);
                });
            },
            assignmentData () {
                this.$nextTick(() => {
                    this.$refs.ruleForm.resetFields();
                    let { type, data } = this.data;
                    data && (this.ruleForm = { ...data, id: data._id });
                });
            },
        },
    };
</script>
