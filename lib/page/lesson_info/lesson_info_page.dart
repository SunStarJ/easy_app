import 'package:easy_app/base_file.dart';
import 'package:easy_app/page/image_scan/iamge_scan_page.dart';
import 'package:easy_app/util.dart';
import 'package:easy_app/view/customer_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class LessonInfoPage extends BaseStatelessPage {
  List<String> label = ["愉悦健身", "有氧", "燃脂", "舞蹈"];

  @override
  String initAppName() => "热舞派对";

  @override
  Widget initChild() {
    // TODO: implement initChild
    return Column(
      children: <Widget>[
        Expanded(
          child: createScrollBody(),
          flex: 1,
        ),
        createBottom()
      ],
    );
  }

  ///创建底部操作栏
  Container createBottom() {
    return Container(
      padding: EdgeInsets.only(left: 10),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Expanded(
            child: RichText(
              text: TextSpan(
                  text: "￥18.00",
                  children: [
                    TextSpan(
                        text: "￥9.90",
                        style: TextStyle(
                            color: Colors.orange,
                            fontSize: 16,
                            decoration: TextDecoration.none))
                  ],
                  style: TextStyle(
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                      fontSize: 12)),
            ),
            flex: 1,
          ),
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  "立即约课",
                  style: TextStyle(color: Colors.white),
                ),
                color: Theme.of(basePageContext).accentColor,
              ),
              onTap: () {},
            ),
            flex: 1,
          )
        ],
      ),
    );
  }

  ///创建body
  SingleChildScrollView createScrollBody() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              BlurView(
                  Container(
                    child: ConstrainedBox(
                      constraints: BoxConstraints.expand(),
                      child: Image.network(
                        "https://kiks.com.cn/wp-content/uploads/2019/10/HEN11_4422.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                    height: 120,
                    width: double.infinity,
                  ),
                  Colors.black,
                  120),
              Positioned(
                child: Container(
                  color: Colors.white,
                ),
                top: 120,
                left: 0,
                right: 0,
                bottom: 0,
              ),
              Column(
                children: <Widget>[
                  buildTeacherCard(),
                  createIconText(Icons.watch_later, "2019年12月31日 18：30-19：20"),
                  createIconText(Icons.directions_bike, "健身厅")
                ],
              )
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            margin: EdgeInsets.only(top: 10),
            color: Colors.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.subtitles,
                  color: Colors.blue,
                  size: 16,
                ),
                Container(
                  width: 5,
                ),
                Text(
                  "课程简介",
                  style: TextStyle(fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
          Divider(
            height: 1,
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("这是一个介绍很多很多这是一个介绍很多很多这是一个介绍很多很多这是一个介绍很多很多这是一个介绍很多很多"),
                Wrap(
                  alignment: WrapAlignment.start,
                  children: label
                      .map((text) => Container(
                            margin: EdgeInsets.symmetric(vertical: 3)
                                .copyWith(right: 3),
                            child: Text(text),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey[200], width: 1),
                                borderRadius: BorderRadius.circular(5)),
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 3),
                          ))
                      .toList(),
                )
              ],
            ),
          ),
          Container(
            height: 80,
            width: double.infinity,
            child: ListView.builder(
                padding: EdgeInsets.only(left: 10),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (ctx, index) => GestureDetector(child: Container(
                  child: ConstrainedBox(
                    constraints: BoxConstraints.expand(),
                    child: Image.network(
                      "https://s.yimg.com/ny/api/res/1.2/wEAfOfb.K0xbhO9pqMb.qA--~A/YXBwaWQ9aGlnaGxhbmRlcjtzbT0xO3c9ODAw/https://media.zenfs.com/en/evergreen.ttvc.com.tw/7c0a895009c9ada304ce44225f8e5b48",
                      fit: BoxFit.cover,
                    ),
                  ),
                  width: 120,
                  height: 80,
                  margin: EdgeInsets.only(right: 5),
                ),onTap: (){
                  startPage(ImageScanPage());
                },) ),
          ),
          createTitleInfo("训练效果",
              "测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据"),
          createTitleInfo("适宜人群",
              "测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据"),
          createTitleInfo("FAQ",
              "测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据"),
          createTitleInfo("注意事项",
              "测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据"),
        ],
      ),
    );
  }

  ///创建教练卡片
  Container buildTeacherCard() {
    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: 10).copyWith(top: 80, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 10),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "http://www.520touxiang.com/uploads/allimg/201903212130/02xbjf4v1rt.jpg"),
                ),
                height: 60,
                width: 60,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "陈小楠",
                    style: Theme.of(basePageContext)
                        .textTheme
                        .title
                        .copyWith(fontSize: 16),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      "教学次数：1次",
                      style: Theme.of(basePageContext)
                          .textTheme
                          .body2
                          .copyWith(fontSize: 12),
                    ),
                  ),
                  Text(
                    "个性签名：运动让生活更美好！",
                    style: Theme.of(basePageContext)
                        .textTheme
                        .body2
                        .copyWith(fontSize: 12),
                  )
                ],
              )
            ],
          ),
          Container(
            height: 10,
          ),
          Text("教练介绍：-")
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
          boxShadow: [Util.createBoxShadow()],
          color: Colors.white,
          borderRadius: BorderRadius.circular(5)),
    );
  }

  createIconText(IconData icon, String s) => Container(
        margin: EdgeInsets.only(bottom: 5, left: 10, right: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              size: 16,
              color: Colors.blue,
            ),
            Container(
              width: 5,
            ),
            Text(
              s,
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
      );

  createTitleInfo(String s, String t) => Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(vertical: 5),
              child: Text(s,
                  style: TextStyle(fontSize: 12, color: Colors.blueAccent)),
              width: 80,
              decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(5)),
              padding: EdgeInsets.symmetric(vertical: 5),
            ),
            Text(
              t,
            )
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 10),
      );
}
