

class Env {

  static final Env _env = Env._internal();

  factory Env () {
    return _env;
  }

  Env._internal();

  String get baseUrl {
    return 'http://mall-boss-api.dev.ptjxd.com/api/v1/';
  }

  List<String> get arrSucCode {
    return ['000000', 'S0001'];
  }

  String get platformNo {
    return 'P001';
  }

}