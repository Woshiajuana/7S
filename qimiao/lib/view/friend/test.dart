import 'package:flutter/material.dart';

//import 'package:bh_duomaike_app/util/tools.dart';

class SliverAppBarPage extends StatefulWidget {
  SliverAppBarPage({
    this.widgets,
    this.headerView,
    this.height = 200,
    this.background,
  });

  final List<Widget> widgets;
  final Widget headerView;
  final Widget background;
  final double height;

  @override
  State<StatefulWidget> createState() => new SliverAppBarPageState();
}

class SliverAppBarPageState extends State<SliverAppBarPage>
    with TickerProviderStateMixin {
  TabController _tabC;
  ScrollController _ctl = new ScrollController();
  int type;
  List tabs;
  WidgetsBinding _binding = WidgetsBinding.instance;

  @override
  void initState() {
    super.initState();

    tabs = ['商品', '評價', '詳情'];
    _tabC = new TabController(length: tabs.length, vsync: this);
    _tabC.addListener(() => _onTabChanged());
  }

  _onTabChanged() {
    setState(() {
      switch (_tabC.index) {
        case 0:
          _binding.addPostFrameCallback((callback) => _ctl.jumpTo(0.1));
          type = 0;
          break;
        case 1:
          type = 1;
          break;
        case 2:
          type = 2;
          break;
      }
    });
  }

  List<Widget> _sliverBuilder(BuildContext context, bool innerBoxIsScrolled) {
    return <Widget>[
      new SliverAppBar(
        centerTitle: true,
        expandedHeight: widget.height,
        floating: false,
        pinned: true,
        backgroundColor: Colors.white,
        elevation: 0,
        brightness: Brightness.light,
        leading: new InkWell(
          child: innerBoxIsScrolled
              ? new Container(
            width: 15,
            height: 20.0,
            child: new Image.asset('assets/images/nav_ic_back.webp',
                color: innerBoxIsScrolled ? Colors.red : Colors.white),
          )
              : new Container(
            padding: EdgeInsets.only(left: 10.0),
            alignment: Alignment.center,
            child: new Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 0, 0, 0.2),
                  borderRadius: BorderRadius.circular(17.5)),
              child: new Image.asset('assets/images/nav_ic_back.webp',
                  color:
                  innerBoxIsScrolled ? Colors.red : Colors.white),
            ),
          ),
          onTap: () => Navigator.pop(context),
        ),
        title: new Text(
          innerBoxIsScrolled ? '商品詳情' : '',
          style: TextStyle(color: Color(0xff000000), fontSize: 19.0),
        ),
        bottom: innerBoxIsScrolled
            ? new PreferredSize(
            child: new Container(
              padding: EdgeInsets.symmetric(horizontal: 80.0),
              child: new TabBar(
                  controller: _tabC,
                  indicatorSize: TabBarIndicatorSize.label,
                  labelColor: Color(0xffFF4F73),
                  indicatorColor: Color(0xffFF4F73),
                  unselectedLabelColor: Color(0xff000000),
                  labelStyle: new TextStyle(fontSize: 14.0),
                  labelPadding: EdgeInsets.only(bottom: 20),
                  indicatorPadding: EdgeInsets.only(
                      bottom: 15, top: 10, left: 5, right: 5.0),
                  tabs: tabs.map((item) => new Text('$item')).toList()),
            ),
            preferredSize: Size(30, 50))
            : null,
        actions: <Widget>[],
        flexibleSpace: new FlexibleSpaceBar(
            centerTitle: true,
            title: widget.headerView,
            background: widget.background),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new NestedScrollView(
          controller: _ctl,
          headerSliverBuilder: _sliverBuilder,
//        body: new SingleChildScrollView(
//          controller: _ctl,
//            child: new Column(children: widget.widgets)),
//      ),
          body: new BodyView(widget.widgets, type)),
    );
  }
}

class BodyView extends StatefulWidget {
  final List<Widget> widgets;
  final int type;

  BodyView(this.widgets, this.type);

  @override
  _BodyViewState createState() => _BodyViewState();
}

class _BodyViewState extends State<BodyView> {
  Type typeOf<T>() => T;
  ScrollController _innerC;
  WidgetsBinding _binding = WidgetsBinding.instance;

  _actions(int type) {
    setState(() {
      _binding.addPostFrameCallback((callback) {
        switch (type) {
          case 1:
            _innerC.jumpTo(1000);
            print(_innerC.position.maxScrollExtent);
            break;
          case 2:
            _innerC.jumpTo(2000);
            break;
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    PrimaryScrollController primaryScrollController =
    context.ancestorWidgetOfExactType(typeOf<PrimaryScrollController>());
    _innerC = primaryScrollController.controller;
  }

  @override
  Widget build(BuildContext context) {
    _actions(widget.type);
    return new SingleChildScrollView(
      child: new Column(children: widget.widgets),
    );
  }
}