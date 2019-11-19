
import 'package:flutter/material.dart';

class AboutView extends StatefulWidget {
  @override
  _AboutViewState createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0,
        title: new Text(
          '关于我们',
          style: new TextStyle(
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}
