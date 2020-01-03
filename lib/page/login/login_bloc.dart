import 'package:easy_app/util.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc {
  String userNameError = "";
  String _userName;
  String _passWord;
  bool canLogin = false;
  BehaviorSubject _canLoginSub = BehaviorSubject<bool>();
  BehaviorSubject _errorStringSub = BehaviorSubject<String>();

  get errorStringStream => _errorStringSub.stream;
  get canLoginStream => _canLoginSub.stream;

  void changeUserName(String userName) {
    _userName = userName;
    checkCanLogin();
  }

  void changePassword(String passWord) {
    _passWord = passWord;
    checkCanLogin();
  }

  void checkCanLogin() {
    userNameError =
    _userName.length < 11 ? "" : !Util.isChinaPhoneLegal(_userName)
        ? "手机号格式不正确"
        : "";
    canLogin = Util.isChinaPhoneLegal(_userName) && _passWord.length >= 6;
    _canLoginSub.add(canLogin);
    _errorStringSub.add(userNameError);
  }

  void commitData(Function f) {
    canLogin = false;
    _canLoginSub.add(canLogin);
    Future.delayed(Duration(seconds: 2),f);
  }
}
