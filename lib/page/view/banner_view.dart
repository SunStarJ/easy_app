import 'dart:async';

import 'package:easy_app/page/view/banner_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BannerView extends StatelessWidget {
  int curIndex = 1;
  List<String> _images;
  List<String> _BannerImageList;
  double viewHeight;
  ValueSetter<int> onTap;
  Timer _timer;
  BannerBloc _bloc = BannerBloc();

  BannerView(this._images, {this.viewHeight = 200, this.onTap});

  PageController _controller;

  @override
  Widget build(BuildContext context) {
    initTimer();
    initControl();
    _BannerImageList = List();
    _BannerImageList.add(_images[_images.length - 1]);
    _BannerImageList.addAll(_images);
    _BannerImageList.add(_images[0]);
    return NotificationListener(
        onNotification: (ScrollNotification note) {
          if (note.depth == 0 &&
              note is ScrollStartNotification) {
            if (note.dragDetails != null) {
              _timer.cancel();
            }
          } else if (note is ScrollEndNotification) {
            _timer.cancel();
            initTimer();
          }
          curIndex = _controller.page.toInt();
          _bloc.changeDotIndex(curIndex);
          return false;
        },
        child: Stack(
          children: <Widget>[
            Container(
              height: viewHeight,
              child: ClipRRect(
                child: _createPager(),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Positioned(
              child: StreamBuilder<int>(
                builder: (ctx, short) => _indicator(short.data),
                initialData: _bloc.dotIndex,
                stream: _bloc.dotIndexStream,
              ),
              bottom: 0,
              left: 0,
              right: 0,
            )
          ],
        ));
  }

  PageView _createPager() {
    return PageView.builder(
      onPageChanged: (index) {
        if (index == _BannerImageList.length - 1) {
          new Future.delayed(new Duration(milliseconds: 200)).then((lwh) {
            _controller.jumpToPage(1);
          });
        } else if (index == 0) {
          new Future.delayed(new Duration(milliseconds: 200)).then((lwh) {
            _controller.jumpToPage(_BannerImageList.length - 2);
          });
        }
      },
      physics: BouncingScrollPhysics(),
      controller: _controller,
      itemBuilder: (ctx, index) => GestureDetector(
        child: Container(
          child: ConstrainedBox(
            constraints: BoxConstraints.expand(),
            child: Image.network(
              _BannerImageList[index],
              fit: BoxFit.cover,
            ),
          ),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.blue.withAlpha(50),
                  offset: Offset(1, 1),
                  spreadRadius: 1)
            ],
          ),
          margin: EdgeInsets.all(0),
        ),
        onTap: () {
          onTap(index);
        },
      ),
    );
  }

  Widget _indicator(int index) {
    List<Widget> radios = new List();
    for (int i = 1; i < _BannerImageList.length - 1; i++) {
      if (index == 0) {
        index = _BannerImageList.length - 2;
      } else if (index == _BannerImageList.length - 1) {
        index = 0;
      }
      IconData iconData = index == i
          ? Icons.radio_button_checked
          : Icons.radio_button_unchecked;
      Icon icon = new Icon(
        iconData,
        color: Colors.grey[100],
        size: 10.0,
      );
      radios.add(Container(
        child: icon,
        margin: EdgeInsets.symmetric(horizontal: 5),
      ));
    }
    return new Container(
      alignment: Alignment.bottomCenter,
      margin: const EdgeInsets.only(bottom: 10.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: radios,
        mainAxisSize: MainAxisSize.max,
      ),
    );
  }

  void initTimer() {
    _timer = Timer.periodic(Duration(seconds: 2), (t) {
      if (curIndex == _BannerImageList.length - 1) {
        curIndex = 1;
        _controller.jumpToPage(curIndex);
      } else if (curIndex == 0) {
        curIndex = _BannerImageList.length - 1;
        _controller.jumpToPage(curIndex);
      } else {
        _controller.animateToPage(curIndex + 1,
            duration: Duration(milliseconds: 300), curve: Curves.linear);
      }
    });
  }

  void initControl() {
    _controller = PageController(
      initialPage: curIndex,
    );
  }
}
