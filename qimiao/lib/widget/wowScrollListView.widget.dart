
import 'package:flutter/material.dart';

class WowScrollListView extends StatefulWidget {

  WowScrollListView({
    @required this.onRefresh,
    @required this.onLoad,
    @required this.data,
    @required this.total,
    @required this.itemBuilder,
  });

  final Function onRefresh;
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
      if (position.maxScrollExtent - position.pixels < 30) {
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
    int total = widget.total ?? 0;
    return new RefreshIndicator(
      onRefresh: _handleRefresh,
      child: new ListView.builder(
        padding: const EdgeInsets.all(0),
        physics: new AlwaysScrollableScrollPhysics(),
        controller: _scrollController,
        itemCount: _isLoading ? count + 1 : count,
        itemBuilder: (context, index) {
          if (index < count) {
            return widget.itemBuilder(context, index);
          }
          return _widgetMoreCellItem(count: count, total: total);
        },
      ),
    );
  }

  Widget _widgetMoreCellItem ({
    int count,
    int total,
  }) {
    return new Center(
      child: new Padding(
        padding: const EdgeInsets.all(20.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            count == total ? new Container() : new SizedBox(
              width: 15,
              height: 15,
              child: new CircularProgressIndicator(
                strokeWidth: 1.0,
              ),
            ),
            new SizedBox(width: 10.0),
            new Text(
              total == 0 ? '' : count == total ? '没有更多啦' : '加载中...',
              style: new TextStyle(fontSize: 12.0, color: Color(0xff999999)),
            ),
          ],
        ),
      ),
    );
  }

  // 刷新
  Future<void> _handleRefresh() async {
    setState(() => _isLoading = false);
    await widget.onRefresh();
  }

  // 加载
  void _loadingMore () async {
    print('widget.data?.length != 0 => ${widget.data?.length != 0}');
    if (!_isLoading) {
      setState(() => _isLoading = true);
      int total = widget.total ?? 0;
      int count = widget.data?.length ?? 0;
      if (total <= count) return null;
      widget.onLoad(callback: () {
        setState(() => _isLoading = false);
      });
    }
  }
}
