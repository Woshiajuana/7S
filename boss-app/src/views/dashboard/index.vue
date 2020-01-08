<template>
    <div class="view-wrap">
        <div class="view-inner">
            <img class="view-logo" :src="objAppInfo.logo || objDefAppInfo.logo" alt="logo"/>
            <div class="view-title">
                <h2>欢迎111123123131131231231231212</h2>
<!--                <h3>使用{{objAppInfo.name || objDefAppInfo.name}}</h3>-->
            </div>
        </div>
    </div>
</template>

<script>
    // import { mapGetters }                   from 'vuex'

    export default {
        name: 'Dashboard',
        computed: {
            // ...mapGetters([ 'objAppInfo', 'objDefAppInfo' ]),
        },
    }
</script>

<style lang="scss" scoped>
    @import "~@assets/scss/define.scss";
    .view-wrap{
        @extend %df;
    }
    .view-inner {
        @extend %bsb;
        @extend %df1;
        @extend %df;
        @extend %aic;
        @extend %jcc;
        padding-bottom: 160px;
        background-color: #fff;
        border-radius: 4px;
    }
    .view-logo{
        width: 140px;
        height: 140px;
        margin-right: 10px;
    }
    .view-title{
        line-height: 1.5;
        h2 {
            @extend %fwn;
            @extend %c6;
            margin: 0;
            font-size: 36px;
        }
        h3{
            @extend %fwn;
            @extend %c9;
            margin: 0;
            font-size: 16px;
        }
    }
</style>
