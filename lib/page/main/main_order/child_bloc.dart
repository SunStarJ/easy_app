import 'package:rxdart/rxdart.dart';

class ChildBloc {
  List<String> data = List();

  get dataStream => _dataListSub.stream;
  BehaviorSubject<List<String>> _dataListSub = BehaviorSubject();

  void initListData() {
    Future.delayed(Duration(seconds: 2)).then((_) {
      for (int i = 0; i < 10; i++) {
        data.add("");
      }
    }).whenComplete(() {
      _dataListSub.add(data);
    });
  }
}
