import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Classes/HandlingDataController.dart';
import '../../../DB/statusRequest.dart';
import '../../Remote/fgPassword/resetPassword.dart';

class SuccsessReset_Controller extends GetxController {
  GlobalKey<FormState> myKeysu = GlobalKey<FormState>();

  String? email;


  login() async {
    Get.offNamed("/Login");
  }


  @override
  void onInit() {
    email=Get.arguments["users_email"];
    super.onInit();
  }
}
