

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
  
}