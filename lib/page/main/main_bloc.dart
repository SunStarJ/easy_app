import 'package:rxdart/rxdart.dart';

class MainBloc {
  int curIndex = 0;
  BehaviorSubject _indexSub = BehaviorSubject<int>();

  get indexStream => _indexSub.stream;

  void changeIndex(index) {
    print(index);
    curIndex = index;
    _indexSub.add(curIndex);
  }
}
