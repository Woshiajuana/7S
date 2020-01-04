<template>
    <div class="wrap">
        <filter-view
            :filter-form="objFilterForm"
            :filter-button="arrFilterButton"
            @filter="reqTableDataList"
        ></filter-view>
        <span>业务页面</span>
        <test-component></test-component>
    </div>
</template>

<script>
    import DialogMixin from '@/mixins/dialog'
    import FilterMixin from '@/mixins/filter'
    import DataMixin from './data.mixin'

    export default {
        name: 'AdminUser1',
        mixins: [
            DataMixin,
            DialogMixin,
            FilterMixin,
        ],
        created () {
            this.$testUtils();
        }
    }
</script>

<style lang="scss" scoped>
    @import "~@assets/scss/define.scss";
    .inner{
        @extend %bsb;
        padding: 10px;
    }
</style>
