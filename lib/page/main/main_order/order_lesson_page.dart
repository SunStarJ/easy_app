import 'package:easy_app/base_file.dart';
import 'package:easy_app/color_util.dart';
import 'package:easy_app/native/location_util.dart';
import 'package:easy_app/page/main/main_order/order_child_page.dart';
import 'package:easy_app/page/main/main_order/order_lesson_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shimmer/shimmer.dart';

import '../../../theme.dart';

class OrderLessonPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _OrderLessonPageSate();
  }
}

class _OrderLessonPageSate extends BaseState<OrderLessonPage> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  OrderLessonBloc _bloc;
  PageController _pageController ;
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  String initAppName() => "";

  @override
  bool showAppBar() => false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = OrderLessonBloc();
    _bloc.initData();
    _bloc.createWeekName();
    _pageController = PageController(initialPage: _bloc.curIndex);
  }

  @override
  Widget initChild() {
    return Scaffold(
      key: scaffoldKey,
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.blueAccent,
            child: Row(
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "课程筛选",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  onTap: () {
                    scaffoldKey.currentState.openDrawer();
                  },
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: createGrid(),
            decoration: BoxDecoration(color: ColorUtil.bodyColor, boxShadow: [
              BoxShadow(
                  color: Colors.blue.withAlpha(50),
                  offset: Offset(1, 1),
                  spreadRadius: 1)
            ]),
          ),
          Expanded(child:  StreamBuilder(initialData: _bloc.curIndex,stream: _bloc.indexStream,builder: (ctx,short)=>PageView.builder(
            itemBuilder: (ctx, index) => ChildPage(index),
            itemCount: 7,
            controller: _pageController,
            onPageChanged: (index) {
              _bloc.changeWeekData(index);
            },
          )),flex: 1,)
//              Container(child:AndroidView(viewType: LocationUtil.MapName) ,height: 200,width: 200,color: Colors.black87,)
        ],
      ),
      drawer: Drawer(
        child: LessonDrawer(_bloc),
      ),
    );
  }

  StreamBuilder<List<WeekData>> createGrid() {
    return StreamBuilder<List<WeekData>>(
        initialData: _bloc.weekDayData,
        stream: _bloc.weekStream,
        builder: (ctx, short) => GridView.builder(
            itemCount: short.data.length,
            shrinkWrap: true,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
            itemBuilder: (ctx, index) => Center(
                  child: GestureDetector(
                    child: AnimatedContainer(
                      curve: Curves.bounceOut,
                      height: short.data[index].isSelect ? 45 : 30,
                      width: short.data[index].isSelect ? 45 : 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: short.data[index].isSelect
                                  ? Colors.blue
                                  : Colors.transparent,
                              width: 2),
                          borderRadius: BorderRadius.circular(100),
                          color: short.data[index].isSelect
                              ? Colors.white
                              : Colors.grey[300]),
                      duration: Duration(milliseconds: 300),
                      child: Opacity(
                        opacity: 1,
                        child: Text(
                          short.data[index].isSelect
                              ? (index == 0
                                  ? "${short.data[index].dateName}\n今天"
                                  : index == 1
                                      ? "${short.data[index].dateName}\n明天"
                                      : "${short.data[index].dateName}\n周${short.data[index].weekName}")
                              : short.data[index].weekName,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: short.data[index].isSelect ? 12 : 14),
                        ),
                      ),
                    ),
                    onTap: () {
                      _pageController.jumpToPage(index);
                      _bloc.changeWeekData(index);
                    },
                  ),
                )));
  }
}

class LessonDrawer extends StatelessWidget {
  OrderLessonBloc _bloc;

