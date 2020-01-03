import 'package:easy_app/base_file.dart';
import 'package:easy_app/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../color_util.dart';

class CardBuyPage extends BaseStatelessPage {
  String heroTag = "";
  String titleHeroTag = "";
  bool isLesson = false;

  @override
  String initAppName() => "卡详情";

  @override
  Widget initChild() {
    // TODO: implement initChild
    return Column(
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  height: 170,
                  color: ColorUtil.bodyColor,
                  child: Hero(
                      createRectTween: (Rect begin, Rect end) {
                        return RectTween(
                          begin: Rect.fromLTRB(begin.left, begin.top,
                              begin.right, begin.top + 160),
                          end: Rect.fromLTRB(
                              end.left, end.top, end.right, end.bottom),
                        );
                      },
                      tag: heroTag,
                      child: Container(
                        height: 150,
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    "测试数据贼老长贼老长贼老长贼老长贼老长贼老长贼老长",
                                    overflow: TextOverflow.clip,
                                    style: Theme.of(basePageContext)
                                        .textTheme
                                        .subtitle
                                        .copyWith(color: Colors.white),
                                  ),
                                  flex: 1,
                                )
                              ],
                            ),
                            Container(
                              height: 10,
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  child: Text(isLesson ? "团" : "私",
                                      style: Theme.of(basePageContext)
                                          .textTheme
                                          .subtitle
                                          .copyWith(
                                            color: isLesson
                                                ? Colors.blue
                                                : Colors.purple,
                                          )),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(3)),
                                  height: 20,
                                  width: 20,
                                ),
                                Container(
                                  width: 5,
                                ),
                                Text(
                                  "卡片描述.......",
                                  style: Theme.of(basePageContext)
                                      .textTheme
                                      .subtitle
                                      .copyWith(color: Colors.white),
                                )
                              ],
                            ),
                            Expanded(
                              child: Container(),
                              flex: 1,
                            ),
                            Text(
                              "有效期：30天",
                              style: Theme.of(basePageContext)
                                  .textTheme
                                  .subtitle
                                  .copyWith(color: Colors.white),
                            )
                          ],
                        ),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              isLesson ? Colors.blue : Colors.purple,
                              isLesson
                                  ? Colors.lightBlueAccent
                                  : Colors.purpleAccent
                            ]),
                            boxShadow: [
                              Util.createBoxShadow(
                                  colorData:
                                      isLesson ? Colors.blue : Colors.purple)
                            ],
                            borderRadius: BorderRadius.circular(10)),
                      )),
                ),
                createTitle("购卡须知", Icons.library_books),
                Divider(
                  height: 1,
                ),
                Container(
                    color: ColorUtil.bodyColor,
                    child: ListView.builder(
                      padding: EdgeInsets.only(bottom: 10),
                      itemBuilder: (ctx, index) => Container(
                        padding: EdgeInsets.symmetric(horizontal: 10)
                            .copyWith(top: 5),
                        child: Row(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius: BorderRadius.circular(10)),
                              width: 5,
                              height: 5,
                              margin: EdgeInsets.only(right: 5),
                            ),
                            Text(
                              "测试数据以后再说",
                              style: Theme.of(basePageContext)
                                  .textTheme
                                  .body1
                                  .copyWith(fontSize: 12),
                            )
                          ],
                        ),
                      ),
                      itemCount: 3,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                    )),
                createTitle("使用说明", Icons.book),
                Divider(
                  height: 1,
                ),
                Container(
                    color: ColorUtil.bodyColor,
                    child: ListView.builder(
                      padding: EdgeInsets.only(bottom: 10),
                      itemBuilder: (ctx, index) => Container(
                        padding: EdgeInsets.symmetric(horizontal: 10)
                            .copyWith(top: 5),
                        child: Row(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius: BorderRadius.circular(10)),
                              width: 5,
                              height: 5,
                              margin: EdgeInsets.only(right: 5),
                            ),
                            Text(
                              "测试数据以后再说",
                              style: Theme.of(basePageContext)
                                  .textTheme
                                  .body1
                                  .copyWith(fontSize: 12),
                            )
                          ],
                        ),
                      ),
                      itemCount: 3,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                    )),
              ],
            ),
          ),
          flex: 1,
        ),
        Container(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: RichText(
                      text: TextSpan(
                          text: "￥9.9",
                          children: [
                            TextSpan(
                                text: "￥5",
                                style: TextStyle(
                                    color: Colors.orange, fontSize: 16))
                          ],
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 10,
                              decoration: TextDecoration.lineThrough))),
                ),
                flex: 1,
              ),
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.center,
                    color: Colors.blueAccent,
                    child: Text(
                      "立即购买",
                      style: TextStyle(color: Colors.white,fontSize: 16),
                    ),
                  ),
                  onTap: () {},
                ),
                flex: 1,
              )
            ],
          ),
          color: ColorUtil.bodyColor,
        )
      ],
    );
  }

  Container createTitle(String name, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            color: Colors.blue,
            size: 14,
          ),
          Container(
            width: 5,
          ),
          Text(
            name,
            style: Theme.of(basePageContext)
                .textTheme
                .body1
                .copyWith(fontWeight: FontWeight.w600),
          )
        ],
      ),
      margin: EdgeInsets.only(top: 10),
      color: Colors.white,
    );
  }

  CardBuyPage(this.heroTag, this.titleHeroTag, this.isLesson);
}
