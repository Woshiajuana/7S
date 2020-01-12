
const data = () => {

    // 类型 [ AVATAR: 头像, VIDEO: 视频,  PHOTO: 照片, COVER: 封面 ]
    const arrType = [
        { label: '头像', value: 'AVATAR' },
        { label: '照片', value: 'PHOTO' },
    ];
    let objType = {};
    arrType.forEach(({ label, value }) => objType[value] = label);
    return {
        arrTable: [],
        objQuery: {
            numIndex: 1,
            numSize: 10,
            numTotal: 0,
            isLoading: false,
        },
        objType,
        objFilterForm: {
            keyword: {
                value: '',
                label: '',
                placeholder: '用户/文件名',
                style: 'width: 200px; margin-right: 5px;',
                mode: 'input',
            },
            type: {
                value: '',
                label: '',
                placeholder: '文件类型',
                style: 'width: 200px; margin-right: 5px;',
                mode: 'select',
                options: arrType,
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
