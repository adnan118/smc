import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smc/Data/Model/muscleModel.dart';

import '../../Classes/HandlingDataController.dart';
import '../../Core/Services/services.dart';
import '../../DB/statusRequest.dart';
import '../../Data/DataSource/Remote/UpdateDayOfLevelRemoteData.dart';
import '../../Data/DataSource/Remote/muscleRemoteData.dart';
import '../../Data/DataSource/Remote/nutritionalNeedRemoteData.dart';
import '../../Data/Model/NutritionalNeedsModel.dart';
import '../Home/profileController.dart';
import 'levelsController.dart';

class DayOfLevelController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  Myservices myservices = Get.find();
  UpdateDayOfLevelRemoteData updateDayOfLevelRemoteData =
      UpdateDayOfLevelRemoteData(Get.find());
  NutritionalNeedRemoteData nutritionalNeedRemoteData =
      NutritionalNeedRemoteData(Get.find());

  MuscleRemoteData muscleRemoteData = MuscleRemoteData(Get.find());
  int dayNum = Get.arguments["dayNum"];
  int levelNum = Get.arguments["levelNum"];

  List<MuscleModel> dataM1 = [];
  List<MuscleModel> dataM2 = [];

  List<NutritionalNeedsModel> nutritionalNeeds = [];

  late MuscleModel muscleModel;
  late NutritionalNeedsModel nutritionalNeedsModel;

  String? usersName;
  int? usersWeight;
  int? usersHeight;
  int? carbMinTotal;
  int? carbMaxTotal;
  int? proteinMinTotal;
  int? proteinMaxTotal;
  int? fatMinTotal;
  int? fatMaxTotal;

  @override
  getDataNutritionalNeeds() async {
    update();
    var response = await nutritionalNeedRemoteData.getDataNutritionalNeed(
        myservices.sharedPref.getInt("users_id").toString()!);
    print("$response *****");
    //
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        if (nutritionalNeeds == null) {
          Get.defaultDialog(
            title: "Loading".tr,
            middleText: "Please Waiting",
            content: CircularProgressIndicator(),
            onCancel: () {},
          );
        } else {
          NutritionalNeedsModel nutritionalNeedsModel =
              NutritionalNeedsModel.fromJson(response["data"]);
          nutritionalNeeds.add(nutritionalNeedsModel);

          usersName = response["data"]["users_name"];
          usersWeight = response["data"]["users_weight"];
          usersHeight = response["data"]["users_height"];
          carbMinTotal = response["data"]["carb_min_total"];
          carbMaxTotal = response["data"]["carb_max_total"];
          proteinMinTotal = response["data"]["protein_min_total"];
          proteinMaxTotal = response["data"]["protein_max_total"];
          fatMinTotal = response["data"]["fat_min_total"];
          fatMaxTotal = response["data"]["fat_max_total"];
        }
      } else {
        statusRequest = StatusRequest.failuer;
      }
    }
    update();
  }

  getDay1L2() {
    dataM1.clear();
    dataM2.clear();
    ExMuscle1(1);
    ExMuscle2(5);
  }

  getDay2L2() {
    dataM1.clear();
    dataM2.clear();
    ExMuscle1(2);
    ExMuscle2(3);
  }

  getDay3L2() {
    dataM1.clear();
    dataM2.clear();
    ExMuscle1(4);
    ExMuscle2(8);
  }

  getDay4L2() {
    dataM1.clear();
    dataM2.clear();
    ExMuscle1(7);
    ExMuscle2(9);
  }

  ExMuscle1(dayNum) async {
    var response = await muscleRemoteData.getExMuscle(dayNum);
    statusRequest = StatusRequest.none;
    update();
    print(response);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List<dynamic> responseData = response['data'];
        responseData.forEach((element) {
          muscleModel = MuscleModel(
            trainingId: element['training_id'],
            trainingName: element['training_name'],
            trainingNameAr: element['training_name_ar'],
            trainingMuscle: element['training_muscle'],
            muscleId: element['muscle_id'],
            muscleName: element['muscle_name'],
            muscleNameAr: element['muscle_name_ar'],
            trainingRes: element['training_res'],
            trainingSet: element['training_set'],
          );
          dataM1.add(muscleModel);
        });
      }
    } else {
      print("error");
    }
    update();
  }

  unLoading() {
    statusRequest = StatusRequest.none;
  }

  ExMuscle2(dayNum) async {
    var response = await muscleRemoteData.getExMuscle(dayNum);
    statusRequest = StatusRequest.none;
    update();
    print(response);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List<dynamic> responseData = response['data'];
        responseData.forEach((element) {
          muscleModel = MuscleModel(
            trainingId: element['training_id'],
            trainingName: element['training_name'],
            trainingNameAr: element['training_name_ar'],
            trainingMuscle: element['training_muscle'],
            muscleId: element['muscle_id'],
            muscleName: element['muscle_name'],
            muscleNameAr: element['muscle_name_ar'],
            trainingRes: element['training_res'],
            trainingSet: element['training_set'],
          );
          dataM2.add(muscleModel);
        });
      }
    } else {
      print("error");
    }
    update();
  }

  init() {
    dayNum = Get.arguments["dayNum"];
    levelNum = Get.arguments["levelNum"];
    getDataNutritionalNeeds();
    if (dayNum == 1) {
      getDay1L2();
    } else if (dayNum == 2) {
      getDay2L2();
    } else if (dayNum == 4) {
      getDay3L2();
    } else if (dayNum == 5) {
      getDay4L2();
    }
  }

  @override
  void onInit() {
    init();
    super.onInit();
  }
}
