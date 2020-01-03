import 'package:easy_app/base_file.dart';
import 'package:easy_app/page/good_list/goods_list_page.dart';
import 'package:easy_app/page/main/main_bloc.dart';
import 'package:easy_app/page/main/main_home/main_home_page.dart';
import 'package:easy_app/page/main/main_order/main_order_page.dart';
import 'package:easy_app/page/main/main_user/main_user_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class MainPage extends BaseStatelessPage {
  List<Widget> pages;
  MainBloc _bloc;


  MainPage(){
    _bloc = MainBloc();
  }

  @override
  String initAppName() => "";

  @override
  bool showAppBar() => false;

  @override
  Widget initChild() {
    pages = [HomePage(), MainOrderPage(), MainUserPage()];
    return Scaffold(
      body: StreamBuilder<int>(
        builder: (ctx, short) => IndexedStack(
          children: pages,
          index: _bloc.curIndex,
        ),
        initialData: _bloc.curIndex,
        stream: _bloc.indexStream,
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        backgroundColor: Theme.of(basePageContext).accentColor,
        onPressed: () {
          startPage(GoodListPage());
        },
        child: Icon(
          Icons.shopping_cart,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: StreamBuilder<int>(
        builder: (ctx, short) => BottomNavigationBar(
          currentIndex: short.data,
          items: _createBottomItem(),
          onTap: (index) {
            _bloc.changeIndex(index);
          },
        ),
        initialData: _bloc.curIndex,
        stream: _bloc.indexStream,
      ),
    );
  }

  _createBottomItem() => [
        BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("首页")),
        BottomNavigationBarItem(
            icon: Icon(Icons.watch_later), title: Text("预约")),
        BottomNavigationBarItem(icon: Icon(Icons.person), title: Text("我的")),
      ];
}
