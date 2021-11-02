import 'dart:collection';
import 'package:findanimal/view/FindRead.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'view/FindScreen_GridView.dart';
import 'view/Setting.dart';

void main() {
  runApp(LayoutBuilder(
    builder: (context, constraints) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
         getPages: [
        //   GetPage(name: '/find', page: () => FindScreen()),
        GetPage(name: '/readPage', page: () => FindRead()),
        ],
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
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
    {
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
  ///[changeMenu]  메뉴를 바꾼다. 인덱스와 현재 인덱스가 다를 경우에 큐에서 해당 인덱스를 지우고 마지막에 다시 추가한다. 
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
  ///[_onWillPop] 뒤로가기를 누를시에 나타나는 이벤트 종료 할 것인지 한번 확인을 한다. 큐가 비어있을 때는 확인창. 큐에 데이터들이 남아있다면 마지막 인덱스부터 지운다.
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
            currentIndex: currentIndex,
            type: BottomNavigationBarType.fixed,
            onTap: changeMenu,
            elevation: 5,
            iconSize: 30,
            selectedFontSize: 18,
            unselectedFontSize: 18,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard_outlined, size: 20,), label: '홈',),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings, size: 20,),label: '설정'),
            ],
          ),
          onWillPop: _onWillPop,
        ),
      ]),
    );
  }
}
