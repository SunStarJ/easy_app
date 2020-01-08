import 'package:easy_app/base_file.dart';
import 'package:easy_app/static_util.dart';
import 'package:easy_app/page/good_list/goods_list_bloc.dart';
import 'package:easy_app/page/main/main_order/order_lesson_bloc.dart';
import 'package:easy_app/page/order_check/order_check_page.dart';
import 'package:easy_app/view/link_foot.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class GoodListPage extends BaseStatelessPage {
  GoodsListBloc _bloc;
  ScrollController _scrollControl = ScrollController(keepScrollOffset: false);
  int curPage = 3;
  PageController _pageController;

  GoodListPage() {
    _bloc = GoodsListBloc();
    Future.delayed(Duration(seconds: 2)).whenComplete(() {
      _bloc.addList();
    });
    _pageController = PageController(initialPage: curPage);
  }

  @override
  String initAppName() => "水吧消费";

  @override
  Widget initChild() {
    // TODO: implement initChild
    return WillPopScope(
        child: buildBody(),
        onWillPop: () {
          if (_bloc.showCart == true) {
            _bloc.changeShowCart();
            return Future.value(false);
          } else {
            return Future.value(true);
          }
        });
  }

  Stack buildBody() {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              color: ColorUtil.bodyColor,
              child: Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(3)),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "拼团秒杀休闲区",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        Text(
                          "欢迎大家来测试拼团秒杀水吧",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 2),
                          child: Text(
                            "满5减4",
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white.withAlpha(50),
                              borderRadius: BorderRadius.circular(3),
                              border:
                                  Border.all(color: Colors.white, width: 1)),
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                        )
                      ],
                    )
                  ],
                ),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    gradient: LinearGradient(
                        colors: [Colors.blueAccent, Colors.lightBlueAccent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight)),
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(bottom: 60),
                    width: 80,
                    child: StreamBuilder<List<GoodsListData>>(
                        stream: _bloc.typeListStream,
                        initialData: _bloc.typeList,
                        builder: (ctx, short) => ListView.builder(
                            shrinkWrap: true,
                            itemCount: short.data.length,
                            itemBuilder: (ctx, index) => GestureDetector(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: short.data[index].isSelect
                                            ? (ColorUtil.isDark
                                                ? Colors.black
                                                : Colors.white)
                                            : Colors.transparent,
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Theme.of(basePageContext)
                                                    .dividerColor,
                                                width: 1))),
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    alignment: Alignment.center,
                                    child: Text(short.data[index].name),
                                  ),
                                  onTap: () {
                                    _pageController.jumpToPage(index);
                                  },
                                ))),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: StreamBuilder<List<GoodsListData>>(
                              stream: _bloc.typeListStream,
                              initialData: _bloc.typeList,
                              builder: (ctx, short) => Container(
                                    child: PageView(
                                      controller: _pageController,
                                      scrollDirection: Axis.vertical,
                                      onPageChanged: (index) {
                                        curPage = index;
                                        _bloc.changeIndex(index);
                                      },
                                      children: short.data
                                          .map((data) => createListView(data))
                                          .toList(),
                                    ),
                                    padding: EdgeInsets.only(bottom: 40),
                                  )),
                          flex: 1,
                        ),
                      ],
                    ),
                    flex: 1,
                  )
                ],
              ),
              flex: 1,
            ),
          ],
        ),
        StreamBuilder<bool>(
            stream: _bloc.showCartStream,
            initialData: _bloc.showCart,
            builder: (ctx, short) => !short.data
                ? Container(
                    height: 0,
                  )
                : Positioned(
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      child: Container(
                        color: Colors.black26,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        child: Text("已选商品（共1件商品）"),
                                        margin: EdgeInsets.only(left: 10),
                                      ),
                                      GestureDetector(
                                        behavior: HitTestBehavior.translucent,
                                        child: Container(
                                          child: Row(
                                            children: <Widget>[
                                              Icon(
                                                Icons.delete_forever,
                                                color: Colors.grey,
                                                size: 12,
                                              ),
                                              Text(
                                                "删除",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12),
                                              )
                                            ],
                                          ),
                                          padding: EdgeInsets.all(15),
                                        ),
                                      )
                                    ],
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                  ),
                                  Divider(
                                    height: 1,
                                  ),
                                  StreamBuilder<bool>(
                                    builder: (ctx, short) => AnimatedContainer(
                                      duration: Duration(milliseconds: 200),
                                      height: short.data ? null : 0,
                                      constraints:
                                          BoxConstraints(maxHeight: 300),
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemBuilder: (ctx, index) => createItem(
                                            GoodsListData("测试")
                                              ..numList = [
                                                1,
                                                1,
                                                1,
                                                1,
                                                1,
                                                1,
                                                1,
                                                1,
                                                1,
                                                1,
                                                1,
                                                1,
                                                1,
                                                1,
                                                1,
                                                1,
                                                1,
                                                1,
                                                1,
                                                1,
                                                1,
                                                1,
                                                1,
                                                1
                                              ],
                                            index,
                                            isCart: true),
                                        itemCount: 10,
                                      ),
                                    ),
                                    initialData: _bloc.showCartAnim,
                                    stream: _bloc.showCartAnimStream,
                                  )
                                ],
                              ),
                              padding: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  color: ColorUtil.bodyColor,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5))),
                            )
                          ],
                          mainAxisSize: MainAxisSize.min,
                        ),
                      ),
                      onTap: () {
                        _bloc.changeShowCart();
                      },
                    ),
                    bottom: 40,
                    top: 0,
                    left: 0,
                    right: 0,
                  )),
        createBottomControl()
      ],
    );
  }

  Positioned createBottomControl() {
    return Positioned(
      child: Container(
        height: 60,
        child: Stack(
          alignment: Alignment.topLeft,
          children: <Widget>[
            Positioned(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          left: kFloatingActionButtonMargin * 2 + 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          RichText(
                              text: TextSpan(
                                  text: "￥4",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                  children: [
                                TextSpan(
                                    text: "￥10",
                                    style: TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        fontSize: 12,
                                        color: Colors.grey))
                              ])),
                          Text(
                            "已减1.00元",
                            style: TextStyle(color: Colors.grey, fontSize: 10),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 0),
                        height: 40,
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        color: Colors.blueAccent,
                        child: Text(
                          "去结算",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                      onTap: () {
                        startPage(OrderCheck());
                      },
                    )
                  ],
                ),
                color: Colors.black54,
                width: double.infinity,
              ),
              left: 0,
              bottom: 0,
              right: 0,
            ),
            Stack(
              children: <Widget>[
                Container(
                  child: FloatingActionButton(
                    child: Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _bloc.changeShowCart();
                    },
                    backgroundColor: Colors.blueAccent,
                    mini: true,
                  ),
                  margin: EdgeInsets.only(left: 10),
                ),
                Positioned(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 3),
                    child: Text(
                      "1",
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(100)),
                  ),
                  right: 0,
                  top: 5,
                )
              ],
            ),
          ],
        ),
      ),
      bottom: 0,
      left: 0,
      right: 0,
    );
  }

  Widget createListView(GoodsListData data) {
    LinkHeaderNotifier _linkHeaderNotifier = LinkHeaderNotifier();
    LinkFooterNotifier _linkFootNotifier = LinkFooterNotifier();
    _linkFootNotifier.pulledExtent = 0.0;
    return Column(
      children: <Widget>[
        HeaderView(_linkHeaderNotifier),
        Expanded(
          child: EasyRefresh(
            child: ListView.builder(
                physics: ScrollPhysics(),
                itemBuilder: (ctx, index) => createItem(data, index),
                itemCount: data.numList.length),
            onRefresh: () async {
              if (curPage > 0) {
                curPage -= 1;
                Future.delayed(Duration(milliseconds: 300)).whenComplete(() {
                  _pageController.jumpToPage(curPage);
                });
              }
            },
            onLoad: () async {
              curPage += 1;
              Future.delayed(Duration(milliseconds: 300)).whenComplete(() {
                _pageController.jumpToPage(curPage);
              });
            },
            footer: CustomFooter(),
            header: LinkHeader(_linkHeaderNotifier,
                extent: 70.0,
                triggerDistance: 70.0,
                completeDuration: Duration(milliseconds: 300)),
          ),
          flex: 1,
        ),
//        FootView(_linkFootNotifier)
      ],
    );
  }

  ///创建列表
  Container createItem(GoodsListData data, int index, {bool isCart = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
          color: ColorUtil.bodyColor,
          border: Border(
              bottom: BorderSide(
                  color: Theme.of(basePageContext).dividerColor, width: 1))),
      child: Row(
        children: <Widget>[
          ClipRRect(
            child: Container(
              height: isCart ? 40 : 70,
              width: isCart ? 40 : 70,
              child: ConstrainedBox(
                constraints: BoxConstraints.expand(),
                child: Image.network(
                  "https://www.uyan.org/upfile/201904/2019040602778004.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          Container(
            width: 10,
          ),
          Expanded(
            child: Container(
              height: isCart ? 40 : 70,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("${data.name}-脉动"),
                  isCart
                      ? Container(
                          height: 0,
                        )
                      : Text(
                          "状态不在，随时脉动回来",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          RichText(
                              text: TextSpan(
                                  text: "￥1",
                                  style: TextStyle(
                                    color: Colors.orange,
                                  ),
                                  children: [
                                TextSpan(
                                  text: "￥2",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                      decoration: TextDecoration.lineThrough),
                                )
                              ])),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              data.numList[index] == 0
                                  ? Container(
                                      height: 0,
                                    )
                                  : GestureDetector(
                                      child: AnimatedContainer(
                                        duration: Duration(milliseconds: 300),
                                        child: createIcon(Icons.remove),
                                      ),
                                      onTap: () {
                                        _bloc.changeNum(data, index,
                                            isAdd: false);
                                      },
                                    ),
                              data.numList[index] == 0
                                  ? Container(
                                      height: 0,
                                    )
                                  : AnimatedContainer(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      duration: Duration(milliseconds: 300),
                                      child: Text("${data.numList[index]}"),
                                    ),
                              GestureDetector(
                                child: createIcon(Icons.add),
                                onTap: () {
                                  _bloc.changeNum(data, index);
                                },
                                behavior: HitTestBehavior.translucent,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            flex: 1,
          )
        ],
      ),
    );
  }

  Container createIcon(IconData iconData) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Colors.blueAccent,
      ),
      child: Icon(
        iconData,
        color: Colors.white,
        size: 12,
      ),
      padding: EdgeInsets.all(3),
    );
  }
}

