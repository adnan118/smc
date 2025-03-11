import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Classes/HandlingDataController.dart';
import '../../../DB/statusRequest.dart';
import '../../Remote/fgPassword/FPVfcRemoteData.dart';
class GetVerflyCodeFP_Controller extends GetxController {
  GlobalKey<FormState> myKeyVFCFP = GlobalKey<FormState>();

  FPVfcRemoteData fpVfcRemoteData = FPVfcRemoteData(Get.find());
  String ?email ;
  StatusRequest statusRequest = StatusRequest.none;

  @override
  void onInit() {
    email = Get.arguments[
        "users_email"]; //يتم ستقبال الايميل القادم من صفحة التسجل الى صفحة التحقق
    super.onInit();
  }

  @override
  ReSendCode() {
    fpVfcRemoteData.resendData(email!);

    Get.snackbar("vfctitleDone".tr, "vfcbodyDone".tr);
  }

  @override
  succsessReset(String varfycode) async {
    //loading
    statusRequest = StatusRequest.loading;
    update();
    var response = await fpVfcRemoteData.postData(email!, varfycode);
    print("$response *****");
    //
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        Get.offAllNamed("/ResetPassword",    arguments: {"users_email": email});
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
