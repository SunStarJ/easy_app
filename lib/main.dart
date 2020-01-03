import 'package:easy_app/page/login/login_page.dart';
import 'package:easy_app/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        platform: TargetPlatform.iOS,
        appBarTheme: Theme.of(context).appBarTheme.copyWith(
            iconTheme: IconThemeData(color: Colors.black),
            elevation: 1,
            color: Colors.white,
            textTheme: Theme.of(context).textTheme.copyWith(
                title: Theme.of(context)
                    .textTheme
                    .title
                    .copyWith(color: Colors.black))),
      ),
      darkTheme: MyTheme.myDarkTheme,
      home: LoginPagePage(),
    );
  }
}
