import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../Core/Services/services.dart';
import '../../Data/DataSource/Static/static.dart';

abstract class OnBoardingController extends GetxController{

  next();
  onPageChanged(int index);
}
class OnBoardingControllerImp extends OnBoardingController{
  int CurrentPage=0;
  Myservices myservices = Get.find();
  late PageController pageController;
  @override
  next() {
    CurrentPage++;
    if (CurrentPage > onBoardingModelList.length-1) {
      myservices.sharedPref.setString("step", "1");//لاجل معرفة ان المستخدم قد دخل ونسجل ذلك كي لاتظهر شاشة الترحيب ثانية
      Get.offAllNamed("/Login");
    } else {
      pageController.animateToPage(
          CurrentPage, duration: Duration(milliseconds: 900),
          curve: Curves.easeInOut);
    }
  }

  @override
  onPageChanged(int index) {
    CurrentPage=index;
    update();
  }

  @override
  void onInit() {
    pageController = PageController();
    super.onInit();
  }

}