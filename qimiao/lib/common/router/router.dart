
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:qimiao/view/app.view.dart';
import 'package:qimiao/view/world/world.view.dart';
import 'package:qimiao/view/freezeFrame/freezeFrame.view.dart';
import 'package:qimiao/view/freezeFrame/details.dart';
import 'package:qimiao/view/mine/mine.view.dart';
import 'package:qimiao/view/notice/notice.view.dart';
import 'package:qimiao/view/notice/details.view.dart';
import 'package:qimiao/view/device/device.view.dart';
import 'package:qimiao/view/splash/splash.view.dart';
import 'package:qimiao/view/webview/webview.view.dart';
import 'package:qimiao/view/about/about.view.dart';
import 'package:qimiao/view/login/login.view.dart';
import 'package:qimiao/view/register/register.view.dart';
import 'package:qimiao/view/setting/setting.view.dart';
import 'package:qimiao/view/video/videoList.view.dart';
import 'package:qimiao/view/video/details.dart';
import 'package:qimiao/view/photo/photoList.view.dart';
import 'package:qimiao/view/photo/details.dart';
import 'package:qimiao/view/collect/collectList.view.dart';
import 'package:qimiao/view/history/historyList.view.dart';
import 'package:qimiao/view/friend/friend.view.dart';
import 'package:qimiao/view/mine/center.view.dart';
import 'package:qimiao/view/mine/nickname.view.dart';
import 'package:qimiao/view/mine/uid.view.dart';
import 'package:qimiao/view/mine/qrCode.view.dart';
import 'package:qimiao/view/password/change.view.dart';
import 'package:qimiao/view/password/reset.view.dart';
import 'package:qimiao/view/mine/signature.view.dart';
import 'package:qimiao/view/friend/info.view.dart';
import 'package:qimiao/view/search/search.view.dart';

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
    'freezeFrame': {
      'route': (_) => new FreezeFrameView(),
      'handle': (params) {
        return new FreezeFrameView();
      }
    },
    'freezeFrameDetails': {
      'route': (_) => new FreezeFrameDetailsView(),
      'handle': (params) {
        return new FreezeFrameDetailsView();
      }
    },
    'mine': {
      'route': (_) => new MineView(),
      'handle': (params) {
        return new MineView();
      }
    },
    'notice': {
      'route': (_) => new NoticeView(),
      'handle': (params) {
        return new NoticeView();
      }
    },
    'noticeDetails': {
      'route': (_) => new NoticeDetailsView(),
      'handle': (params) {
        return new NoticeDetailsView(
          title: params['title'] ?? '',
        );
      }
    },
    'videoList': {
      'route': (_) => new VideoListView(),
      'handle': (params) {
        return new VideoListView();
      }
    },
    'videoDetails': {
      'route': (_) => new VideoDetailsView(),
      'handle': (params) {
        return new VideoDetailsView();
      }
    },
    'photoList': {
      'route': (_) => new PhotoListView(),
      'handle': (params) {
        return new PhotoListView();
      }
    },
    'photoDetails': {
      'route': (_) => new PhotoDetailsView(),
      'handle': (params) {
        return new PhotoDetailsView();
      }
    },
    'collectList': {
      'route': (_) => new CollectListView(),
      'handle': (params) {
        return new CollectListView();
      }
    },
    'friend': {
      'route': (_) => new FriendView(),
      'handle': (params) {
        return new FriendView();
      }
    },
    'friendInfo': {
      'route': (_) => new FriendInfoView(),
      'handle': (params) {
        return new FriendInfoView();
      }
    },
    'historyList': {
      'route': (_) => new HistoryListView(),
      'handle': (params) {
        return new HistoryListView();
      }
    },
    'mineCenter': {
      'route': (_) => new MineCenterView(),
      'handle': (params) {
        return new MineCenterView();
      }
    },
    'mineNickname': {
      'route': (_) => new MineNicknameView(),
      'handle': (params) {
        return new MineNicknameView(
          nickname: params['nickname'],
        );
      }
    },
    'mineUid': {
      'route': (_) => new MineUidView(),
      'handle': (params) {
        return new MineUidView();
      }
    },
    'mineQrCode': {
      'route': (_) => new MineQrCodeView(),
      'handle': (params) {
        return new MineQrCodeView();
      }
    },
    'mineSignature': {
      'route': (_) => new MineSignatureView(),
      'handle': (params) {
        return new MineSignatureView();
      }
    },
    'passwordChange': {
      'route': (_) => new PasswordChangeView(),
      'handle': (params) {
        return new PasswordChangeView();
      }
    },
    'passwordReset': {
      'route': (_) => new PasswordResetView(),
      'handle': (params) {
        return new PasswordResetView(
          email: params['email'],
        );
      }
    },
    'device': {
      'route': (_) => new DeviceView(),
      'handle': (params) {
        return new DeviceView();
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
        return new RegisterView(
          email: params['email'],
        );
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
    'search': {
      'route': (_) => new SearchView(),
      'handle': (params) {
        return new SearchView();
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