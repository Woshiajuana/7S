

import 'package:flutter/material.dart';

class WowButton extends StatelessWidget {

  WowButton({
    Key key,
    this.controller,
  }) :buttonSqueezeanimation = new Tween(
    begin: 320.0,
    end: 70.0,
  ).animate(
    new CurvedAnimation(
      parent: controller,
      curve: new Interval(
        0.0,
        0.150,
      ),
    ),
  ),
  buttomZoomOut = new Tween(
    begin: 70.0,
    end: 1000.0,
  ).animate(
    new CurvedAnimation(
      parent: controller,
      curve: new Interval(
        0.550,
        0.999,
        curve: Curves.bounceOut,
      ),
    ),
  ),
  containerCircleAnimation = new EdgeInsetsTween(
    begin: const EdgeInsets.only(bottom: 50.0),
    end: const EdgeInsets.only(bottom: 0.0),
  ).animate(
    new CurvedAnimation(
      parent: controller,
      curve: new Interval(
        0.500,
        0.800,
        curve: Curves.ease,
      ),
    ),
  ),
  super(key: key);

  final Animation buttonSqueezeanimation;
  final Animation<EdgeInsets> containerCircleAnimation;
  final Animation buttomZoomOut;
  final AnimationController controller;

  Future<Null> _playAnimation() async {
    try {
      print('动画开始执行 内');
      await controller.forward();
//      await buttonController.reverse();
    } on TickerCanceled {}
  }

  @override
  Widget build(BuildContext context) {
    controller.addListener(() {
      if (controller.isCompleted) {
        print('动画执行完成');
      }
    });
    return new AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget child) {
        return new Container(
          child: new Column(
            children: <Widget>[
              new IconButton(icon: new Icon(Icons.print), onPressed: _playAnimation),
              new Hero(tag: 'fade', child: new Text(
                containerCircleAnimation.value.toString(),
              )),
              new Hero(tag: 'fade', child: new Text(
                buttonSqueezeanimation.value.toString(),
              )),
              new Hero(tag: 'fade', child: new Text(
                buttomZoomOut.value.toString(),
              )),
              new InkWell(
                  onTap: () {
                    _playAnimation();
                  },
                  child: new Hero(
                    tag: "fade",
                    child: buttomZoomOut.value <= 300
                        ? new Container(
                        width: buttomZoomOut.value == 70
                            ? buttonSqueezeanimation.value
                            : buttomZoomOut.value,
                        height:
                        buttomZoomOut.value == 70 ? 60.0 : buttomZoomOut.value,
                        alignment: FractionalOffset.center,
                        decoration: new BoxDecoration(
                          color: const Color.fromRGBO(247, 64, 106, 1.0),
                          borderRadius: buttomZoomOut.value < 400
                              ? new BorderRadius.all(const Radius.circular(30.0))
                              : new BorderRadius.all(const Radius.circular(0.0)),
                        ),
                        child: buttonSqueezeanimation.value > 75.0
                            ? new Text(
                          "Sign In",
                          style: new TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 0.3,
                          ),
                        )
                            : buttomZoomOut.value < 300.0
                            ? new CircularProgressIndicator(
                          value: null,
                          strokeWidth: 1.0,
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              Colors.white),
                        )
                            : null)
                        : new Container(
                      width: buttomZoomOut.value,
                      height: buttomZoomOut.value,
                      decoration: new BoxDecoration(
                        shape: buttomZoomOut.value < 500
                            ? BoxShape.circle
                            : BoxShape.rectangle,
                        color: const Color.fromRGBO(247, 64, 106, 1.0),
                      ),
                    ),
                  )
              )
            ],
          ),
        );
      }
    );
  }
}

