import 'package:easy_app/base_file.dart';
import 'package:easy_app/page/lesson_info/lesson_info_page.dart';
import 'package:easy_app/page/main/main_order/child_bloc.dart';
import 'package:easy_app/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/bezier_bounce_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:shimmer/shimmer.dart';

import '../../../color_util.dart';

class ChildPage extends StatefulWidget {
  int index;

  ChildPage(this.index);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ChildState();
  }
}

class _ChildState extends BaseState<ChildPage> {
  ChildBloc _bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = ChildBloc();
    _bloc.initListData();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  String initAppName() {
    // TODO: implement initAppName
    return "";
  }

  @override
  bool showAppBar() => false;

  @override
  Widget initChild() {
    // TODO: implement initChild
    return StreamBuilder<List<String>>(
        initialData: _bloc.data,
        stream: _bloc.dataStream,
        builder: (ctx, short) => Stack(
              children: <Widget>[
                short.data.length == 0
                    ? Center(child: Util.createBgShimmer())
                    : EasyRefresh(
                        child: ListView.builder(
                          itemBuilder: (ctx, index) => GestureDetector(
                            child: buildItem(),
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              startPage(LessonInfoPage());
                            },
                          ),
                          itemCount: short.data.length,
                        ),
                        header: MaterialHeader(),
                        footer: BezierBounceFooter(),
                        onLoad: () async {},
                        onRefresh: () async {},
                      )
              ],
            ));
  }

  Container buildItem() {
    return Container(
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  "瑜伽",
                  style: Theme.of(context)
                      .textTheme
                      .body1
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Row(
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                          style: Theme.of(context)
                              .textTheme
                              .body1
                              .copyWith(fontSize: 10),
                          text: "20Kcal",
                          children: [
                            TextSpan(
                                text: "　塑形·有氧",
                                style: TextStyle(color: Colors.grey))
                          ]),
                    )
                  ],
                ),
                Text(
                  "11：15-12：00",
                  style:
                      Theme.of(context).textTheme.body1.copyWith(fontSize: 12),
                ),
                Text(
                  "￥30",
                  style: Theme.of(context)
                      .textTheme
                      .body1
                      .copyWith(fontSize: 16, color: Colors.orange),
                )
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
}
