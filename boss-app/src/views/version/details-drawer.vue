
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
                <el-form-item label="版本号" prop="version">
                    <el-input v-model.trim="ruleForm.version" clearable placeholder="请填写版本号" maxlength="20"></el-input>
                </el-form-item>
                <el-form-item label="平台">
                    <el-radio-group v-model="ruleForm.platform">
                        <el-radio label="安卓" value="android"></el-radio>
                        <el-radio label="iOS" value="iOS"></el-radio>
                    </el-radio-group>
                </el-form-item>
                <el-form-item label="内容" class="keywords-item" prop="content">
                    <el-tag
                            :key="tag"
                            v-for="tag in ruleForm.content"
                            closable
                            :disable-transitions="false"
                            @close="handleTagClose(tag)">
                        {{tag}}
                    </el-tag>
                    <el-input
                        class="input-new-tag"
                        v-if="inputVisible"
                        v-model="inputValue"
                        ref="saveTagInput"
                        size="small"
                        @keyup.enter.native="handleInputConfirm"
                        @blur="handleInputConfirm">
                    </el-input>
                    <el-button class="button-new-tag" v-else size="small" @click="showInput">+ New Keyword</el-button>
                </el-form-item>
                <el-form-item label="最新">
                    <el-switch v-model="ruleForm.max"></el-switch>
                </el-form-item>
                <el-form-item label="强更">
                    <el-switch v-model="ruleForm.min"></el-switch>
                </el-form-item>
                <el-form-item label="下载地址" prop="address">
                    <el-input v-model.trim="ruleForm.address" clearable placeholder="请填写下载地址"></el-input>
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
                inputVisible: false,
                inputValue: '',
                ruleForm: {
                    version: '',
                    platform: '',
                    address: '',
                    content: [],
                    max: '',
                    min: '',
                    remark: '',
                },
                rules: {
                    version: [
                        { required: true, message: '请填写版本号', trigger: 'blur' },
                    ],
                    platform: [
                        { required: true, message: '请选择平台', trigger: 'blur' },
                    ],
                    address: [
                        { required: true, message: '请填写更新地址', trigger: 'blur' },
                    ],
                    max: [
                        { required: true, message: '请选择最大版本', trigger: 'blur' },
                    ],
                    min: [
                        { required: true, message: '请选择最小版本', trigger: 'blur' },
                    ],
                    content: [
                        { required: true, message: '请填写更新内容', trigger: 'blur' },
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
            handleTagClose (tag) {
                this.ruleForm.content.splice(this.ruleForm.content.indexOf(tag), 1);
            },
            showInput () {
                this.inputVisible = true;
                this.$nextTick( _ => {
                    this.$refs.saveTagInput.$refs.input.focus();
                });
            },
            handleInputConfirm () {
                let inputValue = this.inputValue;
                if (inputValue) {
                    this.ruleForm.content.push(inputValue);
                }
                this.inputVisible = false;
                this.inputValue = '';
            },
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
