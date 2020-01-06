import 'package:easy_app/base_file.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:r_scan/r_scan.dart';

class QrScanPage extends BaseStatelessPage {
  GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QrScanPage() {
  }

  @override
  String initAppName() => "";

  @override
  bool showAppBar() => false;

  @override
  Widget initChild() {
    // TODO: implement initChild
    return  RScanView(controller: RScanController()..addListener((){

    }),);
  }
}
