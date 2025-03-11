import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Classes/HandlingDataController.dart';
import '../../../DB/statusRequest.dart';
import '../../Remote/fgPassword/checkEmail.dart';

  class FP_Controller extends GetxController {

  GlobalKey<FormState> myKeyF = GlobalKey<FormState>();
  String emailfromlogin=Get.arguments["users_email"];

  CheckEmailRemoteData checkEmailRemoteData = CheckEmailRemoteData(Get.find());

  late TextEditingController chKemail ;
  late TextEditingController chKphone;
  late StatusRequest  statusRequest=StatusRequest.none;

  @override
  checkEmail() async {
    if (myKeyF.currentState!.validate()) {
      //loading
      statusRequest = StatusRequest.loading;
      update();
      var response = await checkEmailRemoteData.postData(
          chKemail.text);
      print("$response *****");
      //
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          Get.offAllNamed(
              "/GetVerflyCodeFP", arguments: {"users_email": chKemail.text});
        } else {
          Get.defaultDialog(
              title: "Error",
              middleText: "Email Not Found ... "
          );
          statusRequest = StatusRequest.failuer;
        }
      }
      update();
    }
  }


  @override
  void onInit() {
    chKemail = TextEditingController(text:emailfromlogin==""? "":emailfromlogin );
    chKphone = TextEditingController();
    emailfromlogin = Get.arguments[
    "users_email"]; //يتم ستقبال الايميل القادم من صفحة التسجل الى صفحة التحقق
    super.onInit();
  }
}
