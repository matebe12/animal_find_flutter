import 'package:findanimal/util/Global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FindRead extends StatefulWidget {
  const FindRead({Key key}) : super(key: key);

  @override
  _FindReadState createState() => _FindReadState();
}

class _FindReadState extends State<FindRead> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(Get.arguments);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('상세보기', style: TextStyle(fontSize: 15)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              Get.arguments['THUMB_IMAGE_COURS'],
              fit: BoxFit.fitWidth,
              width: MediaQuery.of(context).size.width,
            ),
            ListTile(
              title: Text('보호소', style: TextStyle(fontWeight: FontWeight.bold)),
              leading: Icon(
                Icons.place_outlined
              ),
              subtitle: Text(
                Get.arguments['PROTECT_PLC'],
                style: TextStyle(fontSize: 13),
              ),
            ),
            ListTile(
              title: Text('상태', style: TextStyle(fontWeight: FontWeight.bold)),
              leading: Icon(
                Icons.archive
              ),
              subtitle: Text(
                Get.arguments['STATE_NM'],
                style: TextStyle(fontSize: 13),
              ),
            ),
            ListTile(
              title: Text('종류', style: TextStyle(fontWeight: FontWeight.bold)),
              leading: Icon(Icons.apps),
              subtitle: Text(
                Get.arguments['SPECIES_NM'],
                style: TextStyle(fontSize: 13),
              ),
            ),
            ListTile(
              title:
                  Text('구분 색', style: TextStyle(fontWeight: FontWeight.bold)),
              leading:
                  Icon(Icons.color_lens_outlined),
              subtitle: Text(
                Get.arguments['COLOR_NM'],
                style: TextStyle(fontSize: 13),
              ),
            ),
            ListTile(
              title: Text('특징', style: TextStyle(fontWeight: FontWeight.bold)),
              leading: Icon(Icons.group_outlined),
              subtitle: Text(
                Get.arguments['SFETR_INFO'],
                style: TextStyle(fontSize: 13),
              ),
            ),
            ListTile(
              title: Text('성별', style: TextStyle(fontWeight: FontWeight.bold)),
              leading:
                  Icon(Icons.volunteer_activism),
              subtitle: Text(
                Get.arguments['PROTECT_PLC'],
                style: TextStyle(fontSize: 15),
              ),
            ),
            ListTile(
              title: Text('보호소 전화번호',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              leading: Icon(Icons.call),
              subtitle: Text(
                Get.arguments['SHTER_TELNO'],
                style: TextStyle(fontSize: 15),
              ),
            ), //${Get.arguments['PROTECT_PLC']}'),)
          ],
        ),
      ),
    );
  }
}
