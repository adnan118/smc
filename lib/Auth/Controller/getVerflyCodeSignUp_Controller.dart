import 'package:flutter/material.dart';
 import 'package:get/get.dart';
import '../../DB/handlingData.dart';
import '../../DB/statusRequest.dart';
import '../Remote/vfcSignUpRemoteData.dart';

class GetVerflyCodeSignUp_Controller extends GetxController {
  VfcSignUpRemoteData vfcSignUpRemoteData = VfcSignUpRemoteData(Get.find());
  String email = Get.arguments["users_email"];
  StatusRequest statusRequest = StatusRequest.none;

  @override
  void onInit() {
    email = Get.arguments[
        "users_email"]; //يتم ستقبال الايميل القادم من صفحة التسجل الى صفحة التحقق
    super.onInit();
  }

  @override
  ReSendCode() {
    vfcSignUpRemoteData.resendData(email!);

    Get.snackbar("vfctitleDone".tr, "vfcbodyDone".tr);
  }

  @override
  succsessReset(String varfycode) async {
    //loading
    statusRequest = StatusRequest.loading;
    update();
    var response = await vfcSignUpRemoteData.postData(email!, varfycode);
    print("$response *****");
    //
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        Get.offAllNamed("/SuccsessSignUp");
      } else {
        Get.defaultDialog(
            title: "errortitleresendcode".tr,
            middleText: "errorbodyresendcode".tr);
        statusRequest = StatusRequest.failuer;
      }
    }
    update();
  }
}
