import 'package:easy_app/base_file.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class LivePage extends BaseStatelessPage {

  FijkPlayer _player = FijkPlayer();

  LivePage() {
    _player.setDataSource("http://ivi.bupt.edu.cn/hls/cctv1hd.m3u8",autoPlay: true);
  }

  @override
  String initAppName() {
    // TODO: implement initAppName
    return "";
  }

  @override
  bool showAppBar() => false;

  @override
  Widget initChild() {
    // TODO: implement initChild
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            child: AspectRatio(
              aspectRatio: 16.0 / 9.0,
              child: FijkView(player: _player,cover: AssetImage("assets/test1.jpg"),fit: FijkFit.cover,color: Colors.black,),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void onDestroy() {
    // TODO: implement onDestroy
    _player.release();
    super.onDestroy();
  }
}
