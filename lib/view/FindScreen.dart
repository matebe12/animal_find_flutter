import 'package:findanimal/util/Search.dart';
import 'package:flui/flui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FindScreen extends StatefulWidget {
  @override
  _FindScreenState createState() => _FindScreenState();
}

class _FindScreenState extends State<FindScreen> {
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
        title: FLAppBarTitle(
          title: '경기도 유기견 검색',
          showLoading: true,
        ),
        elevation: 0.1,
        backgroundColor: Color(0xFF141d24),
        automaticallyImplyLeading: true,
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Text'),
          ),
          ListTile(
            title: Text('Text'),
          ),
          ListTile(
            title: Text('Text'),
          ),
        ],
      ),
    );
  }
}
