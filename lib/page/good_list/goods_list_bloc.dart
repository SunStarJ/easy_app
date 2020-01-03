import 'package:easy_app/page/main/main_order/order_lesson_bloc.dart';
import 'package:rxdart/rxdart.dart';

class GoodsListBloc {
  bool showCart = false;
  bool showCartAnim = false;
  List<GoodsListData> typeList = List();
  BehaviorSubject<bool> _showSub = BehaviorSubject();
  BehaviorSubject<bool> _showAnimSub = BehaviorSubject();
  BehaviorSubject<List<GoodsListData>> _typeListSub = BehaviorSubject();

  get showCartStream => _showSub.stream;

  get showCartAnimStream => _showAnimSub.stream;

  get typeListStream => _typeListSub.stream;

  ///修改是否展示购物车
  void changeShowCart() {
    if(showCart){
      showCartAnim = !showCartAnim;
      _showAnimSub.add(showCartAnim);
      Future.delayed(Duration(milliseconds: 200)).whenComplete((){
        showCart = !showCart;
        _showSub.add(showCart);
      });
    }else{
      showCart = !showCart;
      _showSub.add(showCart);
      Future.delayed(Duration(milliseconds: 20)).whenComplete((){
        showCartAnim = !showCartAnim;
        _showAnimSub.add(showCartAnim);
      });
    }

  }

  ///模拟添加数据
  void addList() {
    for (int i = 0; i < 10; i++) {
      GoodsListData data = GoodsListData("分类$i");
      data.numList.add(0);
      data.numList.add(0);
      data.numList.add(0);
      data.numList.add(0);
      data.numList.add(0);
      data.numList.add(0);
      data.numList.add(0);
      data.numList.add(0);
      data.numList.add(0);
      data.numList.add(0);
      data.numList.add(0);
      typeList.add(data);
    }
    typeList[0].isSelect = true;
    _typeListSub.add(typeList);
  }

  ///修改当前页码
  void changeIndex(int index) {
    typeList.forEach((data) {
      data.isSelect = false;
    });
    typeList[index].isSelect = true;
    _typeListSub.add(typeList);
  }

  ///修改数据数量
  void changeNum(GoodsListData data, int index, {isAdd = true}) {
    typeList.forEach((cacheData) {
      if (cacheData == data) {
        if (isAdd)
          cacheData.numList[index] += 1;
        else
          cacheData.numList[index] -= 1;
      }
    });
    _typeListSub.add(typeList);
  }
}

class GoodsListData extends SelectData {
  GoodsListData(String name) : super(name);
  List<int> numList = List();
}
