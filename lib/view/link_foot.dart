import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

/// 链接器Footer
class LinkFooter extends Footer {
  final LinkFooterNotifier linkNotifier;

  LinkFooter(
      this.linkNotifier, {
        extent = 60.0,
        triggerDistance = 70.0,
        completeDuration,
        enableHapticFeedback = false,
      }) : super(
    extent: extent,
    triggerDistance: triggerDistance,
    float: true,
    enableInfiniteLoad:false,
    completeDuration: completeDuration,
    enableHapticFeedback: enableHapticFeedback,
  );

  @override
  Widget contentBuilder(
      BuildContext context,
      LoadMode loadState,
      double pulledExtent,
      double refreshTriggerPullDistance,
      double refreshIndicatorExtent,
      AxisDirection axisDirection,
      bool float,
      Duration completeDuration,
      bool enableInfiniteRefresh,
      bool success,
      bool noMore) {
    linkNotifier.contentBuilder(
        context,
        loadState,
        pulledExtent,
        refreshTriggerPullDistance,
        refreshIndicatorExtent,
        axisDirection,
        float,
        completeDuration,
        enableInfiniteRefresh,
        success,
        noMore);
    return SizedBox(
      width: 0.0,
      height: 0.0,
    );
  }
}