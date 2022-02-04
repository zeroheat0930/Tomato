import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:zeroheatproject/router/locations.dart';
import 'package:zeroheatproject/screens/start_screen.dart';
import 'package:zeroheatproject/screens/splash_screen.dart';
import 'package:zeroheatproject/utils/logger.dart';

final _routerDelegate = BeamerDelegate(guards: [
  BeamGuard(
      pathPatterns: ['/'],
      check: (context, location) {
        return false; //로그인이 안되있다. false , 로그인이 되있다. true
      },
      showPage: BeamPage(child: StartScreen()))
], locationBuilder: BeamerLocationBuilder(beamLocations: [HomeLocation()]));

void main() {
  logger.d('my first log by logger!');
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
    return MaterialApp.router(
        theme: ThemeData(
          primarySwatch: Colors.red,
          fontFamily: 'DoHyeon',
          hintColor: Colors.grey[350],
          textTheme: TextTheme(
            button: TextStyle(color: Colors.white),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              backgroundColor: Colors.red,
              primary: Colors.white,
              minimumSize: Size(48, 48),
            ),
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            titleTextStyle: TextStyle(color: Colors.black87),
            elevation: 2,
          ),
        ),
        routeInformationParser: BeamerParser(), //비머한테 모든 로케이션을 맡긴다.
        routerDelegate: _routerDelegate //글로벌 변수로 설정
        );
  }
}
