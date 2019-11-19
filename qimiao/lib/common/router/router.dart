
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:qimiao/view/app.view.dart';
import 'package:qimiao/view/world/world.view.dart';
import 'package:qimiao/view/calendar/calendar.view.dart';
import 'package:qimiao/view/mine/mine.view.dart';
import 'package:qimiao/view/splash/splash.view.dart';
import 'package:qimiao/view/webview/webview.view.dart';
import 'package:qimiao/view/about/about.view.dart';
import 'package:qimiao/view/login/login.view.dart';
import 'package:qimiao/view/register/register.view.dart';
import 'package:qimiao/view/setting/setting.view.dart';

class Router {

  static final Router _router = Router._internal();

  factory Router () {
    return _router;
  }

  Router._internal();

  static Map<String, Map<String, dynamic>> config = {
    '/': {
      'route': (_) => new SplashView(),
      'handle': (params) {
        return new SplashView();
      }
    },
    'app': {
      'route': (_) => new AppView(),
      'handle': (params) {
        return new AppView();
      }
    },
    'word': {
      'route': (_) => new WorldView(),
      'handle': (params) {
        return new WorldView();
      }
    },
    'calendar': {
      'route': (_) => new CalendarView(),
      'handle': (params) {
        return new CalendarView();
      }
    },
    'mine': {
      'route': (_) => new MineView(),
      'handle': (params) {
        return new MineView();
      }
    },
    'setting': {
      'route': (_) => new SettingView(),
      'handle': (params) {
        return new SettingView();
      }
    },
    'login': {
      'route': (_) => new LoginView(),
      'handle': (params) {
        return new LoginView();
      }
    },
    'register': {
      'route': (_) => new RegisterView(),
      'handle': (params) {
        return new RegisterView();
      }
    },
    'webview': {
      'route': (_) => new WebviewView(),
      'handle': (params) {
        return new WebviewView(
          title: params['title'],
          url: params['url'],
        );
      }
    },
    'about': {
      'route': (_) => new AboutView(),
      'handle': (params) {
        return new AboutView();
      }
    },
  };

  static Map<String, WidgetBuilder> _routes;

  Map<String, WidgetBuilder> get routes {
    if (_routes != null) return _routes;
    _routes = {};
    config.forEach((key, value) {
      _routes[key] = value['route'];
    });
    return _routes;
  }

  push (BuildContext context, routeName, {params}) {
    print(config[routeName]);
    return navigatorRouter(context, config[routeName]['handle'](params));
  }

  replace (BuildContext context, String routeName) {
    return Navigator.pushReplacementNamed(context, routeName);
  }

  pop (BuildContext context, {params}) {
    return Navigator.of(context).pop(params);
  }

  // 修改路由动画
  static navigatorRouter(BuildContext context, Widget widget) {
    return Navigator.push(context, new CupertinoPageRoute(builder: (context) => widget));
  }

}