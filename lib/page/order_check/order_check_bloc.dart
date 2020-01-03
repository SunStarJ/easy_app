import 'package:rxdart/rxdart.dart';

class OrderCheckBloc {
  int listSize = 3;
  bool showMore = false;
  BehaviorSubject<bool> _showMoreSub = BehaviorSubject();
  BehaviorSubject<int> _listSizeSub = BehaviorSubject();
  get showMoreStream => _showMoreSub.stream;
  get listSizeStream => _listSizeSub.stream;

  ///显示更多
  void changeShowMore() {
    showMore=!showMore;
    _showMoreSub.add(showMore);
    if(showMore){
      listSize = 5;
    }else{
      listSize = 3;
    }
    _listSizeSub.add(listSize);
  }
}
