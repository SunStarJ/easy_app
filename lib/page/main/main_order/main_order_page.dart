import 'package:easy_app/base_file.dart';
import 'package:easy_app/page/main/main_home/tab_indicator.dart';
import 'package:easy_app/page/main/main_order/order_lesson_page.dart';
import 'package:easy_app/page/main/main_order/teacher_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class MainOrderPage extends BaseStatelessPage {
  @override
  String initAppName() => "约课";

  @override
  bool showAppBar() => false;

  @override
  Widget initChild() {
    // TODO: implement initChild
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: OrderAppBar(createTabBar(),basePageContext),
          body: TabBarView(children: [OrderLessonPage(), TeacherPage()]),
        ));
  }

  ///创建tab
  TabBar createTabBar() {
    return TabBar(
        tabs: [
          Tab(
            text: "团课",
          ),
          Tab(
            text: "私教",
          )
        ],
        unselectedLabelColor: Colors.grey,
        labelColor: Theme.of(basePageContext).textTheme.title.color,
        labelStyle: TextStyle(fontSize: 18),
        unselectedLabelStyle: TextStyle(fontSize: 14),
        indicator:
            CustomerUnderlineTabIndicator(borderSide: BorderSide(width: 6)));
  }
}

class OrderAppBar extends StatelessWidget implements PreferredSizeWidget {
  Widget child;
  BuildContext mContext;

  OrderAppBar(this.child,this.mContext);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: kToolbarHeight+MediaQuery.of(mContext).padding.top,
      child: child,
      decoration: BoxDecoration(color: Theme.of(mContext).appBarTheme.color,boxShadow: [BoxShadow(color: Colors.grey)]),
      padding: EdgeInsets.only(top: MediaQuery.of(mContext).padding.top,bottom: 5),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>
      Size.fromHeight(MediaQuery.of(mContext).padding.top + kToolbarHeight);
}
