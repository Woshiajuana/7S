

class Api {

  static final Api _api = Api._internal();

  factory Api () {
    return _api;
  }

  Api._internal();

  // 登录
  String get doUserLogin {
    return 'v1/app/user/login';
  }

  // 查询用户信息
  String get reqUserInfo {
    return 'v1/app/user/info';
  }

  // 用户重置图形验证码
  String get doUserResetCaptcha {
    return 'v1/app/user/reset/captcha';
  }

  // 用户发送邮件验证码
  String get doSendEmailCaptcha {
    return 'v1/app/captcha/send';
  }

  // 用户注册
  String get doUserRegister {
    return 'v1/app/user/register';
  }

  // 用户重置密码
  String get doUserResetPassword {
    return 'v1/app/user/reset/password';
  }

  // 用户修改密码
  String get doUserChangePassword {
    return 'v1/app/user/change/password';
  }

  // 用户修改信息
  String get doUserUpdateInfo {
    return 'v1/app/user/update';
  }

  // 用户上传文件
  String get doFileUpload {
    return 'v1/app/file/upload';
  }

  // 获取通知列表
  String get reqNoticeList {
    return 'v1/app/notice/list';
  }

  // 获取通知内容
  String get reqNoticeInfo {
    return 'v1/app/notice/info';
  }

  // 获取图片作品列表
  String get reqPhotoList {
    return 'v1/app/photo/list';
  }

  // 创建图片作品
  String get doPhotoCreate {
    return 'v1/app/photo/create';
  }

  // 删除图片作品
  String get doPhotoDelete {
    return 'v1/app/photo/del';
  }

  // 编辑图片作品
  String get doPhotoUpdate {
    return 'v1/app/photo/update';
  }

  // 查询图片作品
  String get reqPhotoInfo {
    return 'v1/app/photo/info';
  }

  // 推荐图片作品
  String get reqPhotoRecommend {
    return 'v1/app/photo/recommend';
  }

  // 关注 or 取消关注
  String get doFollowUpdate {
    return 'v1/app/follow/update';
  }

  // 关注列表
  String get reqFollowingList {
    return 'v1/app/following/list';
  }

  // 粉丝列表
  String get reqFollowerList {
    return 'v1/app/follower/list';
  }

  // 搜索预览
  String get reqSearchPreview {
    return 'v1/app/search/preview';
  }

}