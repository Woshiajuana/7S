

class Print {

  static final Print _print = Print._internal();

  factory Print () {
    return _print;
  }

  Print._internal();


  void info (info) {
    print('【INFO】:$info');
  }

  void warn (warn) {
    print('【WARN】:$warn');
  }

  void suc (suc) {
    print('【SUCCESS】:$suc');
  }

  void err (err) {
    print('【ERR】:$err');
  }

}