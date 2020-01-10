
const data = () => {

    const arrPlatform = [
        { label: '安卓', value: 'android' },
        { label: 'iOS', value: 'iOS' },
    ];

    let objPlatform = {};
    arrPlatform.forEach(({ label, value }) => objPlatform[value] = label);

    return {
        arrTable: [],
        objQuery: {
            numIndex: 1,
            numSize: 10,
            numTotal: 0,
            isLoading: false,
        },
        objPlatform,
        objFilterForm: {
            keyword: {
                value: '',
                label: '',
                placeholder: '版本号/备注',
                style: 'width: 200px; margin-right: 5px;',
                mode: 'input',
            },
            type: {
                value: '',
                label: '',
                placeholder: '平台',
                style: 'width: 200px; margin-right: 5px;',
                mode: 'select',
                options: arrPlatform,
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
            {
                text: '新增',
                type: 'primary',
                icon: 'el-icon-plus',
                event: 'add',
            }
        ],
    };
};

export default {
    data,
}
