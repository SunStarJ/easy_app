import 'package:easy_app/base_file.dart';
import 'package:easy_app/static_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class CardOrderInfo extends BaseStatelessPage {
  @override
  String initAppName() => "订单详情";

  @override
  Widget initChild() {
    // TODO: implement initChild
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Card(
                    elevation: 3,
                    margin: EdgeInsets.all(10),
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          createItem("天数=0，次数>0", "￥0.01"),
                          createItem("数量", "1"),
                          createItem("总价", "￥0.01", isLast: true)
                        ],
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                    )),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "需支付：",
                        style: Theme.of(basePageContext)
                            .textTheme
                            .body2
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "￥0.01",
                        style: TextStyle(
                            color: Colors.orange,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  alignment: Alignment.center,
                )
              ],
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Checkbox(value: true, onChanged: (isSelect) {}),
                Text("同意"),
                FlatButton(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    onPressed: () {},
                    child: Text(
                      "《会员服务协议》",
                      style: TextStyle(color: Colors.blueAccent),
                    ))
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "确认订单",
                  style: AppStyle.BtnTextStyle,
                ),
                color: Colors.blueAccent,
              ),
            )
          ],
        )
      ],
    );
  }

  createItem(String name, String value, {bool isLast = false}) => Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: <Widget>[Text(name), Text(value)],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: isLast
                        ? Colors.transparent
                        : Theme.of(basePageContext).dividerColor,
                    width: 1))),
      );
}
