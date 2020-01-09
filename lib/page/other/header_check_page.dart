import 'package:easy_app/base_file.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:photo_view/photo_view.dart';

class HeaderCheckPage extends BaseStatelessPage {
  @override
  String initAppName() {
    // TODO: implement initAppName
    return "";
  }

  @override
  bool showAppBar() => false;

  @override
  Widget initChild() {
    return GestureDetector(
        child: PhotoView(
          heroAttributes: PhotoViewHeroAttributes(tag: "info_header") ,
        imageProvider: NetworkImage(
        "https://pic.feizl.com/upload/allimg/190731/gxtxwuahnllnk3m.jpg")),
    onTap: () {
    Navigator.pop(basePageContext);
    },)
    ;
  }
}
