import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zeroheatproject/constants/shared_pref_keys.dart';
import 'package:zeroheatproject/data/user_model.dart';
import 'package:zeroheatproject/repo/user_service.dart';
import 'package:zeroheatproject/utils/logger.dart'; //쿠펄티노 해도됨

class UserProvider extends ChangeNotifier {
  // bool _userLoggedIn = false; //프라이빗으로 해줘야됨, false-로그인안됨 true-로그인됨
  UserProvider() {
    initUser();
  }

  User? _user;
  UserModel? _userModel;

  void initUser() {
    FirebaseAuth.instance.authStateChanges().listen((user) async {
      await _setNewUser(user);
      notifyListeners();
    });
  }

  Future _setNewUser(User? user) async {
    _user = user;
    if (user != null && user.phoneNumber != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String address = prefs.getString(SHARED_ADDRESS) ?? "";
      double lat = prefs.getDouble(SHARED_LAT) ?? 0;
      double lon = prefs.getDouble(SHARED_LON) ?? 0;
      String phoneNumber = user.phoneNumber!;
      String userKey = user.uid;

      UserModel userModel = UserModel(
          userKey: userKey,
          phoneNumber: phoneNumber,
          address: address,
          geoFirePoint: GeoFirePoint(lat, lon),
          createdDate: DateTime.now().toUtc());

      await UserService().createNewUser(userModel.toJson(), userKey);
    }
  }

  User? get user => _user;
  // void setUserAuth(bool authState) {
  //   _userLoggedIn = authState;
  //   notifyListeners(); //체인지 노티파이어에서 나온 메소드
  // }
  //
  // bool get userState => _userLoggedIn;
}
