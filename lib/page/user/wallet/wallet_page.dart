import 'package:easy_app/base_file.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WalletPage extends BaseStatelessPage {
  @override
  String initAppName() => "账户余额";

  @override
  Widget initChild() {
    // TODO: implement initChild
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[createTop(), createBottom()],
      ),
      padding: EdgeInsets.all(10),
    );
  }

  createBottom() => Column(
        children: <Widget>[
          Text(
            "充值金额只能在当前门店使用",
            style: TextStyle(color: Colors.grey),
          ),
          Container(
            height: 10,
          ),
          MaterialButton(
            elevation: 0,
            onPressed: () {},
            child: Center(
              child: Text("充值"),
            ),
            color: Theme.of(basePageContext).accentColor,
            textColor: Colors.white,
          ),
        ],
        mainAxisSize: MainAxisSize.min,
      );

  createTop() => Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              FlatButton(
                  onPressed: () {},
                  child: Text(
                    "明细",
                    style: TextStyle(color: Colors.blueAccent),
                  ))
            ],
            mainAxisAlignment: MainAxisAlignment.end,
          ),
          Container(height: 20,),
          Text("0.00",style: Theme.of(basePageContext).textTheme.title.copyWith(fontSize: 44,fontWeight: FontWeight.w600),),
          Text("总余额（元）",style: TextStyle(color: Colors.grey),),
          Container(height: 40,),
          Row(children: <Widget>[
            createItem("0.00","充值余额（元）"),
            Container(height: 60,child:VerticalDivider(width: 1,color: Colors.grey,),),
            createItem("0.00","赠送余额（元）"),
          ],mainAxisAlignment: MainAxisAlignment.spaceAround,)
        ],
      );

  createItem(String s, String t) =>Column(children: <Widget>[ Text(s,style: Theme.of(basePageContext).textTheme.title.copyWith(fontSize: 36,fontWeight: FontWeight.w600),),
    Text(t,style: TextStyle(color: Colors.grey,fontSize: 12),),],);
}
