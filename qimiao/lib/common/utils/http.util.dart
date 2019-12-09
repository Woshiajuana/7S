
import 'package:dio/dio.dart';
import 'package:qimiao/common/application.dart';
import 'package:qimiao/model/json/json.model.dart';
import 'package:flutter/material.dart';
import 'package:qimiao/widget/widget.dart';

class Http {

  static final Http _http = Http._internal();

  factory Http () {
    return _http;
  }

  Http._internal();

  static Dio _dio;
  static BaseOptions _options = new BaseOptions(
    baseUrl: Application.config.env.baseUrl,
    connectTimeout: 1000 * 10,
    receiveTimeout: 1000 * 20,
  );

  static Future _init() async {
    _dio = new Dio(_options);
    _dio.interceptors
    .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      String accessToken = await Application.util.store.get(Application.config.store.accessToken);
      print('请求的 token=> ${accessToken}');
      if (accessToken != null) {
        options.headers = {
          'access-token': accessToken,
        };
      }
      return options;
    }, onResponse: (Response response) {
      var data = response.data;
      _log(response.request.path, '请求返回结果=> $data');
      if (data == null)
        return _dio.reject(new DioError(response: response));
      return response;
    }, onError: (DioError dioErr) async {
      _log(dioErr?.response?.request?.path ?? '', '请求返回结果=> ${dioErr.toString()}');
      var data = dioErr?.response?.data;
      int stateCode = dioErr?.response?.statusCode ?? -999;
      var message = '网络繁忙，请稍后再试';
      if ([DioErrorType.RECEIVE_TIMEOUT,  DioErrorType.CONNECT_TIMEOUT].indexOf(dioErr.type) > -1) {
        message = '网络超时，请稍后再试';
      } else if (stateCode >=200 && stateCode < 300 && data != null) {
        ResponseJsonModel responseJsonModel = ResponseJsonModel.fromJson(data);
        message = responseJsonModel.msg;
      }
      dioErr.message = message;
      return dioErr;
    }));
  }

  static void _log (String url, String content) {
    if (url != null && url != '' && url.indexOf('http') == -1) {
      url = Application.config.env.baseUrl + url;
    }
    Application.util.print.info('[$url] $content}');
  }

  Future get (String url, {Map params, Options options}) async {
    if (_dio == null) {
      await _init();
    }
    Response response = await _dio.get(url, queryParameters: params, options: options);
    return response.data;
  }

  Future post (String url, {
    Map params,
    Options options,
    bool useFilter = true,
    bool useLoading = true,
  }) async {
    if (_dio == null) {
      await _init();
    }
    _log(url, '请求发起参数=> $params');
    if (useLoading) Application.util.loading.show(Application.context);
    Response response;
    try {
      response = await _dio.post(url, data: params, options: options);
    } catch (e) {
      if (useLoading) Application.util.loading.hide();
      throw e;
    }
    ResponseJsonModel responseJsonModel = ResponseJsonModel.fromJson(response?.data);
    if (['F40000', 'F40001', 'F40002', 'F40003'].indexOf(responseJsonModel.code) > -1) {
      await Application.util.store.remove(Application.config.store.userJson);
      Application.router.replace(Application.context, 'login');
      throw responseJsonModel.msg;
    }
    if (useFilter && Application.config.env.arrSucCode.indexOf(responseJsonModel.code) == -1) {
      await Application.util.store.remove(Application.config.store.userJson);
      Application.router.replace(Application.context, 'login');
      await showDialog(
        context: Application.context,
        builder: (BuildContext buildContext) {
          return new WillPopScope(
            onWillPop: () async {
              return Future.value(false);
            },
            child: new AlertToastDialog(
              content: responseJsonModel.msg,
            ),
          );
        },
      );
      throw '请重新登录';
    }
    return useFilter ? responseJsonModel.data : responseJsonModel;
  }

  Future request (String url, {Map<String, dynamic> params, Options options}) async {
    if (_dio == null) {
      await _init();
    }
    _log(url, '请求发起参数=> $params');
    return await _dio.request(url, data: params, options: options);
  }
}