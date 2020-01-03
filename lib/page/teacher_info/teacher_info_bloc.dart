import 'package:easy_app/page/main/main_order/order_lesson_bloc.dart';
import 'package:rxdart/rxdart.dart';

class TeacherInfoBloc {
  List<WeekData> weekDayData = List(); //日期选择数据
  List<SelectData> timeSelectData = List(); //时间选择器
  BehaviorSubject<List<WeekData>> _weekDataSub = BehaviorSubject();
  BehaviorSubject<List<SelectData>> _timeDataSub = BehaviorSubject();

  get weekStream => _weekDataSub.stream;

  get timeStream => _timeDataSub.stream;

  void createTimeData(){
    for( int i = 9; i <= 20 ;i++ ){
      timeSelectData.add(SelectData('${i<10?"0$i":i}:00'));
    }
    _timeDataSub.add(timeSelectData);
  }

  ///创建日期选择器
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

  void changeWeekData(int index) {
    weekDayData.forEach((data) {
      data.isSelect = false;
    });
    weekDayData[index].isSelect = true;
    _weekDataSub.add(weekDayData);
  }

  void changeTimeSelect(int index) {
    timeSelectData.forEach((data) {
      data.isSelect = false;
    });
    timeSelectData[index].isSelect = true;
    _timeDataSub.add(timeSelectData);
  }
}
