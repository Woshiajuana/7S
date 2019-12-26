
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Store {

  static final Store _store = Store._internal();

  factory Store () {
    return _store;
  }

  Store._internal();

  static SharedPreferences _sharedPreferences;

  static Future _init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future get (String key) async {
    if (_sharedPreferences == null) {
      await _init();
    }
    var value = _sharedPreferences.get(key);
    try {
      value = json.decode(value);
    } catch (err) {

    }
    return value;
  }

  // 保存
  Future set (String key, dynamic value) async {
    if (_sharedPreferences == null) {
      await _init();
    }
    try {
      value = json.encode(value);
    } catch (err) {

    }
    await  _sharedPreferences.setString(key, value);
  }

  // 删除
  Future remove (String key) async {
    if (_sharedPreferences == null) {
      await _init();
    }
    await _sharedPreferences.remove(key);
  }

  // 删除
  Future clear () async {
    if (_sharedPreferences == null) {
      await _init();
    }
    await _sharedPreferences.clear();
  }

}