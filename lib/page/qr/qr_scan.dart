import 'package:easy_app/base_file.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScanPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _QrScanPageState();
  }
}

class _QrScanPageState extends BaseState<QrScanPage> with SingleTickerProviderStateMixin {
  QRViewController _controller;
  GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  double height = 0;
  double width = 0;
  AnimationController _animController ;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animController =  AnimationController(vsync: this,duration: Duration(seconds:10));
    CurvedAnimation _anim = CurvedAnimation(parent: _animController, curve: Curves.linear);
    _anim.addListener((){
      setState(() {

      });
    });
    _anim.addStatusListener((state){
      if(state == AnimationStatus.completed){
        _animController.repeat();
      }
    });
    _animController.forward(from: 0);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller?.dispose();
    _animController?.dispose();
    super.dispose();
  }

  @override
  String initAppName() => "";

  @override
  bool showAppBar() => false;

  @override
  Widget initChild() {
    setState(() {
      height = MediaQuery.of(context).size.height;
      width = MediaQuery.of(context).size.width;
    });
    // TODO: implement initChild
    return Stack(
      children: <Widget>[
        Container(
          child: QRView(key: qrKey, onQRViewCreated: _create),
          height: height,
          width: width,
        ),
        Positioned(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10000),
                gradient: LinearGradient(colors: [
              Colors.lightBlueAccent.withAlpha(10),
              Colors.lightBlueAccent.withAlpha(150),
              Colors.lightBlueAccent.withAlpha(10)
            ])),
          ),
          top: 50+((height-100)*_animController.value) ,
          left: 30,
          right: 30,
          height: 3,
        )
      ],
    );
  }

  void _create(QRViewController controller) {
    _controller = controller;
    controller.scannedDataStream.listen((data) {
      print(data);
    });
  }
}
