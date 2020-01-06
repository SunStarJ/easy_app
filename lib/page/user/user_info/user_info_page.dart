import 'package:easy_app/base_file.dart';
import 'package:easy_app/static_util.dart';
import 'package:easy_app/util.dart';
import 'package:easy_app/view/customer_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class UserInfoPage extends BaseStatelessPage {
  @override
  String initAppName() => "个人中心";

  @override
  bool showAppBar() => true;

  @override
  AppBar initAppBar() => AppBar(
        title: Text("个人中心"),
        elevation: 0,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.settings), onPressed: () {})
        ],
      );

  @override
  Widget initChild() => Column(
        children: <Widget>[
          createBodyBox(Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("头像"),
                Hero(
                    tag: "info_header",
                    child: GestureDetector(
                      child: Container(
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://pic.feizl.com/upload/allimg/190731/gxtxwuahnllnk3m.jpg"),
                        ),
                        height: 60,
                        width: 60,
                      ),
                    ))
              ],
            ),
            padding: EdgeInsets.symmetric(vertical: 10),
          )),
          createBodyBox(Container(
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                        color: Theme.of(basePageContext).dividerColor))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("昵称"),
                Hero(
                  tag: "nick_name",
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text("小妖怪",
                        style: Theme.of(basePageContext)
                            .textTheme
                            .body2
                            .copyWith(fontSize: 14)),
                  ),
                )
              ],
            ),
          )),
          Container(
            height: 10,
          ),
          createBodyBox(createBody("姓名", "浩")),
          createBodyBox(createBody("手机号", "18633799924")),
          createBodyBox(createBody("性别", "男", isMore: true)),
          createBodyBox(createBody("生日", "请选择您的生日", isMore: true)),
          createBodyBox(createBody("地区", "石家庄", isMore: true)),
          createBodyBox(createBody("感情状况", "保密", isMore: true)),
          Container(height: 10,color: Colors.white,)
        ],
      );

  createBody(String name, String value, {isMore = false}) => Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(name),
            isMore
                ? Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(value),
                        Container(
                          margin: EdgeInsets.only(left: 0),
                          child: Icon(
                            Icons.chevron_right,
                          ),
                        )
                      ],
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10),
                  )
                : Expanded(
                    child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none),
                    textAlign: TextAlign.end,
                    scrollPadding: EdgeInsets.all(10),
                    enabled: false,
                    controller: TextEditingController.fromValue(
                        TextEditingValue(text: value)),
                  ))
          ],
        ),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: Theme.of(basePageContext).dividerColor, width: 1))),
      );

  ///创建布局盒子
  createBodyBox(Widget child) => Container(
        color: ColorUtil.bodyColor,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: child,
      );
}
