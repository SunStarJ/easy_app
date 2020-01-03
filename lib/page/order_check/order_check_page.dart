import 'package:easy_app/base_file.dart';
import 'package:easy_app/color_util.dart';
import 'package:easy_app/page/order_check/order_check_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class OrderCheck extends BaseStatelessPage {
  OrderCheckBloc _bloc;

  OrderCheck() {
    _bloc = OrderCheckBloc();
  }

  @override
  String initAppName() => "确认订单";

  @override
  Widget initChild() {
    // TODO: implement initChild
    return Column(
      children: <Widget>[
        Expanded(
            child: Container(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 5),
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(3)),
                      ),
                      Text("拼团秒杀休闲区")
                    ],
                  ),
                  color: ColorUtil.bodyColor,
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  child: StreamBuilder<int>(
                      initialData: _bloc.listSize,
                      stream: _bloc.listSizeStream,
                      builder: (ctx, short) => ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (ctx, index) => createItem(),
                            itemCount: short.data,
                          )),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  color: ColorUtil.bodyColor,
                  alignment: Alignment.center,
                  child: GestureDetector(
                      onTap: () {
                        _bloc.changeShowMore();
                      },
                      child: Container(
                        child: StreamBuilder<bool>(
                            stream: _bloc.showMoreStream,
                            initialData: _bloc.showMore,
                            builder: (ctx, short) => Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(short.data ? "收起列表" : "展示更多"),
                                    Container(
                                        child: Icon(short.data
                                            ? Icons.keyboard_arrow_up
                                            : Icons.keyboard_arrow_down))
                                  ],
                                )),
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: Theme.of(basePageContext).dividerColor)),
                      )),
                ),
                Container(
                  padding: EdgeInsets.all(10).copyWith(top: 0),
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Theme.of(basePageContext).dividerColor,
                            width: 1)),
                    color: ColorUtil.bodyColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                color: Colors.blueAccent.withAlpha(50),
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                    color: Colors.blueAccent, width: 1)),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 3),
                            child: Text(
                              "满减",
                              style: TextStyle(
                                  color: Colors.blueAccent, fontSize: 12),
                            ),
                          ),
                          Text("店铺活动满5减4")
                        ],
                      ),
                      Text(
                        "-￥4",
                        style: TextStyle(color: Colors.orange, fontSize: 12),
                      )
                    ],
                  ),
                ),
                Container(
                  color: ColorUtil.bodyColor,
                  child: Row(
                    children: <Widget>[
                      Text(
                        "共X件商品",
                        style: TextStyle(color: Colors.grey),
                      ),
                      RichText(
                          text: TextSpan(
                              text: "已减",
                              style: Theme.of(basePageContext)
                                  .textTheme
                                  .body1
                                  .copyWith(fontSize: 10),
                              children: [
                            TextSpan(
                                text: "￥10.11",
                                style: TextStyle(color: Colors.orange)),
                            TextSpan(
                                text: "　合计",
                                style:
                                    Theme.of(basePageContext).textTheme.body1,
                                children: [
                                  TextSpan(
                                      text: "￥10.11",
                                      style: TextStyle(color: Colors.orange))
                                ])
                          ]))
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                  padding: EdgeInsets.all(10),
                )
              ],
            ),
          ),
        ))
      ],
    );
  }

  ///创建列表
  createItem() => Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            Container(
              height: 50,
              width: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: ConstrainedBox(
                  constraints: BoxConstraints.expand(),
                  child: Image.network(
                    "https://www.uyan.org/upfile/201904/2019040602778004.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          ],
        ),
        color: ColorUtil.bodyColor,
        margin: EdgeInsets.only(bottom: 10),
      );
}
