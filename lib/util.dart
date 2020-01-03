import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Util {
  ///大陆手机号码11位数，匹配格式：前三位固定格式+后8位任意数
  /// 此方法中前三位格式有：
  /// 13+任意数 * 15+除4的任意数 * 18+除1和4的任意数 * 17+除9的任意数 * 147
  static bool isChinaPhoneLegal(String str) {
    return new RegExp(
            '^((13[0-9])|(15[^4])|(166)|(17[0-8])|(18[0-9])|(19[8-9])|(147,145))\\d{8}\$')
        .hasMatch(str);
  }

  static createBoxShadow({Color colorData = Colors.blue }) => BoxShadow(
      color:colorData.withAlpha(50), offset: Offset(1, 1), spreadRadius: 1);

  static createBgShimmer() => Shimmer.fromColors(
      child: Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FlutterLogo(),
            Container(
              height: 10,
            ),
            Text("数据加载中...")
          ],
        ),
      ),
      baseColor: Colors.grey,
      highlightColor: Colors.white);
}
