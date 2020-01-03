import 'package:rxdart/rxdart.dart';

class OrderLessonBloc {
  List<SelectData> timeSelectData = List(); //时间选择集合
  SelectData timeAllSelect = SelectData("全部时间");
  List<SelectData> typeSelectData = List(); //类型选择集合
  SelectData typeAllSelect = SelectData("全部类型");
  List<SelectData> calSelectData = List(); //卡路里选择集合
  SelectData calAllSelect = SelectData("全部类型");
  List<WeekData> weekDayData = List(); //日期选择数据
  int curIndex = 0;

  ///bloc 管道流控制器们
  BehaviorSubject<List<SelectData>> _timeSelectDataSub = BehaviorSubject();
  BehaviorSubject<int> _indexSub = BehaviorSubject();
  BehaviorSubject<List<WeekData>> _weekDataSub = BehaviorSubject();
  BehaviorSubject<List<SelectData>> _typeSelectDataSub = BehaviorSubject();
  BehaviorSubject<List<SelectData>> _calSelectDataSub = BehaviorSubject();
  BehaviorSubject<SelectData> _timeAllSelectSub = BehaviorSubject();
  BehaviorSubject<SelectData> _typeAllSelectSub = BehaviorSubject();
  BehaviorSubject<SelectData> _calAllSelectDataSub = BehaviorSubject();

  get indexStream => _indexSub.stream;

  get weekStream => _weekDataSub.stream;

  get timeSelectDataStream => _timeSelectDataSub.stream;

  get typeSelectDataStream => _typeSelectDataSub.stream;

  get calSelectDataStream => _calSelectDataSub.stream;

  get timeAllSelectStream => _timeAllSelectSub.stream;

  get typeAllSelectStream => _typeAllSelectSub.stream;

  get calAllSelectDataStream => _calAllSelectDataSub.stream;

  void createWeekName() {
    DateTime _date = DateTime.now();
    List<String> cWeekNameList = ["一", "二", "三", "四", "五", "六", "日"];
    print(_date.weekday);
    WeekData _week = WeekData(cWeekNameList[_date.weekday - 1],
        cWeekNameList[_date.weekday - 1], "${_date.month}-${_date.day}");
    _week.isSelect = true;
    weekDayData.add(_week);
    for (int i = 1; i <= 6; i++) {
      DateTime _cacheDate = DateTime(_date.year, _date.month, _date.day + i);
      WeekData _week = WeekData(
          cWeekNameList[_date.weekday - 1],
          cWeekNameList[_cacheDate.weekday - 1],
          '${_cacheDate.month < 10 ? "0${_cacheDate.month}" : _cacheDate.month}-${_cacheDate.day < 10 ? "0${_cacheDate.day}" : _cacheDate.day}');
      weekDayData.add(_week);
    }
    print(weekDayData.length);
  }

  void initData() {
    timeSelectData.add(SelectData("06:00-09:00"));
    timeSelectData.add(SelectData("09:00-12:00"));
    timeSelectData.add(SelectData("12:00-14:00"));
    timeSelectData.add(SelectData("14:00-18:00"));
    timeSelectData.add(SelectData("18:00-22:30"));

    typeSelectData.add(SelectData("肌肉"));
    typeSelectData.add(SelectData("塑性"));
    typeSelectData.add(SelectData("心肺"));
    typeSelectData.add(SelectData("燃脂"));
    typeSelectData.add(SelectData("力量"));
    typeSelectData.add(SelectData("体能"));
    typeSelectData.add(SelectData("有氧"));
    typeSelectData.add(SelectData("臀腿"));
    typeSelectData.add(SelectData("产前"));
    typeSelectData.add(SelectData("产后"));
    typeSelectData.add(SelectData("康复训练"));

    calSelectData.add(SelectData("0-400卡路里"));
    calSelectData.add(SelectData("400-800卡路里"));
    calSelectData.add(SelectData("800-1200卡路里"));

    _timeSelectDataSub.add(timeSelectData);
    _typeSelectDataSub.add(typeSelectData);
    _calSelectDataSub.add(calSelectData);
  }

  ///全选时间
  void selectTimeAll() {
    bool isSelect = !timeAllSelect.isSelect;
    timeSelectData.forEach((data) {
      data.isSelect = isSelect;
    });
    _timeSelectDataSub.add(timeSelectData);
    timeAllSelect.isSelect = isSelect;
    _timeAllSelectSub.add(timeAllSelect);
  }

  ///全选类型
  void selectTypeAll() {
    bool isSelect = !typeAllSelect.isSelect;
    typeSelectData.forEach((data) {
      data.isSelect = isSelect;
    });
    _typeSelectDataSub.add(typeSelectData);
    typeAllSelect.isSelect = isSelect;
    _typeAllSelectSub.add(typeAllSelect);
  }

  ///全选卡路里
  void selectCalAll() {
    bool isSelect = !calAllSelect.isSelect;
    calSelectData.forEach((data) {
      data.isSelect = isSelect;
    });
    _calSelectDataSub.add(calSelectData);
    calAllSelect.isSelect = isSelect;
    _calAllSelectDataSub.add(calAllSelect);
  }

  ///修改卡路里选择
  void changeCal(String name) {
    int selectTotal = 0;
    calSelectData.forEach((data) {
      if (data.name == name) {
        data.isSelect = !data.isSelect;
      }
      if (data.isSelect) {
        selectTotal += 1;
      }
    });
    _calSelectDataSub.add(calSelectData);
    calAllSelect.isSelect = selectTotal == calSelectData.length;
    _calAllSelectDataSub.add(calAllSelect);
  }

  ///修改类型选择
  void changeType(String name) {
    int selectTotal = 0;
    typeSelectData.forEach((data) {
      if (data.name == name) {
        data.isSelect = !data.isSelect;
      }
      if (data.isSelect) {
        selectTotal += 1;
      }
    });
    _typeSelectDataSub.add(typeSelectData);
    typeAllSelect.isSelect = selectTotal == typeSelectData.length;
    _typeAllSelectSub.add(typeAllSelect);
  }

  ///修改时间选择
  void changeTimeSelectData(String name) {
    int selectTotal = 0;
    timeSelectData.forEach((data) {
      if (data.name == name) {
        data.isSelect = !data.isSelect;
      }
      if (data.isSelect) {
        selectTotal += 1;
      }
    });
    _timeSelectDataSub.add(timeSelectData);
    timeAllSelect.isSelect = selectTotal == timeSelectData.length;
    _timeAllSelectSub.add(timeAllSelect);
  }

  void changeWeekData(int index) {
    weekDayData.forEach((data) {
      data.isSelect = false;
    });
    weekDayData[index].isSelect = true;
    curIndex = index;
    _indexSub.add(curIndex);
    _weekDataSub.add(weekDayData);
  }
}

class WeekData extends SelectData {
  String dateName;
  String weekName;

  WeekData(String name, this.weekName, this.dateName) : super(name);
}

class SelectData {
  bool isSelect = true;
  String name = "";

  SelectData(this.name, {this.isSelect = false});
}
