import 'dart:collection';

import 'package:findanimal/component/searchform.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'view/FindScreen.dart';

void main() {
  runApp(LayoutBuilder(
    builder: (context, constraints) {
      return GetMaterialApp(
        home: Home(),
        getPages: [
          GetPage(name: '/find', page: () => FindScreen()),
          GetPage(name: '/search', page: () => SearchForm()),

        ],
        title: '경기도 유기동물',
      );
    },
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>
    with AutomaticKeepAliveClientMixin<Home>, TickerProviderStateMixin {
  List<Widget> _children = [
    FindScreen(),
    FindScreen(),
  ];
  int currentIndex = 0;
  AnimationController commonScrollController;
  // ScrollController commonScrollController = ScrollController();
  ListQueue<int> _navigationQueue = ListQueue();
  bool isShow = true;
  @override
  void initState() {
    super.initState();
    //commonScrollController = ScrollController();
    commonScrollController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void changeMenu(int index) {
    if (index != currentIndex) {
      _navigationQueue.removeWhere((element) => element == index);
      _navigationQueue.addLast(index);
      setState(() {
        currentIndex = index;
      });
      print(_navigationQueue);
    }
  }

  Future<bool> _onWillPop() async {
    //Navigator.of(context).pop();
    if (_navigationQueue.isEmpty) {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('확인'),
          content: Text('앱을 종료 하시겠습니까?'),
          actions: [
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text('네')),
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text('아니오')),
          ],
        ),
      );

      //return true;
    }
     setState(() {
      _navigationQueue.removeLast();
      int position = _navigationQueue.isEmpty ? 0 : _navigationQueue.last;
      currentIndex = position;
    });
    return false;

  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: IndexedStack(
        index: currentIndex,
        children: _children,
      ),
      bottomNavigationBar: Wrap(children: [
        WillPopScope(
          child: BottomNavigationBar(
            backgroundColor: Color(0xFF141d24),
            currentIndex: currentIndex,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            onTap: changeMenu,
            elevation: 5,
            iconSize: 40,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard_outlined), label: '홈'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_repair_service_outlined), label: 'A/S'),
            ],
          ),
          onWillPop: _onWillPop,
        ),
      ]),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
