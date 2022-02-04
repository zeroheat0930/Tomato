import 'package:flutter/material.dart';
import 'package:zeroheatproject/screens/start/address_page.dart';
import 'package:zeroheatproject/screens/start/auth_page.dart';
import 'package:zeroheatproject/screens/start/intro_page.dart';

class StartScreen extends StatelessWidget {
  StartScreen({Key? key}) : super(key: key);

  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
          // physics: NeverScrollableScrollPhysics(),
          //스크롤 스왑안되게 하는거
          controller: _pageController,
          children: [
            IntroPage(_pageController),
            AddressPage(),
            AuthPage(),
          ]),
    );
  }
}
