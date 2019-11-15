
import 'package:qimiao/common/services/user.service.dart';

class Service {

  static final Service _service = Service._internal();

  factory Service () {
    return _service;
  }

  Service._internal();

  User get user {
    return new User();
  }

}