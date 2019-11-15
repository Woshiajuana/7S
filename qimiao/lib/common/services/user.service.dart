
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:qimiao/common/application.dart';

class User {

  static final User _user = User._internal();

  factory User () {
    return _user;
  }

  User._internal();

  // 用户登录
  Future doUserLogin ({ String phone, String password }) async {
    String url = Application.config.api.doUserLogin;
    Map params = {'phone': phone, 'password': password};
    Options options = new Options(contentType: ContentType.parse('application/x-www-form-urlencoded'));
    var respBody = await Application.util.http.post(url, params: params, options: options);
    url = Application.config.api.doAuthLogin;
    String platformNo = Application.config.env.platformNo;
    params = {'platformNo': platformNo, 'pfUserToken': respBody['userToken']};
    var respBody2 = await Application.util.http.post(url, params: params);
    respBody['access_token'] = respBody2['access_token'];
    return respBody;
  }

  // 获取用户积分


}