
import 'package:flutter/material.dart';

class Style {

  static final Style _style = Style._internal();

  factory Style () {
    return _style;
  }

  static const String TAO_BAO_FAMILY = 'taobaoIconFont';

  Style._internal();

  String get srcAddress {
    return 'assets/images/address-icon.png';
  }

  String get srcLogo {
    return 'assets/images/app-logo-icon-100.png';
  }

  String get srcGoodsNull {
    return 'assets/images/goods-icon-null-bg.jpg';
  }

  String get srcDemoUrl {
    return 'https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=3245994356,1314206822&fm=26&gp=0.jpg';
  }

  IconData get iconSearch {
    return IconData(0xe7da, fontFamily: TAO_BAO_FAMILY);
  }

  Color get backgroundColor {
    return Color(0xfff2f2f2);
  }

  Color get mainColor {
    return Color(0xffec642f);
  }

  Color get subMainColor {
    return Color(0xff71cdbe);
  }

  Color get unselectedLabelColor {
    return Color(0xff999999);
  }

  MaterialColor get primarySwatch {
    return const MaterialColor(
      0xffec642f,
      const <int, Color>{
        50: const Color(0xffec642f),
        100: const Color(0xffec642f),
        200: const Color(0xffec642f),
        300: const Color(0xffec642f),
        400: const Color(0xffec642f),
        500: const Color(0xffec642f),
        600: const Color(0xffec642f),
        700: const Color(0xffec642f),
        800: const Color(0xffec642f),
        900: const Color(0xffec642f),
      },
    );
  }

}