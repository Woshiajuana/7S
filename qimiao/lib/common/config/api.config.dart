

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
  
}