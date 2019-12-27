
import 'package:flutter/material.dart';
import 'package:qimiao/common/common.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class WorldQrScanView extends StatefulWidget {
  @override
  _WorldQrScanViewState createState() => _WorldQrScanViewState();
}

class _WorldQrScanViewState extends State<WorldQrScanView> {

  QRViewController _qrViewController;

  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void dispose() {
    _qrViewController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Application.config.style.backgroundColor,
      body: new Stack(
        children: <Widget>[
          new Container(
            color: Colors.red,
            child: new QRView(
              key: _qrKey,
              onQRViewCreated: _handleQRViewCreated,
            ),
          ),
          _widgetAppBarSection(),
        ],
      ),
    );
  }

  // 返回
  Widget _widgetAppBarSection () {
    return new Positioned(
      left: 0,
      right: 0,
      top: 0,
      child: new Container(
        color: Colors.transparent,
        child: new SafeArea(
          bottom: false,
          child: new Container(
            height: 56.0,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new IconButton(
                  icon: new Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Application.router.pop(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 扫码
  void _handleQRViewCreated (QRViewController controller) {
     try {
       _qrViewController = controller;
       _qrViewController.scannedDataStream.listen((scanData) {
         _qrViewController.pauseCamera();
         Application.router.replace(context, 'wordQrScanResult', params: { 'result': scanData });
//         if (!scanData.startsWith('7S_USER_ID:')) throw '';
       });
     } catch (err) {
       print('1111111111111111');
       Application.util.modal.toast(err);
     }
  }


}
