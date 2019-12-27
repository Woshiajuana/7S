

class Env {

  static final Env _env = Env._internal();

  factory Env () {
    return _env;
  }

  Env._internal();

  String get baseUrl {
//    return 'http://192.168.3.195:9002/api/';
    return 'http://154.8.209.13:9002/api/';
  }

  List<String> get arrSucCode {
    return ['S00000'];
  }

  String get platformNo {
    return 'P001';
  }

}