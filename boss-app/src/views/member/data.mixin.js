
const data = () => {
    return {
        arrTable: [],
        objSex: {
            0: '保密',
            1: '男',
            2: '女',
        },
        objQuery: {
            numIndex: 1,
            numSize: 10,
            numTotal: 0,
            isLoading: false,
        },
        objFilterForm: {
            keyword: {
                value: '',
                label: '',
                placeholder: '邮箱/昵称',
                style: 'width: 200px; margin-right: 5px;',
                mode: 'input',
            },
        },
        arrFilterButton: [
            {
                text: '查询',
                loading: false,
                type: 'primary',
                icon: 'el-icon-search',
                event: 'filter',
            },
        ],
    };
};

export default {
    data,
}
