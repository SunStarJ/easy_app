import 'package:easy_app/base_file.dart';
import 'package:easy_app/color_util.dart';
import 'package:easy_app/page/card_buy/card_buy_page.dart';
import 'package:easy_app/page/lesson_info/lesson_info_page.dart';
import 'package:easy_app/page/teacher_info/teacher_info_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:ui' as ui;
class ChildPage {
  Builder createTeacherPage(BuildContext mContext) => Builder(
      builder: (ctx) => CustomScrollView(
            slivers: <Widget>[
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (ctx, index) =>GestureDetector(onTap: (){
                        Navigation.startPage(mContext, TeacherInfoPage());
                      },child:  Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Theme.of(ctx).dividerColor)),
                            color: ColorUtil.bodyColor),
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: 75,
                              width: 75,
                              child: ClipRRect(
                                child: ConstrainedBox(
                                  constraints: BoxConstraints.expand(),
                                  child: Image.network(
                                      "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3896192335,1941366028&fm=15&gp=0.jpg"),
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              height: 75,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Text(
                                    "测试",
                                    style: Theme.of(ctx).textTheme.subtitle,
                                  ),
                                  Text(
                                    "肌肉·塑性·心肺",
                                    style: TextStyle(color: Colors.grey,fontSize: 12),
                                  ),
                                  Text("￥1",style: TextStyle(color: Colors.orange,fontSize: 16),)
                                ],
                              ),
                            )
                          ],
                        ),
                      ),) ,
                      childCount: 5))
            ],
          ));

  ///首页样式
  Builder createBuyCardPage() => Builder(
        builder: (ctx) => CustomScrollView(
          // key 保证唯一性
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  "团课卡",
                  style: Theme.of(ctx).textTheme.subtitle,
                ),
              ),
            ),
            createItemList(true),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  "私教卡",
                  style: Theme.of(ctx).textTheme.subtitle,
                ),
              ),
            ),
            createItemList(false),
          ],
        ),
      );

  ///首页列表
  SliverList createItemList(bool isLesson) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
            (ctx, index) => GestureDetector(child:  Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: Theme.of(ctx).dividerColor, width: 1)),
                  color:ColorUtil.bodyColor),
              padding: EdgeInsets.all(10),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Hero(tag: "card_hero_${index}_${isLesson}", child:  Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            isLesson ? "团课卡" : "私教卡",
                            style: Theme.of(ctx)
                                .textTheme
                                .subtitle
                                .copyWith(color: Colors.white),
                          ),
                          Text(
                            "有效期：2天 次数：20次",
                            style: Theme.of(ctx).textTheme.body2.copyWith(color: Colors.white,fontSize: 10),
                          )
                        ],
                      ),
                      padding: EdgeInsets.all(10),
                      width: 140,
                      margin: EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            isLesson ? Colors.blue : Colors.purple,
                            isLesson
                                ? Colors.lightBlueAccent
                                : Colors.purpleAccent
                          ]),
                          borderRadius: BorderRadius.circular(10)),
                    )),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Hero(tag: "card_hero_title_${index}_${isLesson}", child: Text(
                            "测试数据贼老长贼老长贼老长贼老长贼老长贼老长贼老长",
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(ctx).textTheme.subtitle,
                          )),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  "￥1.00",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                      decoration:
                                      TextDecoration.lineThrough),
                                ),
                                Text(
                                  "￥0.01",
                                  style: TextStyle(
                                      color: Colors.orange, fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.indigoAccent,
                                  borderRadius: BorderRadius.circular(5)),
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 20),
                              child: Text(
                                "立即购买",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        ],
                        mainAxisSize: MainAxisSize.min,
                      ),
                      flex: 1,
                    )
                  ],
                ),
              ),
            ),
            onTap: (){
              Navigation.startPage(ctx, CardBuyPage("card_hero_${index}_${isLesson}","card_hero_title_${index}_${isLesson}",isLesson));
            },),
            childCount: 2));
  }
}
