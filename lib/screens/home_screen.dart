import 'package:beamer/beamer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeroheatproject/screens/home/items_page.dart';
import 'package:zeroheatproject/states/user_provider.dart';
import 'package:zeroheatproject/widgets/expandable_fab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _bottomSelectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _bottomSelectedIndex,
        children: [
          ItemsPage(),
          Container(
            color: Colors.accents[1],
          ),
          Container(
            color: Colors.accents[2],
          ),
          Container(
            color: Colors.accents[3],
          ),
        ],
      ),
      floatingActionButton: ExpandableFab(
        distance: 90,
        children: [
          MaterialButton(
            onPressed: () {
              context.beamToNamed('/input');
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
          '덕소',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              // context.read<UserProvider>().setUserAuth(false);
            },
            icon: Icon(CupertinoIcons.nosign),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(CupertinoIcons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              CupertinoIcons.text_justify,
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomSelectedIndex,
        type: BottomNavigationBarType.fixed, //라벨 보이게 하는법
        items: [
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(_bottomSelectedIndex == 0
                    ? 'assets/imgs/selected_home_1.png'
                    : 'assets/imgs/home_1.png'),
              ),
              label: '홈'),
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(_bottomSelectedIndex == 1
                    ? 'assets/imgs/selected_placeholder.png'
                    : 'assets/imgs/placeholder.png'),
              ),
              label: '내 근처'),
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(_bottomSelectedIndex == 2
                    ? 'assets/imgs/selected_smartphone_10.png'
                    : 'assets/imgs/smartphone_10.png'),
              ),
              label: '채팅'),
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(_bottomSelectedIndex == 3
                    ? 'assets/imgs/selected_user_3.png'
                    : 'assets/imgs/user_3.png'),
              ),
              label: '내 정보'),
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
