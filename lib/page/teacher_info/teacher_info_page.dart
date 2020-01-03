import 'package:easy_app/base_file.dart';
import 'package:easy_app/color_util.dart';
import 'package:easy_app/page/live_page/live_page.dart';
import 'package:easy_app/page/main/main_order/order_lesson_bloc.dart';
import 'package:easy_app/page/main/main_order/teacher_bloc.dart';
import 'package:easy_app/page/teacher_info/teacher_info_bloc.dart';
import 'package:easy_app/util.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TeacherInfoPage extends BaseStatelessPage {
  TeacherInfoBloc _bloc;

  TeacherInfoPage() {
    _bloc = TeacherInfoBloc();
    _bloc.createWeekName();
    _bloc.createTimeData();
  }

  @override
  String initAppName() => "教练详情";

  @override
  Widget initChild() {
    // TODO: implement initChild
    return Column(
      children: <Widget>[
        Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: <Widget>[
                            Container(
                              height: 80,
                              width: 80,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                color: Colors.pinkAccent,
                              ),
                              padding: EdgeInsets.all(2),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  "http://b-ssl.duitang.com/uploads/item/201410/09/20141009224754_AswrQ.jpeg",
                                ),
                              ),
                              height: 75,
                              width: 75,
                            ),
                            Positioned(
                                bottom: 0,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 2),
                                  decoration: BoxDecoration(
                                      color: Colors.pinkAccent,
                                      border: Border.all(
                                          color: Colors.white, width: 2),
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        height: 16,
                                        width: 16,
                                        child: FlareActor(
                                          "assets/playing.flr",
                                          alignment: Alignment.center,
                                          fit: BoxFit.contain,
                                          animation: 'playing',
                                        ),
                                      ),
                                      Text(
                                        "直播中",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 10),
                                      )
                                    ],
                                  ),
                                ))
                          ],
                        ),
                        onTap: () {
                          startPage(LivePage());
                        },
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          height: 80,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    "孙老师",
                                    style: Theme.of(basePageContext)
                                        .textTheme
                                        .subtitle
                                        .copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    width: 10,
                                  ),
                                  SvgPicture.asset(
                                    "assets/woman.svg",
                                    color: Colors.pinkAccent,
                                    height: 14,
                                    width: 14,
                                  )
                                ],
                              ),
                              Container(
                                height: 10,
                              ),
                              Text(
                                "教学次数：0次",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                              )
                            ],
                          ),
                        ),
                        flex: 1,
                      ),
                      GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  bottomLeft: Radius.circular(15))),
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          child: Row(
                            children: <Widget>[
                              Container(
                                child: Icon(
                                  Icons.call,
                                  color: Colors.white,
                                  size: 12,
                                ),
                                margin: EdgeInsets.only(right: 5),
                              ),
                              Text(
                                "呼叫教练",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              )
                            ],
                          ),
                        ),
                        onTap: () {},
                      )
                    ],
                  ),
                  padding: EdgeInsets.only(top: 10, left: 10),
                  color: ColorUtil.bodyColor,
                ),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "改变，从现在开始！",
                        style: Theme.of(basePageContext)
                            .textTheme
                            .body1
                            .copyWith(fontSize: 10),
                      )
                    ],
                  ),
                  color: ColorUtil.bodyColor,
                ),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                          "选择上课时间",
                          style: Theme.of(basePageContext)
                              .textTheme
                              .body1
                              .copyWith(
                                  fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                        decoration: BoxDecoration(
                            border: Border(
                                left:
                                    BorderSide(color: Colors.blue, width: 4))),
                      )
                    ],
                  ),
                  color: ColorUtil.bodyColor,
                ),
                Container(
                  color: ColorUtil.bodyColor,
                  child: Container(
                      margin: EdgeInsets.only(bottom: 6),
                      child: createGrid(),
                      decoration: BoxDecoration(
                        color: ColorUtil.bodyColor,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withAlpha(50),
                              offset: Offset(0, 1),
                              spreadRadius: 1,
                              blurRadius: 5),
                          BoxShadow(
                              color: Colors.grey.withAlpha(50),
                              offset: Offset(0, -1),
                              spreadRadius: 1,
                              blurRadius: 5)
                        ],
                      )),
                ),
                Container(
                  color: ColorUtil.bodyColor,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10)
                      .copyWith(top: 4),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "课时60分钟左右，预约后记得提前十分钟来热身哦~",
                        style: Theme.of(basePageContext)
                            .textTheme
                            .body1
                            .copyWith(fontSize: 10),
                      )
                    ],
                  ),
                ),
                Container(
                  child: createGride(),
                  color: ColorUtil.bodyColor,
                )
              ],
            ),
            flex: 1),
        GestureDetector(
          child: Container(
            color: Theme.of(basePageContext).accentColor,
            child: Center(
              child: Text(
                "立即约课",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            padding: EdgeInsets.all(10),
          ),
        )
      ],
    );
  }

  ///创建网格布局
  StreamBuilder<List<SelectData>> createGride() {
    return StreamBuilder<List<SelectData>>(
      builder: (ctx, short) => GridView.builder(
          padding: EdgeInsets.all(5),
          shrinkWrap: true,
          itemCount: short.data.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              childAspectRatio: 2.5,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5),
          itemBuilder: (ctx, index) => GestureDetector(
                onTap: () {
                  _bloc.changeTimeSelect(index);
                },
                child: AnimatedContainer(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 3),
                  child: Text(
                    short.data[index].name,
                    style: TextStyle(color: Colors.white),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: short.data[index].isSelect
                          ? Colors.blue
                          : Colors.grey[500]),
                  duration: Duration(milliseconds: 300),
                ),
                behavior: HitTestBehavior.translucent,
              )),
      initialData: _bloc.timeSelectData,
      stream: _bloc.timeStream,
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
                      _bloc.changeWeekData(index);
                    },
                  ),
                )));
  }
}
