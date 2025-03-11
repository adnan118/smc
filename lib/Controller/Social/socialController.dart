import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Classes/HandlingDataController.dart';
import '../../Core/Constant/color.dart';
import '../../Core/Services/services.dart';
import '../../DB/statusRequest.dart';
import '../../Data/DataSource/Remote/SocialRemoteData.dart';
import '../../Data/Model/modeModel.dart';
import '../../Data/Model/socialModel.dart';

class SocialController extends GetxController {
  late TextEditingController shareUrl;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  SocialRemoteData socialRemoteData = SocialRemoteData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  Myservices myservices = Get.find();

  SocialModel? socialModel;
  List<SocialModel> data = [];
  List<bool> isLikedList = []; // قائمة لحفظ حالة الإعجاب لكل منشور

  String formatSocialRate(int rate) {
    if (rate >= 1000) {
      return '${(rate / 1000).toStringAsFixed(1)}k';
    }
    return rate.toString();
  }
  getSocialAll() async {
    data.clear();

    statusRequest = StatusRequest.loading;
    var response = await socialRemoteData.getSocialAll();
    print("$response *****");

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        var dataList = response["data"] as List;

        // تحويل البيانات إلى كائنات SocialModel
        data = dataList.map((item) => SocialModel.fromJson(item)).toList();
        isLikedList =
            List<bool>.filled(data.length, false); // تهيئة حالة الإعجاب
// استرجاع حالة الإعجاب من SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        for (int i = 0; i < data.length; i++) {
          isLikedList[i] = prefs.getBool('like_$i') ?? false;
        }
      } else {
        statusRequest = StatusRequest.failuer;
      }
    }

    update();
  }

  getSocialAllMy() async {
    data.clear();

    statusRequest = StatusRequest.loading;
    var response = await socialRemoteData.getSocialAllMy(
      myservices.sharedPref.getInt("users_id").toString()!,
    );
    print("$response *****");

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        var dataList = response["data"] as List;

        // تحويل البيانات إلى كائنات SocialModel
        data = dataList.map((item) => SocialModel.fromJson(item)).toList();
        isLikedList =
            List<bool>.filled(data.length, false); // تهيئة حالة الإعجاب
// استرجاع حالة الإعجاب من SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        for (int i = 0; i < data.length; i++) {
          isLikedList[i] = prefs.getBool('like_$i') ?? false;
        }
      } else {
        statusRequest = StatusRequest.failuer;
      }
    }

    update();
  }

  shareMySocial(url) async {
    data.clear();
    statusRequest = StatusRequest.loading;
    update();

    var response = await socialRemoteData.shareMySocial(
        myservices.sharedPref.getInt("users_id").toString()!, shareUrl.text);
    print("$response *****");

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        getSocialAll();
        shareUrl.clear();
        update();
      } else {
        statusRequest = StatusRequest.failuer;
      }
    }

    update();
  }

  deleteMySocial(index) async {
    Get.defaultDialog(
        title: "Alert".tr,
        middleText: "Areyousurefromdelete".tr,
        titleStyle: TextStyle(fontSize: 22),
        actions: [
          ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(ColorApp.darkRed),
              ),
              onPressed: () async {
                Get.back();
                statusRequest = StatusRequest.loading;
                update();

                var response = await socialRemoteData.deleteSocial(
                    myservices.sharedPref.getInt("users_id").toString()!,
                    data[index].socialId);
                print("$response *****");

                getSocialAll();
              },
              child: Text(
                "btnConfirm".tr,
                style: TextStyle(fontSize: 12),
              )),
          SizedBox(
            width: 30,
          ),
          ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(ColorApp.lightRed),
              ),
              onPressed: () {
                Get.back();
              },
              child: Text(
                "btnCancel".tr,
                style: TextStyle(fontSize: 12),
              )),
        ],   );

    update();
  }

  // دالة لتحديث socialRate عند التفاعل مع زر الإعجاب
  void updateSocialRate(int index, bool isLiked) async {
    if (isLiked) {
      data[index].socialRate = (data[index].socialRate ?? 0) + 1;
    } else {
      data[index].socialRate = (data[index].socialRate ?? 0) - 1;
    }
    isLikedList[index] = isLiked;
    print(data[index].socialRate);
    print(data[index].socialId);
    var response = await socialRemoteData.setSocialAllReaction(
        data[index].socialId, data[index].socialRate);
    print("$response ********");
    update();
  }




  submitRatingfromcontroller(int social_id ,String comment)async{
    //data.clear();
    //loading
    statusRequest = StatusRequest.loading;
    update();
    var response = await socialRemoteData.RatingratingReport(
      myservices.sharedPref.getInt("users_id").toString()!,
      social_id.toString(),
        comment.toString(),

    );
    print("$response *****");
    //
    statusRequest =handlingData(response);
    if(StatusRequest.success==statusRequest){
      if(response['status']=="success"){
        print("success ratingReport........");
        Get.snackbar("ratingReportTitle".tr, "ratingReportBody".tr);
      }else{
        Get.snackbar("ratingReportTitle".tr, "ratingReportBody".tr);
        //     statusRequest = StatusRequest.failuer;
      }
    }
    update();
  }





  @override
  void onInit() async {
    shareUrl = TextEditingController();
    await getSocialAll();
    super.onInit();
  }

  // getter لإرجاع قائمة الروابط القادمة من الاستعلام فقط
  List<String> get urls {
    return data.map((item) => item.socialUrl!).toList();
  }
}
