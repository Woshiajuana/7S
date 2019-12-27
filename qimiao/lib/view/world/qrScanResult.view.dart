
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';

class WorldQRScanResultView extends StatefulWidget {

  WorldQRScanResultView({
    this.result = '',
  });

  final String result;

  @override
  _WorldQRScanResultViewState createState() => _WorldQRScanResultViewState();
}

class _WorldQRScanResultViewState extends State<WorldQRScanResultView> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Application.config.style.backgroundColor,
      appBar: new AppBar(
        elevation: 0,
        title: new Text(
          '扫描结果',
          style: new TextStyle(
            fontSize: 18.0,
          ),
        ),
      ),
      body: new Text(
        widget.result ?? '',
        style: new TextStyle(
          color: Color(0xff333333),
          fontSize: 14.0,
        ),
      ),
    );
  }
}

