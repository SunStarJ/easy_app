import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class BaseStatelessPage extends StatelessWidget {
  BuildContext basePageContext;

  ///自定义appbar
  AppBar initAppBar() => null;

  ///添加标题menu
  List<Widget> initActions() {
    return <Widget>[];
  }

  ///定义是否显示标题栏
  bool showAppBar() => true;

  ///定义titleBarName
  String initAppName();

  ///必须重写且返回不能为空
  Widget initChild();

  @override
  Widget build(BuildContext context) {
    basePageContext = context;
    return WillPopScope(child: Scaffold(
      appBar: !showAppBar()
          ? null
          : initAppBar() == null
          ? AppBar(
        centerTitle: true,
        title: Text(initAppName()),
        actions: initActions(),
      )
          : initAppBar(),
      body: initChild(),
    ), onWillPop: (){
      onDestroy();
      return Future.value(true);
    })  ;
  }

  ///打开页面
  void startPage(Widget page) {
    Navigation.startPage(basePageContext, page);
  }

  ///替换页面
  void replacePage(Widget page) {
    Navigation.replacePage(basePageContext, page);
  }

  ///删除所有页面并跳转
  void goPageAndFinishAll(Widget page) {
    Navigation.goAndFinishAll(basePageContext, page);
  }

  void onDestroy() {
    print("返回调用");
  }
}

abstract class BaseState<T extends StatefulWidget> extends State<T>  with  AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => false;

  BuildContext basePageContext;

  ///自定义appbar
  AppBar initAppBar() => null;

  ///添加标题menu
  List<Widget> initActions() {
    return <Widget>[];
  }

  ///定义是否显示标题栏
  bool showAppBar() => true;

  ///定义titleBarName
  String initAppName();

  ///必须重写且返回不能为空
  Widget initChild();

  @override
  Widget build(BuildContext context) {
    basePageContext = context;
    return Scaffold(
      appBar: !showAppBar()
          ? null
          : initAppBar() == null
          ? AppBar(
        centerTitle: true,
        title: Text(initAppName()),
        actions: initActions(),
      )
          : initAppBar(),
      body: initChild(),
    );
  }

  ///打开页面
  void startPage(Widget page) {
    Navigation.startPage(basePageContext, page);
  }

  ///替换页面
  void replacePage(Widget page) {
    Navigation.replacePage(basePageContext, page);
  }

  ///删除所有页面并跳转
  void goPageAndFinishAll(Widget page) {
    Navigation.goAndFinishAll(basePageContext, page);
  }
}

class Navigation {
  //跳转页面
  static void startPage(BuildContext mContext, Widget page) {
    Navigator.push(mContext, _createRoute(page));
  }

  //删除所有跳转到该页面
  static void goAndFinishAll(BuildContext mContext, Widget page) {
    Navigator.pushAndRemoveUntil(
        mContext, _createRoute(page), (r) => r == null);
  }

  //替换当前页面
  static void replacePage(BuildContext mContext, Widget page) {
    Navigator.removeRoute(mContext, _createRoute(page));
  }

  //跳转目标页路由创建
  static CupertinoPageRoute _createRoute(Widget page) =>
      CupertinoPageRoute(builder: (context) => page);
}