import 'package:rxdart/rxdart.dart';

class ShopInfoBloc {
  double scrollOffset = 0;
  BehaviorSubject<double> _heightSub = BehaviorSubject();
  get heightStream => _heightSub.stream;
  void changeHeight(double height){
    scrollOffset = height;
    _heightSub.add(scrollOffset);
  }
}