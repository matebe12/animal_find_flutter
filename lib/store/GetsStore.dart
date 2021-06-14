import 'package:get/get.dart';
import 'package:flutter/material.dart';

class TestController extends GetxController {
  var title1 = '경기도 유기동물 찾기';
  var name = '이상연';
  changeTitle(value) {
    title1 = value;
    update();
  }

  changeName(String text) {
    name = text;
    update();
  }
}

class TestRXController extends GetxController {
  var title1 = '경기도 유기동물 찾기'.obs;
}
