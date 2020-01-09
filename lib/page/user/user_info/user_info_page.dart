import 'package:easy_app/base_file.dart';
import 'package:easy_app/page/other/header_check_page.dart';
import 'package:easy_app/page/user/user_info/user_info_bloc.dart';
import 'package:easy_app/static_util.dart';
import 'package:easy_app/util.dart';
import 'package:easy_app/view/customer_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';

class UserInfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _UserInfoPageState();
  }
}

class _UserInfoPageState extends BaseState<UserInfoPage> {
  UserInfoBloc _bloc;
  GlobalKey<FormState> _phoneKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = UserInfoBloc();
  }

  @override
  String initAppName() => "个人中心";

  @override
  bool showAppBar() => true;

  @override
  AppBar initAppBar() => AppBar(
        title: Text("个人中心"),
        elevation: 0,
        actions: <Widget>[
          StreamBuilder<bool>(
            builder: (ctx, short) => IconButton(
                icon: Icon(short.data ? Icons.done : Icons.settings),
                onPressed: () {
                  _bloc.changeEdit();
                }),
            stream: _bloc.isEditStream,
            initialData: _bloc.isEdit,
          )
        ],
      );

  @override
  Widget initChild() => Scaffold(key: _scaffoldState,body:SingleChildScrollView(
    child: Column(
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
                    onTap: () {
                      if (!_bloc.isEdit) {
                        startPage(HeaderCheckPage());
                      } else {
                        showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: basePageContext,
                            builder: (ctx) => Container(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  MaterialButton(
                                    onPressed: () {},
                                    child: Center(
                                      child: Text("相册",style: TextStyle(color: Colors.black)),
                                    ),
                                    color: Colors.white,
                                  ),
                                  MaterialButton(
                                    onPressed: () {},
                                    child: Center(
                                      child: Text("拍照",style: TextStyle(color: Colors.black),),
                                    ),
                                    color: Colors.white,
                                  )
                                ],
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 15),
                            ));
                      }
                    },
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
            children: <Widget>[
              Text("昵称"),
              StreamBuilder<bool>(
                stream: _bloc.isEditStream,
                initialData: _bloc.isEdit,
                builder: (ctx, short) => !short.data
                    ? Expanded(
                  child: Hero(
                      tag: "nick_name",
                      child: Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          "小妖怪",
                          style: Theme.of(basePageContext)
                              .textTheme
                              .body1
                              .copyWith(
                              color: short.data
                                  ? null
                                  : Colors.grey,
                              fontSize: 16),
                        ),
                      )),
                  flex: 1,
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
                    style: TextStyle(
                        color:
                        short.data ? null : Colors.grey,
                        fontSize: 16),
                    enabled: short.data,
                    controller: TextEditingController.fromValue(
                        TextEditingValue(text: "小妖怪")),
                  ),
                  flex: 1,
                ),
              )
            ],
          ),
        )),
        Container(
          height: 10,
        ),
        createBodyBox(createBody("姓名", "浩")),
        createBodyBox(createBody("手机号", "18633799924", isMore: true, f: () {
          _scaffoldState.currentState.showBottomSheet(
              (ctx)=>GestureDetector(onTap: (){
                Navigator.pop(context);
              },child:Column(children: <Widget>[ Container(
                padding: EdgeInsets.all(10),
                child: Form(
                  key: _phoneKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Theme.of(basePageContext)
                                        .dividerColor))),
                        child: Row(
                          children: <Widget>[
                            Text("手机号"),
                            Expanded(
                              child: Container(
                                child: TextField(
                                  decoration: InputDecoration(
                                      hintText: "请输入有效手机号",
                                      border: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      focusedErrorBorder:
                                      InputBorder.none),
                                ),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10),
                              ),
                              flex: 1,
                            ),
                            MaterialButton(
                              color: Colors.grey.withAlpha(100),
                              elevation: 0,
                              child: Text("获取验证码"),
                              onPressed: () {},
                            )
                          ],
                        ),
                        padding: EdgeInsets.symmetric(vertical: 5),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Theme.of(basePageContext)
                                        .dividerColor))),
                        child: Row(
                          children: <Widget>[
                            Text("验证码"),
                            Expanded(
                              child: Container(
                                child: TextField(
                                  decoration: InputDecoration(
                                      hintText: "请输入验证码",
                                      border: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      focusedErrorBorder:
                                      InputBorder.none),
                                ),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10),
                              ),
                              flex: 1,
                            ),
                          ],
                        ),
                        padding: EdgeInsets.symmetric(vertical: 5),
                      ),
                      Text(
                        "更换手机后，健身消息将发送至新的手机号，当前手机号：18633799924",
                        style:
                        TextStyle(color: Colors.grey, fontSize: 12),
                      )
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                    color: ColorUtil.bodyColor,
                    borderRadius: BorderRadius.circular(10)),
              )],mainAxisAlignment: MainAxisAlignment.end,) ,behavior: HitTestBehavior.translucent,),backgroundColor: Colors.black12 );
        })),
        createBodyBox(createBody("性别", "男", isMore: true)),
        createBodyBox(createBody("生日", "请选择您的生日", isMore: true)),
        createBodyBox(createBody("地区", "石家庄", isMore: true)),
        createBodyBox(createBody("感情状况", "保密", isMore: true)),
        Container(
          height: 10,
          color: Colors.white,
        )
      ],
      mainAxisSize: MainAxisSize.min,
    ),
  ) ,) ;

  createBody(String name, String value, {isMore = false, Function f}) =>
      StreamBuilder<bool>(
          initialData: _bloc.isEdit,
          stream: _bloc.isEditStream,
          builder: (ctx, short) => Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(name),
                    isMore
                        ? GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: f,
                            child: Container(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    value,
                                    style: TextStyle(
                                        color: short.data
                                            ?  null
                                            : Colors.grey,
                                        fontSize: 16),
                                  ),
                                  Visibility(
                                    child: Container(
                                      margin: EdgeInsets.only(left: 0),
                                      child: Icon(
                                        Icons.chevron_right,
                                        size: 16,
                                      ),
                                    ),
                                    visible: short.data,
                                  )
                                ],
                              ),
                              padding: EdgeInsets.symmetric(vertical: 15),
                            ),
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
                            style: TextStyle(
                                color: short.data ? null : Colors.grey,
                                fontSize: 16),
                            enabled: short.data,
                            controller: TextEditingController.fromValue(
                                TextEditingValue(text: value)),
                          ))
                  ],
                ),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Theme.of(basePageContext).dividerColor,
                            width: 1))),
              ));

  ///创建布局盒子
  createBodyBox(Widget child) => Container(
        color: ColorUtil.bodyColor,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: child,
      );
}
