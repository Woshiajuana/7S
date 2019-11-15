
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';

class DemoView extends StatefulWidget {
  @override
  _DemoViewState createState() => _DemoViewState();
}

class _DemoViewState extends State<DemoView> {

  List _arrData = [
    {
      'name': 'NestedScrollView',
      'icon': Icons.line_weight,
      'routerName': 'nestedScrollView',
    },
    {
      'name': 'SliverAppBar',
      'icon': Icons.web_asset,
      'routerName': 'sliverAppBar',
    },
    {
      'name': 'ExpansionTile',
      'icon': Icons.list,
      'routerName': 'expansionTile',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Application.config.style.backgroundColor,
      body: new GridView.count(
        padding: EdgeInsets.all(5.0),
        crossAxisCount: 3,
        scrollDirection: Axis.vertical,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
        childAspectRatio: 2 / 2,
        children: _arrData.map((item) {
          return _widgetComponentItem(
            icon: item['icon'],
            nameText: item['name'],
            onPressed: () => Application.router.push(context, item['routerName'], params: {'titleText': item['name']}),
          );
        }).toList(),
      ),
    );
  }

  Widget _widgetComponentItem ({
    IconData icon,
    String nameText = '',
    dynamic onPressed,
  }) {
    return new Container(
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.circular(5.0),
        border: new Border.all(
          color: Color(0xffdddddd),
          width: 0.5,
        )
      ),
      child: new FlatButton(
        onPressed: onPressed,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Icon(
              icon,
              size: 36,
              color: Application.config.style.unselectedLabelColor,
            ),
            new SizedBox(height: 5.0),
            new Text(
              nameText,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: new TextStyle(
                color: Application.config.style.unselectedLabelColor,
                fontSize: 14.0,
              ),
            )
          ],
        ),
      ),
    );
  }

}
