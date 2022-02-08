import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeroheatproject/router/locations.dart';
import 'package:zeroheatproject/screens/start_screen.dart';
import 'package:zeroheatproject/screens/splash_screen.dart';
import 'package:zeroheatproject/states/user_provider.dart';
import 'package:zeroheatproject/utils/logger.dart';

final _routerDelegate = BeamerDelegate(guards: [
  BeamGuard(
      pathPatterns: ['/'],
      check: (context, location) {
        return context
            .watch<UserProvider>()
            .userState; //read = 노티파이더 안받음, watch = 노티파이어받을때 씀
      },
      showPage: BeamPage(child: StartScreen()))
], locationBuilder: BeamerLocationBuilder(beamLocations: [HomeLocation()]));

void main() {
  logger.d('my first log by logger!');
  Provider.debugCheckInvalidValueType =
      null; //일반적으로 프로바이더만 잘안쓰기 때매 수동으로 런앱 되기전에 널 넣어줘야됨
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(
            Duration(microseconds: 300), () => 100), //작업을 리퀘스트하면 도착하는 퓨처
        builder: (context, snapshot) {
          return AnimatedSwitcher(
              //자동으로 애니메이션 줘서 화면전환
              duration: Duration(milliseconds: 300),
              child: _splashLoadingWidget(snapshot));
        });
  }

  StatelessWidget _splashLoadingWidget(AsyncSnapshot<Object?> snapshot) {
    if (snapshot.hasError) {
      print('로딩하는동안 에러가 발생했다.');
      return Text('에러 오컬');
    } else if (snapshot.hasData) {
      return TomatoApp();
    } else {
      return SplashScreen();
    }
  }
}

class TomatoApp extends StatelessWidget {
  const TomatoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserProvider>(
      create: (BuildContext context) {
        return UserProvider();
      },
      child: MaterialApp.router(
          theme: ThemeData(
            primarySwatch: Colors.red,
            fontFamily: 'DoHyeon',
            hintColor: Colors.grey[350],
            textTheme: TextTheme(
              button: TextStyle(color: Colors.white),
              subtitle1: TextStyle(
                color: Colors.black87,
                fontSize: 15,
              ),
              subtitle2: TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                primary: Colors.white,
                minimumSize: Size(48, 48),
              ),
            ),
            appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                titleTextStyle: TextStyle(
                  color: Colors.black87,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                elevation: 2,
                actionsIconTheme: IconThemeData(color: Colors.black87)),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
                selectedItemColor: Colors.black87,
                unselectedItemColor: Colors.black54),
          ),
          routeInformationParser: BeamerParser(), //비머한테 모든 로케이션을 맡긴다.
          routerDelegate: _routerDelegate //글로벌 변수로 설정
          ),
    );
  }
}
