import 'package:dio/dio.dart';
import 'package:findanimal/util/Global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
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
  var logger = Logger();

  ///[initState] init단계에서는 전체 검색
  @override
  void initState() {
    super.initState();
    setDogList(pIndex, true, '');
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        if (pIndex <= totalIndex) {
          setDogList(pIndex, false, currentSi);
        }
      }
    });
  }
  ///[setDogList] 유기견 검색
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
        controller.setDogList(row, gubun, si);
        setState(() {
          totalIndex =
              (body['AbdmAnimalProtect'][0]['head'][0]['list_total_count'] / 10)
                  .floor();
          pIndex = pIndex + 1;
        });
        print(pIndex);
        logger.i(pIndex);
        logger.d(pIndex);
        logger.e(pIndex);
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

  ///[setTopPosition] 검색이나 플루팅 버튼 클릭시 트랜지션으로 top 이동
  void setTopPosition() {
    scrollController.animateTo(0.0,
        duration: Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TestController>(
        builder: (_) => Scaffold(
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
                            items: Global.siList,
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
                 style: TextStyle(fontSize: 13),
              ),
              elevation: 0.1,
              automaticallyImplyLeading: true,
            ),
            body: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 0.95,
                            mainAxisSpacing: 10),
                        itemCount: controller.dogList.length,
                        controller: scrollController,
                        itemBuilder: (BuildContext ctx, index) {
                          return InkWell(
                              onTap: () {
                                Get.toNamed('/readPage',
                                    arguments: controller.dogList[index]);
                              },
                              child: GridTile(
                                  footer: Column(
                                    children: [
                                      Text(
                                          '${controller.dogList[index]['SIGUN_NM']}', ),
                                      Text(
                                          '${controller.dogList[index]['SPECIES_NM']}'),
                                    ],
                                  ),
                                  child: Column(children: [
                                    Image.network(
                                      controller.dogList[index]
                                          ['THUMB_IMAGE_COURS'],
                                      height: 150,
                                      width: 150,
                                      cacheWidth: 100,
                                      cacheHeight: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ])));
                        }),
                  ),
                ),
              ],
            )));
  }
}
