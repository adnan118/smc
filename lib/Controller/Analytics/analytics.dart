import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Classes/HandlingDataController.dart';
import '../../Core/Services/services.dart';
import '../../DB/statusRequest.dart';
import '../../Data/DataSource/Remote/AnalyticsRemoteData.dart';
import '../../Data/Model/modeModel.dart';

class AnalyticsController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TextEditingController heightController;

  late TextEditingController weightController;

  AnalyticsRemoteData analyticsRemoteData = AnalyticsRemoteData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  Myservices myservices = Get.find();

  ModeModel? modeModel;
  List<ModeModel> data = [];

  List<int> totalHours = [];
  List<int> totalMinutes = [];
  List<int> totalSeconds = [];

  getAM() async {//analytics mode
    statusRequest = StatusRequest.loading;
    totalHours.clear();
    totalSeconds.clear();
    weight.clear();
    update();
    var response = await analyticsRemoteData
        .getAnalyticsMode(myservices.sharedPref.getInt("users_id").toString()!);

    print("$response *****");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        var dataList = response["data"] as List<dynamic>;

        dataList.forEach((item) {
          var modeModel = ModeModel.fromJson(item);
          data.add(modeModel);

          // تحويل الوقت إلى عدد من الساعات والدقائق وحفظها في متغيرات
          List<String> timeParts = item["total_duration"].split(":");
          int hours = int.parse(timeParts[0]);
          int minutes = int.parse(timeParts[1]);
          int second = int.parse(timeParts[2]);

          totalHours.add(hours);
          totalMinutes.add(minutes);
          totalSeconds.add(second);
        });
        print("totalHours");
        print(totalHours);
        print("totalMinutes");
        print(totalMinutes);
        print("totalSeconds");
        print(totalSeconds);
      } else {
        statusRequest = StatusRequest.failuer;
      }
    }
    update();
  }

  //==================
  List<int> month = [];
  List<int> height = [];
  List<int> weight = [];

  getAWH() async {
    statusRequest = StatusRequest.loading;
    month.clear();
    height.clear();
    weight.clear();
    update();
    var response = await analyticsRemoteData
        .getAnalyticsWH(myservices.sharedPref.getInt("users_id").toString()!);

    print("$response *****");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List<dynamic> data = response['data'];
        data.forEach((item) {
          int numMonth = item['spotsWH_numMonth'];
          int heightValue = item['spotsWH_height'];
          int weightValue = item['spotsWH_weight'];

          month.add(numMonth);
          height.add(heightValue);
          weight.add(weightValue);
        });

        print(month);
        print(height);
        print(weight);
      }
    } else {
      statusRequest = StatusRequest.failuer;
    }

    update();
  }

  //==============
  @override
  inserAWH() async {
    var now = DateTime.now();
    statusRequest = StatusRequest.loading;
    update();
    var response = await analyticsRemoteData.setAnalyticsWH(
        myservices.sharedPref.getInt("users_id").toString()!,
        now.month.toString(),
        weightController.text,
        heightController.text);
    print("$response *****");
    //
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        getAM();
        getAWH();
      } else {
        statusRequest = StatusRequest.failuer;
      }
    }
    update();
    print("Data valid");
  }

  @override
  void onInit() async {
    heightController = TextEditingController();
    weightController = TextEditingController();
    await getAM();
    await getAWH();
    super.onInit();
  }
}
