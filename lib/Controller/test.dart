import 'package:flutter/material.dart';
import 'package:get/get.dart';

class test extends GetxController {
  final RxInt x = 1.obs;
  RxBool isBtnPress = false.obs;

  btnPressed() {
    update();
    if (isBtnPress == false) {
      isBtnPress = true.obs;
    } else if (isBtnPress == true) {
      isBtnPress = false.obs;
    }
  }

  @override
  void onInit() {
    super.onInit();
  }
}
