

class Store {

  static final Store _store = Store._internal();

  factory Store () {
    return _store;
  }

  Store._internal();

  // TOKEN
  String get accessToken {
    return 'ACCESS_TOKEN';
  }

  // 用户信息
  String get userJson {
    return 'USER_JSON';
  }

  // 用户是否初次打开 APP
  String get firstTime {
    return 'FIRST_TIME';
  }
  
}