
import 'package:flutter/material.dart';

class WowAppBar extends StatefulWidget implements PreferredSizeWidget {

  WowAppBar({
    @required this.child
  }) : assert(child != null);

  final Widget child;
  @override

  Size get preferredSize {
    return new Size.fromHeight(56.0);
  }

  @override
  State createState() {
    return new WowAppBarState();
  }
}
class WowAppBarState extends State<WowAppBar> {
  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      top: true,
      child: widget.child,
    );
  }
}
