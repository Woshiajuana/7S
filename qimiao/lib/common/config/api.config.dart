

class Api {

  static final Api _api = Api._internal();

  factory Api () {
    return _api;
  }

  Api._internal();

  static final baseUrl = 'http://192.168.3.195:9002/api';

  // 登录
  String get doUserLogin {
    return '$baseUrl/v1/app/user/login';
  }

  // 查询用户信息
  String get reqUserInfo {
    return '$baseUrl/v1/app/user/info';
  }
  
}