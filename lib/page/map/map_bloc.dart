import 'package:rxdart/rxdart.dart';

class NavigationBloc {
  int index = 0;
  BehaviorSubject _indexSub = BehaviorSubject<int>();

  get indexStream => _indexSub.stream;

  void changeIndex(int index) {
    this.index = index;
    _indexSub.add(this.index);
  }
}