class CustomFooter extends Footer {
  @override
  // TODO: implement enableInfiniteLoad
  bool get enableInfiniteLoad => false;

  @override
  Widget contentBuilder(
      BuildContext context,
      LoadMode loadState,
      double pulledExtent,
      double loadTriggerPullDistance,
      double loadIndicatorExtent,
      AxisDirection axisDirection,
      bool float,
      Duration completeDuration,
      bool enableInfiniteLoad,
      bool success,
      bool noMore) {
    // TODO: implement contentBuilder
    return Container(
      height: pulledExtent,
      child: Text(
        "上滑继续浏览下一分类",
        style: TextStyle(color: Colors.grey, fontSize: 12),
      ),
      alignment: Alignment.center,
    );
  }
}

class HeaderView extends StatefulWidget {
  LinkHeaderNotifier _linkHeaderNotifier;

  HeaderView(this._linkHeaderNotifier);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HeaderViewState();
  }
}

class _HeaderViewState extends State<HeaderView> {
  double get _pulledExtent => widget._linkHeaderNotifier.pulledExtent;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget._linkHeaderNotifier.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      alignment: Alignment.center,
      child: Text(
        "向下拉继续浏览上一分类",
        style: TextStyle(color: Colors.grey, fontSize: 12),
      ),
      height: _pulledExtent,
    );
  }
}
