import 'package:rxdart/rxdart.dart';

class ImageScanBloc {

  int curIndex =1;

  List<String> images = [
    "https://s.yimg.com/ny/api/res/1.2/wEAfOfb.K0xbhO9pqMb.qA--~A/YXBwaWQ9aGlnaGxhbmRlcjtzbT0xO3c9ODAw/https://media.zenfs.com/en/evergreen.ttvc.com.tw/7c0a895009c9ada304ce44225f8e5b48",
    "https://s.yimg.com/ny/api/res/1.2/wEAfOfb.K0xbhO9pqMb.qA--~A/YXBwaWQ9aGlnaGxhbmRlcjtzbT0xO3c9ODAw/https://media.zenfs.com/en/evergreen.ttvc.com.tw/7c0a895009c9ada304ce44225f8e5b48",
    "https://s.yimg.com/ny/api/res/1.2/wEAfOfb.K0xbhO9pqMb.qA--~A/YXBwaWQ9aGlnaGxhbmRlcjtzbT0xO3c9ODAw/https://media.zenfs.com/en/evergreen.ttvc.com.tw/7c0a895009c9ada304ce44225f8e5b48",
    "https://s.yimg.com/ny/api/res/1.2/wEAfOfb.K0xbhO9pqMb.qA--~A/YXBwaWQ9aGlnaGxhbmRlcjtzbT0xO3c9ODAw/https://media.zenfs.com/en/evergreen.ttvc.com.tw/7c0a895009c9ada304ce44225f8e5b48"
  ];
  BehaviorSubject<List<String>> _imagesSub = BehaviorSubject();
  BehaviorSubject<int> _curIndexSub = BehaviorSubject();
  get imagesStream => _imagesSub.stream;
  get curIndexStream => _curIndexSub.stream;

  ///修改页面值
  void changeIndex(int index){
    curIndex = index;
    _curIndexSub.add(curIndex);
  }

}
