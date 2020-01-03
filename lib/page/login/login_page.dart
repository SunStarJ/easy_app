import 'package:easy_app/base_file.dart';
import 'package:easy_app/color_util.dart';
import 'package:easy_app/native/location_util.dart';
import 'package:easy_app/page/login/login_bloc.dart';
import 'package:easy_app/page/main/main_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:ui' as ui;

class LoginPagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginPage();
  }
}

class _LoginPage extends BaseState<LoginPagePage> {
  LoginBloc _bloc;

  @override
  String initAppName() => "";

  @override
  bool showAppBar() => false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = LoginBloc();
  }

  @override
  Widget initChild() {

    ColorUtil.isDark =
        MediaQuery.platformBrightnessOf(basePageContext) == ui.Brightness.dark;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              child: FlutterLogo(),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(1000)),
            ),
            Container(
              child: Text(
                "AppName",
                style: Theme.of(context).textTheme.subtitle,
              ),
            ),
            Column(
              children: <Widget>[
                StreamBuilder<String>(
                    initialData: _bloc.userNameError,
                    stream: _bloc.errorStringStream,
                    builder: (ctx, short) => createInput("请输入用户名", (s) {
                          _bloc.changeUserName(s);
                        },
                            hintText: "请输入手机号",
                            isPhone: true,
                            errorText: short.data)),
                createInput("请输入密码", (s) {
                  _bloc.changePassword(s);
                }, isPassword: true)
              ],
            ),
            Container(
              height: 20,
            ),
            StreamBuilder<bool>(
                initialData: _bloc.canLogin,
                stream: _bloc.canLoginStream,
                builder: (ctx, short) => MaterialButton(
                      disabledColor: Colors.grey.withAlpha(50),
                      color: Theme.of(context).accentColor,
                      textColor: Colors.white,
                      child: Center(
                        child: Text("登录"),
                      ),
                      onPressed: short.data
                          ? () {
                              _bloc.commitData(() {
                                goPageAndFinishAll(MainPage());
                              });
                            }
                          : null,
                    ))
          ],
        ),
      ),
    );
  }

  ///创建输入框
  TextFormField createInput(String labelText, ValueChanged<String> change,
      {String hintText = "",
      bool isPhone = false,
      bool isPassword = false,
      String errorText = ""}) {
    return TextFormField(
      onChanged: change,
      obscureText: isPassword,
      decoration: InputDecoration(
        errorText: errorText == "" ? null : errorText,
        labelText: labelText,
        hintText: hintText,
      ),
      inputFormatters: [LengthLimitingTextInputFormatter(isPhone ? 11 : 20)],
    );
  }
}
