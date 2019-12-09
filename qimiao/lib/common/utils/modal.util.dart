
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qimiao/common/application.dart';

class Modal {

  static final Modal _modal = Modal._internal();

  factory Modal () {
    return _modal;
  }

  Modal._internal();

  void toast (msg, {ToastGravity gravity = ToastGravity.BOTTOM}) {
    if (msg is DioError) {
      msg = msg.message ?? msg.msg;
    }
    if (msg == '' || msg == null) return;
    Application.util.print.info(msg.toString());
    Fluttertoast.showToast(
      gravity: gravity,
      msg: msg.toString(),
    );
  }

}