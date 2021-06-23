import 'dart:collection';

import 'package:findanimal/component/searchform.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'view/FindScreen_GridView.dart';
import 'view/FindScreen_ListView.dart';

void main() {
  runApp(LayoutBuilder(
    builder: (context, constraints) {
      return GetMaterialApp(
        home: Home(),
        // getPages: [
        //   GetPage(name: '/find', page: () => FindScreen()),
        //   GetPage(name: '/search', page: () => SearchForm()),

        // ],
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
    with AutomaticKeepAliveClientMixin<Home> {
  List<Widget> _children = [
    FindScreenGridView(),
    FindScreenListView(),
  ];
  int currentIndex = 0;
  ListQueue<int> _navigationQueue = ListQueue();
  @override
  void initState() {
    super.initState();
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
            backgroundColor: Color(0xFF74a4f2),
            selectedLabelStyle: TextStyle(fontFamily: 'NanumPen'),
            unselectedLabelStyle: TextStyle(fontFamily: 'NanumPen'),
            currentIndex: currentIndex,
            selectedItemColor: Colors.white,
            unselectedItemColor: Color(0xff767e88),
            type: BottomNavigationBarType.fixed,
            onTap: changeMenu,
            elevation: 5,
            iconSize: 30,
            selectedFontSize: 18,
            unselectedFontSize: 18,
            items: [
              BottomNavigationBarItem(

                  icon: Icon(Icons.dashboard_outlined), label: '홈', ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.list_alt_outlined),label: '두번째 탭'),
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
