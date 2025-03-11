
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Classes/HandlingDataController.dart';
import '../../Core/Services/services.dart';
import '../../DB/CRUD.dart';
import '../../DB/statusRequest.dart';
import '../Remote/signUpRemoteData.dart';

class SignUp_Controller extends GetxController with CRUD {
  GlobalKey<FormState> myKeyS = GlobalKey<FormState>();

  StatusRequest statusRequest = StatusRequest.none;
  SignUpRemoteData signUpRemoteData = SignUpRemoteData(Get.find());

  Myservices myservices = Get.find();

  late TextEditingController username;
  late TextEditingController fullname;

  late TextEditingController email;
  late TextEditingController phone;
  late TextEditingController password;

  bool isShowPassword = true;
  IconData IconDataPassword = Icons.lock_outline;

  List data = [];

/////////////////////////////////////////////////////////////////////////////////////////////////////// fun funShowPassword
  funShowPassword() {
    isShowPassword = isShowPassword == true ? false : true;

    IconDataPassword = IconDataPassword == Icons.lock_open
        ? Icons.lock_outline
        : Icons.lock_open;
    update();
  }

  /////////////////////////////////////////////////////////////////////////////////////////////////////// fun login
  @override
  login() async {
    Get.offNamed("/Login");
  }

  /////////////////////////////////////////////////////////////////////////////////////////////////////// fun signup
  @override
  signUp() async {
    var formdata = myKeyS.currentState;
    if (formdata!.validate()) {
      //loading
      statusRequest = StatusRequest.loading;
      update();
      var response = await signUpRemoteData.postData(
          username.text, email.text, phone.text, password.text,fullname.text);
      print("$response *****");
      //
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          //      data.addAll(response['data']);
          print(email.text);
           Get.offNamed("/GetVerflyCodeSignUp",
              arguments: {"users_email": email.text});
        } else {
          Get.defaultDialog(
              title: "Error", middleText: "Email or Phone already exists ");
          statusRequest = StatusRequest.failuer;
        }
      }
      update();
      print("Data valid");
    } else {
      print("Data not valid");
    }
  }


  /////////////////////////////////////////////////////////////////////////////////////////////////////// fun Forgetpassword
  @override
  Forgetpassword() {
    Get.toNamed("/ForgetPassword");
  }

  @override
  void onInit() {
    /* FirebaseMessaging.instance.getToken().then((value) {
      String? token=value;
      print(value);
    });*/

    username = TextEditingController();
    fullname = TextEditingController();
    email = TextEditingController();
    phone = TextEditingController();
    password = TextEditingController();

    super.onInit();
  }
}
