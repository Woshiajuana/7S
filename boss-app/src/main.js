
const views = require.context('./views', true, /index\.vue$/);
const components = require.context('./components', true, /index\.vue$/);

let { wow, app } = window.wowRuntime.init({
    // 扩展类配置, 这个类里面的数据都会扩展挂载到 VUE 上
    extendUtils: {
        testUtils: () => { console.log('cacaca') },
    },
    // API配置
    httpRequest: {
        baseURL: `${window.location.protocol}//${window.location.hostname}:9003/`,
        timeout: 60 * 1000,
    },
    // app 常量配置
    appConst: {
        // 会员列表
        REQ_MEMBER_LIST: 'boss/api/v1/user/list',

        // 照片列表
        REQ_PHOTO_LIST: 'boss/api/v1/photo/list',

        // 文件列表
        REQ_FILE_LIST: 'boss/api/v1/file/list',

        // 通知列表
        REQ_NOTICE_LIST: 'boss/api/v1/notice/list',

    },
    // 路由配置
    routerConfig: {
        importViews: [ views ],
    },
    // 组件配置
    component: {
        importComponents: [ components ],
    },
});

console.log(wow);
