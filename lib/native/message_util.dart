

import 'package:easy_app/page/message/message_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NativeMessageUtil{
  static initMessageChannel(BuildContext context){
    EventChannel("com.example.easy_app.message").receiveBroadcastStream().listen((data){
      Navigator.push(context, MaterialPageRoute(builder: (ctx)=>MessagePage()));
    });
  }
}