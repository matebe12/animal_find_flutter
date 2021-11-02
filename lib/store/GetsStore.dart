import 'package:get/get.dart';

class TestController extends GetxController {
  var title1 = '경기도 유기동물 찾기';
  var dogList = [];

  changeTitle(value) {
    title1 = value;
    update();
  }

  void setDogList(List value, bool gubun, String si) {
    if (gubun)
      dogList = value;
    else
      dogList.addAll(value);
    if (si.isNotEmpty)
      title1 = '경기도 유기동물 - $si';
    else
      title1 = '경기도 유기동물';
    update();
  }
}
