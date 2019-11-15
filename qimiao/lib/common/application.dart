
import 'package:flutter/material.dart';
import 'package:qimiao/common/config/config.dart';
import 'package:qimiao/common/router/router.dart';
import 'package:qimiao/common/utils/util.dart';
import 'package:qimiao/common/services/service.dart';


class Application {

  // 获取配置
  static Config get config {
    return new Config();
  }

  // 获取路由
  static Router get router {
    return new Router();
  }

  // 获取工具
  static Util get util {
    return new Util();
  }

  // 获取服务
  static Service get service {
    return new Service();
  }

  static BuildContext context;

}