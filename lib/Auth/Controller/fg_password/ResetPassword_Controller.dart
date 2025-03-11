import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Classes/HandlingDataController.dart';
import '../../../DB/statusRequest.dart';
import '../../Remote/fgPassword/resetPassword.dart';

class ResetPassword_Controller extends GetxController {
  GlobalKey<FormState> myKeyRs = GlobalKey<FormState>();
  ResetPasswordRemoteData resetPasswordRemoteData =
      ResetPasswordRemoteData(Get.find());

  late TextEditingController chKemail;
  late TextEditingController password;
  late TextEditingController repassword;
  String? email;
  bool isShowPassword1 = true;
  bool isShowPassword2 = true;
  IconData IconDataPassword1 = Icons.lock_outline;
  IconData IconDataPassword2 = Icons.lock_outline;

  StatusRequest statusRequest = StatusRequest.none;

  @override
  SuccsessResetPage() async {
    var formdata = myKeyRs.currentState;
    if (password.text != repassword.text) {
      return Get.defaultDialog(
          title: "warningPasswordandRePasswordMatch".tr, middleText: "PasswordandRePasswordMatch".tr);
    }
    if (formdata!.validate()) {
      //loading
      statusRequest = StatusRequest.loading;
      update();
      var response =
          await resetPasswordRemoteData.postData(email!, password.text);
      print("$response *****");
      //
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          Get.offAllNamed("/SuccsessReset",arguments: {"users_email": email});
          print("Data valid");
        } else {
          Get.defaultDialog(
              title: "warningPasswordandRePasswordMatch".tr, middleText: "sampassword".tr);
          statusRequest = StatusRequest.failuer;
        }
      }
      update();
    } else {
      print("Data not valid");
    }
  }

  login() async {
    Get.offNamed("/Login");
  }

  funShowPassword(int ShowPasswordnumfild) {
    if (ShowPasswordnumfild == 1) {
      isShowPassword1 = isShowPassword1 == true ? false : true;
      IconDataPassword1 = IconDataPassword1 == Icons.lock_open
          ? Icons.lock_outline
          : Icons.lock_open;
      update();
    }
    if (ShowPasswordnumfild == 2) {
      isShowPassword2 = isShowPassword2 == true ? false : true;
      IconDataPassword2 = IconDataPassword2 == Icons.lock_open
          ? Icons.lock_outline
          : Icons.lock_open;
      update();
    }

  }

  @override
  void onInit() {
    chKemail = TextEditingController();
    password = TextEditingController();
    repassword = TextEditingController();
    email=Get.arguments["users_email"];
    super.onInit();
  }
}
