import 'package:findanimal/util/Search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FindScreenGridView extends StatefulWidget {
  @override
  _FindScreenGridViewState createState() => _FindScreenGridViewState();
}

class _FindScreenGridViewState extends State<FindScreenGridView> {
  List<String> siList = [
    '수원시',
    '용인시',
    '성남시',
    '부천시',
    '화성시',
    '수원시',
    '안산시',
    '평택시',
    '안양시',
    '시흥시',
    '김포시',
    '광주시',
    '광명시',
    '군포시',
    '하남시',
    '오산시',
    '이천시',
    '안성시',
    '의왕시',
    '양평군',
    '여주시',
    '과천시',
    '고양시',
    '남양주시',
    '파주시',
    '의정부시',
    '양주시',
    '구리시',
    '포천시',
    '양평군',
    '동두천시',
    '가평군',
    '연천군',
    'tttt'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                icon: Icon(Icons.search_outlined),
                onPressed: () {
                  showSearch(context: context, delegate: Search(siList));
                })
          ],
          centerTitle: true,
          title: Text(
            '경기도 유기견 검색',
            style: TextStyle(fontFamily: 'NanumPen'),
          ),
          elevation: 0.1,
          backgroundColor: Color(0xFF74a4f2),
          automaticallyImplyLeading: true,
        ),
        body: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemCount: 20,
            itemBuilder: (BuildContext ctx, index) {
              return Card(elevation: 2, child: Center(child: Text('$index ')));
            }));
  }
}
