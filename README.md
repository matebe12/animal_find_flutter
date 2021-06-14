# findanimal

<h3> 플러터 경기도 유기견 찾기 </h3>
<hr>
<strong>스터디 주별 목표 </strong>
<br><br>
<ul style="list-style:none;">
  <ol><strong>1주 </strong>기본 화면 구축 및 시 별 검색</ol>
  <ol><strong>2주 </strong>검색 결과 및 상세 보기</ol>
  <ol><strong>3주 </strong>카카오 or 구글 맵 이용 위치 찾기</ol>
</ul>


### LayoutBuilder로 기기 크기에 맞춰준다. getx를 사용하기 때문에 getmaterialApp으로 감싸준다
  
<pre>
<code>
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

</code>
</pre>
  
 ## bottomnavigator 구축
<pre>
<code>
List<Widget> _children = [
    FindScreen(),
    FindScreen(),
  ];
  int currentIndex = 0;
  ListQueue<int> _navigationQueue = ListQueue();

</code>
</pre>


## 메뉴 클릭 시 큐에 쌓는다 인덱스 같다면 쌓지않는다
<pre>
<code>


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
  //뒤로가기 누를시 전의 메뉴로 이동하고 큐를 지운다 큐가 비어졌다면 종료 알림응 보여준다
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
</code>
</pre>


## 다른 메뉴 이동시에 전 메뉴의 화면 상태 보존을 위해 indexedStack을 사용한다 

<pre>
<code>

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
</code>
</pre>

