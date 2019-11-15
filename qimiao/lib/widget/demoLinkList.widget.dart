
import 'package:flutter/material.dart';
import 'package:qimiao/widget/cellLink.widget.dart';
import 'package:qimiao/common/application.dart';

class DemoLinkListWidget extends StatelessWidget {

  const DemoLinkListWidget({
    Key key,
    this.demoLinkList,
  }) : super(key: key);

  final List demoLinkList;

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
        ),
      ),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _widgetDemoListSection(context),
      ),
    );
  }

  List<Widget> _widgetDemoListSection (BuildContext context) {
    List<Widget> list = [_widgetTitleSection()];
    list.addAll(demoLinkList.map((item) {
      return new CellLinkWidget(
        labelText: item['labelText'],
        valueText: item['valueText'],
        onPressed: () => Application.router.push(context, item['routeName']),
      );
    }).toList());
    return list;
  }

  Widget _widgetTitleSection () {
    return new Container(
      padding: const EdgeInsets.all(10.0),
      height: 50.0,
      decoration: new BoxDecoration(
        border: new Border(
          bottom: new BorderSide(
            color: Color(0xffdddddd),
            width: 0.5,
          ),
        ),
      ),
      child: new Row(
        children: <Widget>[
          new Text(
            '案例列表：',
            style: new TextStyle(
              color: Color(0xff333333),
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }

}
