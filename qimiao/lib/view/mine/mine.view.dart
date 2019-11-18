
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';

class MineView extends StatefulWidget {
  @override
  _MineViewState createState() => _MineViewState();
}

class _MineViewState extends State<MineView> {


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Application.config.style.backgroundColor,
      body: new ListView(),
    );
  }

  

}
