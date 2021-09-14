import 'package:dio/dio.dart';
import 'package:findanimal/util/Search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:search_page/search_page.dart';
import 'dart:convert';

import '../store/GetsStore.dart';

class FindScreenGridView extends StatefulWidget {
  @override
  _FindScreenGridViewState createState() => _FindScreenGridViewState();
}

class _FindScreenGridViewState extends State<FindScreenGridView> {
  final controller = Get.put(TestController());
  ScrollController scrollController;
  int pIndex = 1;
  int totalIndex = 0;
  String currentSi = '';
  List<String> siList = [
    '수원시',
    '용인시',
    '성남시',
    '부천시',
    '화성시',
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
    '전체'
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setDogList(pIndex, true, '');
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        if (pIndex <= totalIndex) {
          print('dfd $pIndex');
          print('dfd $currentSi');
          setDogList(pIndex, false, currentSi);
        }
      }
    });
  }

  void setDogList(int index, bool gubun, String si) async {
    try {
      if (si == '전체') si = '';
      var response = await Dio().get(
          'https://openapi.gg.go.kr/AbdmAnimalProtect?KEY=3d1064943f38403f857c7b59079e5934&Type=json&pSize=10&pIndex=$index&SIGUN_NM=$si&STATE_NM=&PBLANC_BEGIN_DE=&PBLANC_END_DE=&SPECIES_NM=&SHTER_NM=');
      var body = json.decode(response.data);
      var code = body['AbdmAnimalProtect'][0]['head'][1]['RESULT']['CODE'];
      List row = body['AbdmAnimalProtect'][1]['row'];
      if (code == 'INFO-000') {
        print(row);
        controller.setDogList(row, gubun,si);
        setState(() {
          totalIndex =
              (body['AbdmAnimalProtect'][0]['head'][0]['list_total_count'] / 10)
                  .floor();
          pIndex = pIndex + 1;
        });
        print(pIndex);
      }
    } catch (e) {
      Get.showSnackbar(GetBar(
        title: '데이터를 가져오지 못했습니다.',
        message: '$e',
        duration: Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
      ));
    }
  }

  void setTopPosition() {
    scrollController.animateTo(0.0,
        duration: Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TestController>(
        builder: (_) => 
        Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                scrollController.animateTo(0.0,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeOut);
              },
              child: Icon(Icons.arrow_circle_up_outlined),
            ),
            appBar: AppBar(
              actions: [
                IconButton(
                    icon: Icon(Icons.refresh_outlined),
                    onPressed: () {
                      setTopPosition();
                    }),
                IconButton(
                    icon: Icon(Icons.search_outlined),
                    onPressed: () {
                      showSearch<String>(
                          context: context,
                          delegate: SearchPage(
                            items: siList,
                            searchLabel: '지역',
                            suggestion: Center(
                              child: Text('지역을 검색해주세요.'),
                            ),
                            failure: Center(
                              child: Text('해당 지역은 없습니다.'),
                            ),
                            filter: (si) => [si],
                            builder: (si) => ListTile(
                              onTap: () async {
                                try {
                                  setDogList(1, true, si);
                                  setState(() {
                                    currentSi = si;
                                  });
                                } catch (e) {} finally {
                                  Get.back();
                                  setTopPosition();
                                }
                                //print(_.dogList);
                              },
                              title: Text(si),
                              subtitle: Text(si),
                            ),
                          ));
                      //showSearch(context: context, delegate: Search(siList));
                    })
              ],
              centerTitle: true,
              title: Text(
                controller.title1,
                style: TextStyle(fontFamily: 'NanumPen'),
              ),
              elevation: 0.1,
              backgroundColor: Color(0xFF74a4f2),
              automaticallyImplyLeading: true,
            ),
            body: Column(
              children: [
                Expanded(

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 3 / 3,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),
                        itemCount: controller.dogList.length,
                        controller: scrollController,
                        itemBuilder: (BuildContext ctx, index) {
                          return GridTile(
                            
                            footer: Text('${controller.dogList[index]['PROTECT_PLC']}'),
                              child: Column(children: [
                            Image.network(
                              controller.dogList[index]['THUMB_IMAGE_COURS'],
                              height: 100,
                              width: 100,
                              cacheWidth: 100,
                              cacheHeight: 100,
                              fit: BoxFit.cover,
                            ),
                          ]));
                        }),
                  ),
                ),
              ],
            )));
  }
}
