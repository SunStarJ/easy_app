import 'package:easy_app/base_file.dart';
import 'package:easy_app/static_util.dart';
import 'package:easy_app/page/shop_info/shop_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class MainUserPage extends BaseStatelessPage {
  List<String> controlString = [
    "团课记录",
    "私教记录",
    "帮助中心",
    "扫一扫",
    "我的卡包",
    "我的拼团",
    "水吧消费"
  ];

  @override
  String initAppName() => "我的";

  @override
  Widget initChild() {
    // TODO: implement initChild
    return Column(
      children: <Widget>[
        Container(
          color: ColorUtil.bodyColor,
          child: createHeader(),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(top: 10),
            color: ColorUtil.bodyColor,
            child: GridView.builder(
                itemCount: controlString.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1.5,
                    crossAxisCount: 3,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 10),
                itemBuilder: (ctx, index) => Container(
                      child: Container(
                        margin: EdgeInsets.all(2),
                        decoration: BoxDecoration(color: ColorUtil.bodyColor,borderRadius: BorderRadius.circular(2),boxShadow: [BoxShadow(
                            color: Colors.grey.withAlpha(50),
                            offset: Offset(1, 1),
                            spreadRadius: 1,
                            blurRadius:8)]),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                Icons.map,
                                color: Colors.blue,
                              ),
                              Container(height: 5,),
                              Text(controlString[index],)
                            ],
                          ),
                        ),
                      ),
                    )),
            padding: EdgeInsets.all(10),
          ),
          flex: 1,
        )
      ],
    );
  }

  Container createHeader() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      padding: EdgeInsets.symmetric(horizontal: 10).copyWith(top: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 10),
                height: 60,
                width: 60,
                child: ConstrainedBox(
                  constraints: BoxConstraints.expand(),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://pic.feizl.com/upload/allimg/190731/gxtxwuahnllnk3m.jpg"),
                  ),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: Colors.white, width: 3)),
              ),
              Expanded(
                child: Container(
                  height: 60,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "小妖怪",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      GestureDetector(
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 12,
                            ),
                            Container(
                              width: 2,
                            ),
                            Text(
                              "石家庄月野兔总店",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            )
                          ],
                        ),
                        onTap: () {
                          startPage(ShopInfoPage());
                        },
                        behavior: HitTestBehavior.translucent,
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                  ),
                ),
                flex: 1,
              ),
              Icon(
                Icons.chevron_right,
                color: Colors.white,
              )
            ],
          ),
          Container(
            height: 20,
          ),
          Row(
            children: <Widget>[
              FlatButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: () {},
                child: Text("余额：￥0.00"),
                textColor: Colors.white,
              ),
              FlatButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: () {},
                child: Text("优惠券0张"),
                textColor: Colors.white,
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          )
        ],
      ),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.blue.withAlpha(100),
                offset: Offset(1, 1),
                spreadRadius: 1,
                blurRadius: 5)
          ],
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.lightBlueAccent],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft)),
    );
  }
}
