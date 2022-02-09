import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:zeroheatproject/utils/logger.dart'; //쿠펄티노 해도됨

class UserProvider extends ChangeNotifier {
  // bool _userLoggedIn = false; //프라이빗으로 해줘야됨, false-로그인안됨 true-로그인됨
  UserProvider() {
    initUser();
  }

  User? _user;
  void initUser() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      _user = user;
      logger.d('user status - $user');
      notifyListeners();
    });
  }

  User? get user => _user;
  // void setUserAuth(bool authState) {
  //   _userLoggedIn = authState;
  //   notifyListeners(); //체인지 노티파이어에서 나온 메소드
  // }
  //
  // bool get userState => _userLoggedIn;
}
