import 'package:findanimal/util/Global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FindRead extends StatefulWidget {
  const FindRead({ Key key }) : super(key: key);

  @override
  _FindReadState createState() => _FindReadState();
}

class _FindReadState extends State<FindRead> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('상세보기',style: TextStyle(fontFamily: Global.globalFont)),backgroundColor: Global.globalColor,),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(Get.arguments['THUMB_IMAGE_COURS'],fit: BoxFit.fitWidth,width: MediaQuery.of(context).size.width,),
              ListTile(title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Row(
                  children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.place_outlined,color: Global.globalColor,),
                  ),
                  Text('보호소',style: TextStyle(fontWeight: FontWeight.bold))
                ],),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(Get.arguments['PROTECT_PLC'], style: TextStyle(fontSize: 11),),
                ),
                Row(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.apps,color: Global.globalColor),
                  ),
                  Text('종류',style: TextStyle(fontWeight: FontWeight.bold))
                ],),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(Get.arguments['SPECIES_NM'], style: TextStyle(fontSize: 13),),
                ),
                Row(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.color_lens_outlined,color: Global.globalColor),
                  ),
                  Text('구분 색',style: TextStyle(fontWeight: FontWeight.bold))
                ],),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(Get.arguments['COLOR_NM'], style: TextStyle(fontSize: 13),),
                ),
                Row(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.group_outlined,color: Global.globalColor),
                  ),
                  Text('특징',style: TextStyle(fontWeight: FontWeight.bold))
                ],),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(Get.arguments['SFETR_INFO'], style: TextStyle(fontSize: 13),),
                ),
                Row(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.volunteer_activism,color: Global.globalColor),
                  ),
                  Text('성별',style: TextStyle(fontWeight: FontWeight.bold))
                ],),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(Get.arguments['SHTER_TELNO'], style: TextStyle(fontSize: 13),),
                ),
                Row(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.call,color: Global.globalColor),
                  ),
                  Text('보호소 전화번호',style: TextStyle(fontWeight: FontWeight.bold))
                ],),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(Get.arguments['SHTER_TELNO'], style: TextStyle(fontSize: 13),),
                ),
              ],))   //${Get.arguments['PROTECT_PLC']}'),)
            ],
          ),
        ),
    );
  }
}