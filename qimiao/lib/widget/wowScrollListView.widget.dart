
import 'package:flutter/material.dart';

class WowScrollListView extends StatefulWidget {

  WowScrollListView({
    @required this.onRefresh,
    @required this.onLoad,
    @required this.data,
    @required this.total,
    @required this.itemBuilder,
  });

  final RefreshCallback onRefresh;
  final Function onLoad;
  final Function itemBuilder;
  final List data;
  final int total;

  @override
  _WowScrollListViewState createState() => _WowScrollListViewState();
}

class _WowScrollListViewState extends State<WowScrollListView> {

  ScrollController _scrollController;
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = new ScrollController();
    _scrollController.addListener(() {
      var position = _scrollController.position;
      // 小于50px时，触发上拉加载；
      if (position.maxScrollExtent - position.pixels < 50) {
        this._loadingMore();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int count = widget.data?.length ?? 0;
    return new RefreshIndicator(
      onRefresh: widget.onRefresh,
      child: new ListView.builder(
        physics: new AlwaysScrollableScrollPhysics(),
        controller: _scrollController,
        itemCount: _isLoading ? count + 1 : count,
        itemBuilder: (context, index) {
          if (index < count) {
            return widget.itemBuilder(context, index);
          }
          return _widgetMoreCellItem(count: count);
        },
      ),
    );
  }

  Widget _widgetMoreCellItem ({
    int count,
  }) {
    return new Center(
      child: new Padding(
        padding: const EdgeInsets.all(10.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            count == widget.total ? new Container() : new SizedBox(
              width: 20,
              height: 20,
              child: new CircularProgressIndicator(
                strokeWidth: 4.0,
              ),
            ),
            new Padding(
              padding: new EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: new Text(
                count == widget.total ? '加载完毕' : '加载中...',
                style: new TextStyle(fontSize: 14.0, color: Color(0xff999999)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //
  void _loadingMore () async {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });
      int total = widget.total ?? 0;
      int len = widget.data?.length ?? 0;
      if (total == len) return null;
      widget.onLoad(callback: () {
        setState(() => _isLoading = false);
      });
    }
  }
}
