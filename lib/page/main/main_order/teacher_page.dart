import 'package:easy_app/base_file.dart';
import 'package:easy_app/page/main/main_order/teacher_bloc.dart';
import 'package:easy_app/page/teacher_info/teacher_info_page.dart';
import 'package:easy_app/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/bezier_bounce_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../static_util.dart';

class TeacherPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TeacherState();
  }
}

class TeacherState extends BaseState<TeacherPage> {
  TeacherBloc _bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = TeacherBloc();
    _bloc.initListData();
  }

  @override
  String initAppName() => "";

  @override
  bool get wantKeepAlive => true;

  @override
  bool showAppBar() => false;

  @override
  Widget initChild() {
    // TODO: implement initChild
    return StreamBuilder<List<String>>(
        initialData: _bloc.data,
        stream: _bloc.dataStream,
        builder: (ctx, short) => short.data.length == 0
            ? Center(
                child: Util.createBgShimmer(),
              )
            : EasyRefresh(
                child: ListView.builder(
                  itemBuilder: (ctx, index) => GestureDetector(child:  buildItem(),behavior: HitTestBehavior.translucent,onTap: (){
                    startPage(TeacherInfoPage());
                  },),
                  itemCount: short.data.length,
                ),
                header: MaterialHeader(),
                footer: BezierBounceFooter(),
                onLoad: () async {},
                onRefresh: () async {},
              ));
  }

  buildItem() => Container(
        child: Row(
          children: <Widget>[
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  gradient: LinearGradient(
                      colors: [Colors.purple, Colors.purple[200]],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight)),
              margin: EdgeInsets.only(right: 10),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "孙老师",
                        style: Theme.of(context).textTheme.body1.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Container(width: 10,),
                      SvgPicture.asset(
                        "assets/man.svg",
                        color: Colors.blue,
                        height: 14,
                        width: 14,
                      )
                    ],
                  ),
                  Container(height: 10,),
                  Text(
                    "改变，从现在开始！",
                    style: Theme.of(context)
                        .textTheme
                        .body1
                        .copyWith(fontSize: 12),
                  ),

                ],
              ),
              height: 80,
            )
          ],
        ),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: ColorUtil.bodyColor,
            border: Border(
                bottom: BorderSide(color: Theme.of(context).dividerColor))),
      );
}
