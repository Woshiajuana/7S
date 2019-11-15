
import 'package:flutter/material.dart';

class ParamsExplainWidget extends StatelessWidget {

  const ParamsExplainWidget({
    Key key,
    this.paramsExplain = '',
  }) : super(key: key);

  final String paramsExplain;

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.only(top: 10.0),
      decoration: new BoxDecoration(
        color: Colors.white,
        border: new Border(
          top: new BorderSide(
            color: Color(0xffdddddd),
            width: 0.5,
          ),
          bottom: new BorderSide(
            color: Color(0xffdddddd),
            width: 0.5,
          ),
        ),
      ),
      padding: const EdgeInsets.all(10.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _widgetTitleSection(),
          _widgetParamsSection(),
        ],
      ),
    );
  }

  Widget _widgetTitleSection () {
    return new Container(
      child: new Text(
        '参数属性：',
        style: new TextStyle(
          color: Color(0xff333333),
          fontSize: 16.0,
        ),
      ),
    );
  }

  Widget _widgetParamsSection () {
    return new Container(
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: new BoxDecoration(
        color: Color(0xff333333),
        borderRadius: new BorderRadius.circular(6.0),
      ),
      child: new Row(
        children: <Widget>[
          new Text(
            paramsExplain,
            style: new TextStyle(
              color: Colors.white,
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }
}
