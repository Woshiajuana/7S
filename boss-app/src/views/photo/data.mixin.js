
const data = () => {
    return {
        arrTable: [],
        objQuery: {
            numIndex: 1,
            numSize: 10,
            numTotal: 0,
            isLoading: false,
        },
        objNature: {
            'PUBLIC': '公开',
            'PRIVACY': '私有',
        },
        objFilterForm: {
            keyword: {
                value: '',
                label: '',
                placeholder: '标题/用户',
                style: 'width: 200px; margin-right: 5px;',
                mode: 'input',
            },
            nature: {
                value: '',
                label: '',
                placeholder: '性质',
                style: 'width: 200px; margin-right: 5px;',
                mode: 'select',
                options: [
                    { label: '公开', value: 'PUBLIC' },
                    { label: '私有', value: 'PRIVACY' },
                ],
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
