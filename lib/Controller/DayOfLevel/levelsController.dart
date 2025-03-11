import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:smc/Core/Constant/color.dart';

import '../../Classes/HandlingDataController.dart';
import '../../Core/Services/services.dart';
import '../../DB/statusRequest.dart';
import '../../Data/DataSource/Remote/UpdateDayOfLevelRemoteData.dart';
import '../Home/profileController.dart';
import 'dayOfLevelController.dart';

class LevelsController extends GetxController {
  ViewProfileController viewProfileController =
      Get.put(ViewProfileController());

  StatusRequest statusRequest = StatusRequest.none;
  Myservices myservices = Get.find();

  goToDay(DayNum, LevelNum) {
    viewProfileController.getDataProfile();
    DayNum == 3 || DayNum == 6 || DayNum == 7
        ? Get.toNamed("/B_dayOffOfLevel", arguments: {
            "dayNum": DayNum,
            "levelNum": LevelNum,
          })
        : Get.toNamed("/B_dayOfLevel", arguments: {
            "dayNum": DayNum,
            "levelNum": LevelNum,
          });
  }

  var day = 1;
  nextNumDay(){

    return      day = viewProfileController.data[0]!.usersDaylevel! == 7
        ? viewProfileController.data[0]!.usersDaylevel! - 6
        : viewProfileController.data[0]!.usersDaylevel! + 1;

  }
  UpdateDayOfLevelRemoteData updateDayOfLevelRemoteData =
      UpdateDayOfLevelRemoteData(Get.find());

  nextDay() async {
    statusRequest = StatusRequest.loading;

    update();

    day = viewProfileController.data[0]!.usersDaylevel! == 7
        ? viewProfileController.data[0]!.usersDaylevel! - 6
        : viewProfileController.data[0]!.usersDaylevel! + 1;
    Get.defaultDialog(
        title: "Loading".tr,
        middleText: "Please Waiting",
        content: NeumorphicProgressIndeterminate(
          style: ProgressStyle(
              accent: ColorApp.darkRed, variant: ColorApp.middleRed),
        ));
    var response = await updateDayOfLevelRemoteData.updateDayOfLevel(
        myservices.sharedPref.getInt("users_id").toString()!, day);

    print("$response **************");
    print("Day before success");
    print(viewProfileController.data[0]!.usersDaylevel!);

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        viewProfileController.data[0]!.usersDaylevel = day ;
        update();
        await Get.delete<LevelsController>();
        await Get.put(LevelsController());
        print("Day after success");
        print(day);
        Get.back(); // إغلاق الـ defaultDialog
        update();
      }
    }
    nextNumDay();
    update();
  }

preNumDay(){

    return  day = viewProfileController.data[0]!.usersDaylevel! == 1
        ? viewProfileController.data[0]!.usersDaylevel! + 6
        : viewProfileController.data[0]!.usersDaylevel! - 1;

}

  preDay() async {
    statusRequest = StatusRequest.loading;

    update();

    day = viewProfileController.data[0]!.usersDaylevel! == 1
        ? viewProfileController.data[0]!.usersDaylevel! + 6
        : viewProfileController.data[0]!.usersDaylevel! - 1;
    Get.defaultDialog(
        title: "Loading".tr,
        middleText: "Please Waiting",
        content: NeumorphicProgressIndeterminate(
          style: ProgressStyle(
              accent: ColorApp.darkRed, variant: ColorApp.middleRed),
        ));
    var response = await updateDayOfLevelRemoteData.updateDayOfLevel(
        myservices.sharedPref.getInt("users_id").toString()!, day);

    print("$response **************");
    print("Day before success");
    print(viewProfileController.data[0]!.usersDaylevel!);

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        viewProfileController.data[0]!.usersDaylevel = day ;
        update();
        await Get.delete<LevelsController>();
        await Get.put(LevelsController());
        print("Day after success");
        print(day);
        Get.back(); // إغلاق الـ defaultDialog
        update();
      }
    }
    preNumDay();
    update();
  }
  @override
  void onInit() {
    super.onInit();
  }
}
