
import 'package:dio/dio.dart';
import 'package:qimiao/common/application.dart';
import 'package:qimiao/model/json/json.model.dart';

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
      String userInfoJsonKey = Application.config.store.userInfoJson;
      var userInfoJson = await Application.util.store.get(userInfoJsonKey);
      if (userInfoJson != null) {
        options.headers = {
          'access-token': userInfoJson['access_token'],
        };
      }
      return options;
    }, onResponse: (Response response) {
      _log(response.request.path, '请求返回结果=> ${response.data}');
      var data = response.data;
      if (data == null)
        return _dio.reject(new DioError(response: response));
      var respCode = data['resp_code'] ?? data['respCode'];
      if (Application.config.env.arrSucCode.indexOf(respCode) == -1)
        return _dio.reject(new DioError(response: response));
      response.data = data['data'] ?? data['result'];
      return response;
    }, onError: (DioError dioErr) {
      _log(dioErr?.response?.request?.path ?? '', '请求返回结果=> ${dioErr.toString()}');
      Response response = dioErr?.response;
      int stateCode = response?.statusCode ?? -999;
      var message = '网络繁忙，请稍后再试';
      if (dioErr.type == DioErrorType.RECEIVE_TIMEOUT
      || dioErr.type == DioErrorType.CONNECT_TIMEOUT) {
        message = '网络超时，请稍后再试';
      } else if (response != null) {
        message = response.data['resp_message'] ?? response.data['respMessage'] ?? '网络繁忙，请稍后再试';
      }
      if (stateCode == 401) {
        Application.router.replace(Application.context, 'login');
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

  Future post (String url, {Map params, Options options}) async {
    if (_dio == null) {
      await _init();
    }
    _log(url, '请求发起参数=> $params');
    Response response = await _dio.post(url, data: params, options: options);
    return response.data;
  }

  Future request (String url, {Map<String, dynamic> params, Options options}) async {
    if (_dio == null) {
      await _init();
    }
    _log(url, '请求发起参数=> $params');
    return await _dio.request(url, data: params, options: options);
  }
}