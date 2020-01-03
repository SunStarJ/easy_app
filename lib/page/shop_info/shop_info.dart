import 'dart:collection';

import 'package:easy_app/base_file.dart';
import 'package:easy_app/native/location_util.dart';
import 'package:easy_app/native/map_view.dart';
import 'package:easy_app/page/shop_info/shop_info_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class ShopInfoPage extends BaseStatelessPage {
  ScrollController _nestScrollController;
  ShopInfoBloc _bloc = ShopInfoBloc();
  NativeMapView mapView;
  ShopInfoPage() {
    _nestScrollController = ScrollController()
      ..addListener(() {
        if (_nestScrollController.offset < 125) {
          _bloc.changeHeight(_nestScrollController.offset);
        }
      });
    mapView = NativeMapView();
  }



  List<String> images = [
    "assets/test1.jpg",
    "assets/test2.jpg",
    "assets/test3.jpg"
  ];

  @override
  String initAppName() => "";

  @override
  bool showAppBar() => false;

  @override
  Widget initChild() {
    // TODO: implement initChild
    return NestedScrollView(
        controller: _nestScrollController,
        headerSliverBuilder: (ctx, scroll) => [
              StreamBuilder<double>(
                  initialData: _bloc.scrollOffset,
                  stream: _bloc.heightStream,
                  builder: (ctx, short) => SliverAppBar(
                        elevation: 2,
                        iconTheme:
                            IconThemeData(color: changeTitleColor(short)),
                        expandedHeight: 200,
                        pinned: true,
                        flexibleSpace: FlexibleSpaceBar(
                          title: Text(
                            "石家庄月野兔总店",
                            style: Theme.of(basePageContext)
                                .textTheme
                                .title
                                .copyWith(color: changeTitleColor(short)),
                          ),
                          background: Swiper(
                            itemHeight: 200,
                            itemCount: images.length,
                            autoplay: true,
                            itemBuilder: (ctx, index) => ConstrainedBox(
                              constraints: BoxConstraints.expand(),
                              child: Image.asset(
                                images[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ))
            ],
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              createTextItem("电话：0311-0000000"),
              createTextItem("地址：石家庄市裕华区槐安东路105号怀特舍业广场D座"),
              GestureDetector(behavior: HitTestBehavior.translucent,child:  Container(
                height: 150,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: IgnorePointer(child:mapView) ,
                ),
                margin: EdgeInsets.symmetric(horizontal: 10).copyWith(top: 10),
              ),onTap: (){
                mapView.goToLocation();
              },)
            ],
          ),
        ));
  }

  ///修改标题栏文字和图标颜色
  Color changeTitleColor(AsyncSnapshot<double> short) {
    return Color.lerp(Colors.white,
        Theme.of(basePageContext).textTheme.title.color, short.data / 125);
  }

  createTextItem(String s) => Container(
        child: Text(s),
        padding: EdgeInsets.symmetric(horizontal: 10).copyWith(top: 10),
      );
}
