import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlurView extends StatelessWidget {
  Widget child;
  Color blurColor;
  double height;

  BlurView(this.child, this.blurColor, this.height);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Stack(
        children: <Widget>[
          child,
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: Container(
              height: height,
              color: blurColor.withOpacity(0.1),
            ),
          )
        ],
      ),
      height: height,
    );
  }
}
