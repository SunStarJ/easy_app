import 'package:easy_app/base_file.dart';
import 'package:easy_app/static_util.dart';
import 'package:easy_app/page/main/main_home/tab_indicator.dart';
import 'package:easy_app/page/view/banner_view.dart';
import 'package:easy_app/page/view/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:marquee/marquee.dart';
import 'package:marquee_flutter/marquee_flutter.dart';

import 'child_page.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePageState();
  }
}

class _HomePageState extends BaseState<HomePage>{
  ChildPage _childPage;
  List<String> _bannerData = [
    "http://pic.90sjimg.com/back_origin_pic/05/72/74/2a4e0cc20bb60d11b0c57703113b8691.jpg!/fw/640/quality/90/unsharp/true/compress/true/canvas/640x525a0a0",
    "https://static.iamxk.com/wp-content/uploads/2019/08/0e6039ac-c31d-42ba-aa97-b1ef519460a9.jpg",
    "http://cdn.init123.com:81/image.php?p=HAhEtY28rnZCtIFFH8BPBcStMEwgMKzTnmS7TfU4CwsFGS3AkeIWNW5kkmCfjaQhzGpkyyLRAcSm5b5ywt0dMotQ0w&w=780&h=&tag=GgpAt9rq_aXIdn8QFHdlZUoP3alUnMKaN2X_apGq0"
  ];
  List<String> _tabs = ["团课", "私教"];

  @override
  String initAppName() => "首页";

  @override
  Widget initChild() {
    _childPage = ChildPage();
    return DefaultTabController(
        length: 2,
        child: NestedScrollView(
          body: createBody(),
          headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) => [
            SliverToBoxAdapter(
              child: createHeader(),
            ),
            SliverPersistentHeader(
              delegate: SliverAppBarDelegate(),
              floating: false,
              pinned: true,
            ),
          ],
        ));
  }

  TabBarView createBody() {
    return TabBarView(
      children: [
        _childPage.createBuyCardPage(),
        _childPage.createTeacherPage(basePageContext)
      ],
    );
  }

  Column createHeader() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        createTop(),
        Container(
          child: MarqueeWidget(
            text: "ListView即滚动列表控件，能将子控件组成可滚动的列表。当你需要排列的子控件超出容器大小",
            textStyle: new TextStyle(fontSize: 14.0),
            scrollAxis: Axis.horizontal,
          ),
          height: 30,
          color: Colors.amber,
        ),
        Container(
          height: 150,
          child: ClipRRect(
            child: Swiper(
              pagination: SwiperPagination(alignment: Alignment.bottomCenter,builder: DotSwiperPaginationBuilder(color: Theme.of(basePageContext).scaffoldBackgroundColor,activeColor: Theme.of(basePageContext).accentColor)),
              autoplay: true,
              itemCount: _bannerData.length,
              itemBuilder: (ctx, index) => ConstrainedBox(
                constraints: BoxConstraints.expand(),
                child: Image.network(
                  _bannerData[index],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        ),
      ],
    );
  }


  ///创建顶部样式
  Stack createTop() {
    return Stack(
      children: <Widget>[
        Container(
          height: 100,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.blueAccent, Colors.lightBlueAccent])),
        ),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "营业时间:08:50-20:45\n藁城通用航空机场",
                style: TextStyle(color: Colors.white),
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.location_on,
                    color: Colors.white,
                    size: 14,
                  ),
                  Text(
                    "3.5KM",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    color: Theme.of(basePageContext).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.blue.withAlpha(50),
                          offset: Offset(1, 1),
                          spreadRadius: 1)
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[Text("改变，从现在开始！和小伙伴一起运动吧")],
                    ),
                    Container(
                      height: 20,
                    ),
                    MaterialButton(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      color: Colors.blue,
                      textColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 60),
                      child: Text("我要预约"),
                      onPressed: () {},
                    )
                  ],
                ),
                padding: EdgeInsets.all(10),
              )
            ],
          ),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        ),
        Positioned(
          child: Container(
            child: GestureDetector(
              child: Icon(
                Icons.message,
                color: Colors.white,
              ),
              onTap: () {},
            ),
            padding: EdgeInsets.all(10),
          ),
          right: 0,
          top: 0,
        )
      ],
    );
  }
  ///保存切换后页面状态设置
  @override
  bool get wantKeepAlive => true;
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
        decoration:
            BoxDecoration(color: ColorUtil.bodyColor),
        height: kTextTabBarHeight,
        child: TabBar(
          isScrollable: true,
          tabs: [
            Tab(
              text: "团课预约",
            ),
            Tab(text: "私教体验")
          ],
          unselectedLabelColor: Colors.grey,
          labelColor: Theme.of(context).textTheme.title.color,
          labelStyle: TextStyle(fontSize: 18),
          unselectedLabelStyle: TextStyle(fontSize: 14),
          indicator:
              CustomerUnderlineTabIndicator(borderSide: BorderSide(width: 6)),
        ));
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => kTextTabBarHeight;

  @override
  // TODO: implement minExtent
  double get minExtent => kTextTabBarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return true;
  }
}
