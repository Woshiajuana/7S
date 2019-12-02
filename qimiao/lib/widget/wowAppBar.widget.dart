
import 'package:flutter/material.dart';

class WowAppBar extends StatefulWidget implements PreferredSizeWidget {

  WowAppBar({
    this.color,
    this.height,
    @required this.child
  }) : assert(child != null);

  final Widget child;
  final Color color;
  final double height;

  @override
  Size get preferredSize {
    return new Size.fromHeight(height ?? 56.0);
  }

  @override
  State createState() {
    return new WowAppBarState();
  }
}
class WowAppBarState extends State<WowAppBar> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: widget.color ?? Colors.transparent,
      child: new SafeArea(
        top: true,
        child: widget.child,
      ),
    );
  }
}