  LessonDrawer(this._bloc);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                StreamBuilder<List<SelectData>>(
                  initialData: _bloc.timeSelectData,
                  stream: _bloc.timeSelectDataStream,
                  builder: (ctx, short) {
                    int totalNum = initTotalNum(short);
                    List<Widget> widgetList = initWidgetList(
                        short, _bloc.timeAllSelect, _bloc.timeAllSelectStream,
                        type: 0, f: () {
                      _bloc.selectTimeAll();
                    });
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        createTitle(
                          context,
                          "时间",
                          totalNum,
                        ),
                        Wrap(
                            children: widgetList,
                            alignment: WrapAlignment.start)
                      ],
                    );
                  },
                ),
                StreamBuilder<List<SelectData>>(
                  initialData: _bloc.typeSelectData,
                  stream: _bloc.typeSelectDataStream,
                  builder: (ctx, short) {
                    int totalNum = initTotalNum(short);
                    List<Widget> widgetList = initWidgetList(
                        short, _bloc.typeAllSelect, _bloc.typeAllSelectStream,
                        type: 1, f: () {
                      _bloc.selectTypeAll();
                    });
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        createTitle(
                          context,
                          "课程类型",
                          totalNum,
                        ),
                        Wrap(
                          children: widgetList,
                          alignment: WrapAlignment.start,
                        )
                      ],
                    );
                  },
                ),
                StreamBuilder<List<SelectData>>(
                  initialData: _bloc.calSelectData,
                  stream: _bloc.calSelectDataStream,
                  builder: (ctx, short) {
                    int totalNum = initTotalNum(short);
                    List<Widget> widgetList = initWidgetList(
                        short, _bloc.calAllSelect, _bloc.calAllSelectDataStream,
                        type: 2, f: () {
                      _bloc.selectCalAll();
                    });
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        createTitle(
                          context,
                          "卡路里",
                          totalNum,
                        ),
                        Wrap(
                            children: widgetList,
                            alignment: WrapAlignment.start)
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          flex: 1,
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              Expanded(
                child: MaterialButton(
                    onPressed: () {},
                    elevation: 0,
                    child: Text("重置"),
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Theme.of(context).dividerColor, width: 1),
                        borderRadius: BorderRadius.circular(3))),
                flex: 1,
              ),
              Container(
                width: 10,
              ),
              Expanded(
                child: MaterialButton(
                    onPressed: () {},
                    elevation: 0,
                    child: Text(
                      "查看课程",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Theme.of(context).dividerColor, width: 1),
                        borderRadius: BorderRadius.circular(3))),
                flex: 1,
              )
            ],
          ),
        )
      ],
    );
  }

  ///计算选中项目数量
  int initTotalNum(AsyncSnapshot<List<SelectData>> short) {
    int totalNum = 0;
    short.data.forEach((data) {
      if (data.isSelect) {
        totalNum += 1;
      }
    });
    return totalNum;
  }

  ///绘制可选择数据
  List<Widget> initWidgetList(
      AsyncSnapshot<List<SelectData>> short, data, stream,
      {int type = 0, Function f}) {
    List<Widget> widgetList = List();
    widgetList.add(StreamBuilder<SelectData>(
      // 添加全选
      builder: (ctx, short) => createSelectData(-1, short.data, f: f),
      initialData: data,
      stream: stream,
    ));
    short.data.forEach((data) {
      widgetList.add(createSelectData(type, data));
    });
    return widgetList;
  }

  ///绘制选择项目标题
  createTitle(BuildContext c, String s, int i) => Container(
        child: Row(
          children: <Widget>[
            Text(
              s,
              style: Theme.of(c).textTheme.subtitle,
            ),
            Text(
              "已选$i项",
              style: TextStyle(fontSize: 10, color: Colors.grey),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
        padding: EdgeInsets.all(10),
      );

  ///创建可点击按钮
  createSelectData(int type, SelectData data, {Function f}) => GestureDetector(
        onTap: f != null
            ? f
            : () {
                if (type == 0) {
                  _bloc.changeTimeSelectData(data.name);
                } else if (type == 1) {
                  _bloc.changeType(data.name);
                } else {
                  _bloc.changeCal(data.name);
                }
              },
        child: AnimatedContainer(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(
            data.name,
            style: TextStyle(color: Colors.white),
          ),
          decoration: BoxDecoration(
              color: data.isSelect ? Colors.blueAccent : Colors.black26,
              borderRadius: BorderRadius.circular(3)),
          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 20),
          duration: Duration(milliseconds: 300),
        ),
      );
}
