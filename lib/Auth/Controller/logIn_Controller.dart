import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Core/Services/services.dart';
import '../../DB/handlingData.dart';
import '../../DB/statusRequest.dart';
import '../../LinksConnect/LinksAPI.dart';
import '../Remote/loginRemoteData.dart';

class LogIn_Controller extends GetxController {
  GlobalKey<FormState> myKeyL = GlobalKey<FormState>();

  LoginRemoteData loginRemoteData = LoginRemoteData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  Myservices myservices = Get.find();
  late TextEditingController email;
  late TextEditingController password;
  bool isShowPassword = true;
  IconData IconDataPassword = Icons.lock_outline;

  funShowPassword() {
    isShowPassword = isShowPassword == true ? false : true;
    IconDataPassword = IconDataPassword == Icons.lock_open
        ? Icons.lock_outline
        : Icons.lock_open;
    update();
  }

  login() async {
    var formdata = myKeyL.currentState;
    if (formdata!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await loginRemoteData.postData(email.text, password.text);
      print("$response *****");


      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response is Map && response['status'] == "success") {
          if (response["data"]["users_approve"] == 1) {
            //هذا الشرط اذا لم يدخل كود التحقق وخرج من التطبيق فيعود به الى صفحة التحقق
            myservices.sharedPref
                .setInt("users_id", response['data']["users_id"]);
            myservices.sharedPref
                .setString("users_name", response['data']["users_name"]);
            myservices.sharedPref
                .setString("users_email", response['data']["users_email"]);
            myservices.sharedPref
                .setString("users_phone", response['data']["users_phone"]);
            myservices.sharedPref.setString("step", "2"); //لاجل حفظ صفحة اللغات

            // اشعار للكل
            FirebaseMessaging.instance.subscribeToTopic("users");
            // اشعار لمستخدم معين
            String userId =                myservices.sharedPref.getInt("users_id").toString()!;
            FirebaseMessaging.instance.subscribeToTopic("users$userId");
            print("users$userId");

            Get.offNamed("/RootPage");
          } else {
            Get.offNamed("/GetVerflyCodeSignUp",
                arguments: {"users_email": email.text});
          }
        } else {
          Get.defaultDialog(
              title: "Error", middleText: "Email or Password is Wrong ... ");
          statusRequest = StatusRequest.failuer;
        }
      }
      update();
      //////
      print("Data valid");
    } else {
      print("Data not valid");
    }
  }

  @override
  signUp() {
    Get.toNamed("/SignUp");
  }

  @override
  Forgetpassword() {
    Get.toNamed("/ForgetPassword", arguments: {"users_email": email.text});
  }

  @override
  void onInit() {
    FirebaseMessaging.instance.getToken().then((value) {
      String? token=value;
      print(value);
    });

    email = TextEditingController();
    password = TextEditingController();

    super.onInit();
  }
}
