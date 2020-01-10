
<template>
    <el-drawer
        class="drawer-view"
        title="预览"
        :before-close="handleClose"
        :visible.sync="display"
        direction="rtl"
        size="50%"
        custom-class="demo-drawer"
        ref="drawer">
        <div class="demo-drawer__content">
            <div class="image">
                <img :src="strPathUrl"/>
            </div>
            <el-input v-model="strPathUrl" disabled placeholder="重定向路径，例：admin/user"></el-input>
        </div>
        <div class="demo-drawer__footer">
            <el-button @click="handleClose">关闭</el-button>
        </div>
    </el-drawer>
</template>

<script>

    export default {
        data () {
            return  {
                strPathUrl: '',
            };
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
                this.data = '';
            },
            assignmentData () {
                this.$nextTick(() => {
                    let { data } = this.data;
                    this.strPathUrl = `${data.base}${data.path}${data.filename}`;
                });
            },
        },
    };
</script>

<style lang="scss">
    @import "~@assets/scss/define.scss";
    .image{
        @extend %tac;
        @extend %oh;
        background-color: #f2f2f2;
        height: 360px;
        margin-bottom: 50px;
        border: 1px #ddd solid;
        img{
            @extend %h100;
            width: auto;
        }
    }
</style>
