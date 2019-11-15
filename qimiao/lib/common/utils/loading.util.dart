
import 'package:flutter/material.dart';

class Loading {

  static final Loading _loading = Loading._internal();

  factory Loading () {
    return _loading;
  }

  Loading._internal();

  static BuildContext _context;

  void show (BuildContext context, { Function callback, bool barrierDismissible = false }) {
    if (_context != null) return;
    _context = context;
    showDialog(
      barrierDismissible: barrierDismissible,
      context: _context,
      builder: (context) {
        return _widgetLoading();
      },
    ).then((value) {
      _context = null;
      if (callback != null) {
        callback(value);
      }
    });
  }

  void hide () {
    if (_context != null) {
      Navigator.pop(_context);
      _context = null;
    }
  }

  static Widget _widgetLoading () {
    return new Center(
      child: new Container(
        width: 80.0,
        height: 80.0,
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: new Center(
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

}