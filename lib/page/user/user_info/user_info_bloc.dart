import 'package:rxdart/rxdart.dart';

class UserInfoBloc {
  bool isEdit = false;
  BehaviorSubject<bool> _editSub = BehaviorSubject();

  get isEditStream => _editSub.stream;

  void changeEdit() {
    isEdit = !isEdit;
    _editSub.add(isEdit);
  }
}
