import 'package:beamer/src/beamer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeroheatproject/data/user_model.dart';
import 'package:zeroheatproject/router/locations.dart';
import 'package:zeroheatproject/screens/chat/chat_list_page.dart';
import 'package:zeroheatproject/screens/home/items_page.dart';
import 'package:zeroheatproject/screens/home/map_page.dart';
import 'package:zeroheatproject/states/user_notifier.dart';
import 'package:zeroheatproject/widgets/expandable_fab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _bottomSelectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    UserModel? userModel = context.read<UserNotifier>().userModel;
    return Scaffold(
      body: (userModel == null)
          ? Container()
          : IndexedStack(
              index: _bottomSelectedIndex,
              children: [
                ItemsPage(userKey: userModel.userKey),
                MapPage(userModel),
                ChatListPage(userKey: userModel.userKey),
                Container(
                  color: Colors.accents[9],
                )
              ],
            ),
      floatingActionButton: ExpandableFab(
        distance: 90,
        children: [
          MaterialButton(
            onPressed: () {
              context.beamToNamed('/$LOCATION_INPUT');
            },
            shape: CircleBorder(),
            height: 40,
            color: Theme.of(context).colorScheme.primary,
            child: Icon(Icons.add),
          ),
          MaterialButton(
            onPressed: () {},
            shape: CircleBorder(),
            height: 40,
            color: Theme.of(context).colorScheme.primary,
            child: Icon(Icons.add),
          ),
        ],
      ),
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          '정왕동',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                context.beamToNamed("/");
              },
              icon: Icon(CupertinoIcons.nosign)),
          IconButton(
              onPressed: () {
                context.beamToNamed('/$LOCATION_SEARCH');
              },
              icon: Icon(CupertinoIcons.search)),
          IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.text_justify)),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomSelectedIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(_bottomSelectedIndex == 0
                  ? 'assets/imgs/selected_home_1.png'
                  : 'assets/imgs/home_1.png')),
              label: '홈'),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(_bottomSelectedIndex == 1
                  ? 'assets/imgs/selected_placeholder.png'
                  : 'assets/imgs/placeholder.png')),
              label: '내 근처'),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(_bottomSelectedIndex == 2
                  ? 'assets/imgs/selected_smartphone_10.png'
                  : 'assets/imgs/smartphone_10.png')),
              label: '채팅'),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(_bottomSelectedIndex == 3
                  ? 'assets/imgs/selected_user_3.png'
                  : 'assets/imgs/user_3.png')),
              label: '내정보'),
        ],
        onTap: (index) {
          setState(() {
            _bottomSelectedIndex = index;
          });
        },
      ),
    );
  }
}
