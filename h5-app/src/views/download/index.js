
import DeviceUtil       from 'utils/device.util'
import Toast            from 'utils/toast.util'

// 列表控制器
const DownloadController = {
    $elBtn: $('#button'),
    device: {},
    init () {
        this.getDeviceInfo();
        this.addEvent();
    },
    getDeviceInfo () {
        this.device = DeviceUtil.get();
    },
    addEvent() {
        this.$elBtn.on('click', this.handleDown.bind(this));
    },
    handleDown () {
        if (this.device.isIphone)
            return Toast.msg('很抱歉暂时还未发布苹果版本');
        if (this.isWeChat && this.isQq)
            return Toast.msg('请使用系统浏览器打开本页面进行下载');
        window.location.href = '';
    },
};

DownloadController.init();
