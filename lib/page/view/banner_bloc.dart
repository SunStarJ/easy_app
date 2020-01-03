import 'package:rxdart/rxdart.dart';

class BannerBloc {
  int dotIndex = 1;
  BehaviorSubject<int> _dotIndexSub = BehaviorSubject();
  get dotIndexStream => _dotIndexSub.stream;
  void changeDotIndex(int index){
    dotIndex = index;
    _dotIndexSub.add(dotIndex);
  }
}