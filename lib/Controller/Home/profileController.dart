import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../Core/Services/services.dart';
import '../../DB/handlingData.dart';
import '../../DB/statusRequest.dart';
import '../../Data/DataSource/Remote/profileRemoteData.dart';
import '../../Data/Model/profileModel.dart';

class ViewProfileController extends GetxController {
  GlobalKey<FormState> myKeyEp = GlobalKey<FormState>();
  StatusRequest statusRequest = StatusRequest.none;
  ViewProfileRemoteData viewProfileRemoteData =
      ViewProfileRemoteData(Get.find());
  Myservices myservices = Get.find();
  ProfileModel? profileModel;

  List<ProfileModel> data = [];

  late TextEditingController fullname = TextEditingController();
  late TextEditingController username = TextEditingController();
  late TextEditingController email = TextEditingController();
  late TextEditingController phone = TextEditingController();
  late TextEditingController password = TextEditingController();
  late var users_image = "avatar5.jpg";
  late var users_role = "Known";

  var profile_OR_editprofile = "profile";

  goToEditProfile() {
    Get.offNamed("/EditProfile");
  }

  goToProfile() {
    Get.offNamed("/ViewProfile");
  }

  @override
  getDataProfile() async {
    //loading
    statusRequest = StatusRequest.loading;
    update();
    var response = await viewProfileRemoteData
        .getDataProfile(myservices.sharedPref.getInt("users_id").toString()!);
    print("$response *****");
    //
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        if (data == null) {
          Get.defaultDialog(
            title: "Loading".tr,
            middleText: "Please Waiting",
            content: CircularProgressIndicator(),
            onCancel: () {},
          );
        } else {
          ProfileModel profile = ProfileModel.fromJson(response["data"]);
          profileModel = ProfileModel.fromJson(response["data"]);
          data.add(profile);
          profile.usersRole = response["data"]["users_role"];
          print(profile.usersRole);
          fullname = TextEditingController(text: profile.usersFullName);
          username = TextEditingController(text: profile.usersName);
          email = TextEditingController(text: profile.usersEmail);
          phone = TextEditingController(text: profile.usersPhone);
          password = TextEditingController(text: profile.usersPassword);
          users_image = profile.usersImage!;
          getRole(profile);
        }
      } else {
        statusRequest = StatusRequest.failuer;
      }
    }
    update();
  }

  getRole(ProfileModel profileModel) {
    if (profileModel!.usersRole == 0) {
      users_role = "admin";
    } else if (profileModel!.usersRole == 1) {
      users_role = "Coach";
    } else if (profileModel!.usersRole == 2) {
      users_role = "Trainee";
    }
  }

  bool isShowPassword = true;
  IconData IconDataPassword = Icons.lock_outline;

  funShowPassword() {
    isShowPassword = isShowPassword == true ? false : true;
    IconDataPassword = IconDataPassword == Icons.lock_open
        ? Icons.lock_outline
        : Icons.lock_open;
    update();
  }

  ////////////////////edit profile
  XFile? xfile;
  File? myfile;

  chooesImg() async {
    update();
    xfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    myfile = File(xfile!.path);
    print(myfile);

    update();
  }

  @override
  setDataEditProfile() async {
    var formdata = myKeyEp.currentState;

    if (formdata!.validate()) {
      // Loading
      statusRequest = StatusRequest.loading;
      update();
      var response;
      if (myfile == null) {
        print("$response ****uuuuu$users_image*");
        response = await viewProfileRemoteData.getDataEditProfileWithoutFile(
          myservices.sharedPref.getInt("users_id").toString()!,
          fullname.text,
          email.text,
          phone.text,
          password.text,
          username.text,
          users_image,
        );
        statusRequest = StatusRequest.none;
        update();
      } else {
        response = await viewProfileRemoteData.getDataEditProfileWithFile(
          myservices.sharedPref.getInt("users_id").toString()!,
          fullname.text,
          email.text,
          phone.text,
          password.text,
          username.text,
          users_image,
          myfile,
        );
        update();
      }
      print("$response ***vvv**");
      print(myfile);

      // Check response type and handle accordingly
      if (response is Map) {
        statusRequest = handlingData(response);
      } else {
        statusRequest = StatusRequest.failuer;
      }

      Get.delete<ViewProfileController>();
      Get.put(ViewProfileController());
      Get.offAllNamed("/");
      profile_OR_editprofile = "profile";
      getDataProfile();
      update();
    }
  }

  @override
  updateCoachMemberShip() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await viewProfileRemoteData.updateCoachMemberShip(
      myservices.sharedPref.getInt("users_id").toString()!);
        statusRequest = handlingData(response);
        if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
      Get.offAllNamed("/RootPage");
      } else {
        statusRequest = StatusRequest.failuer;
      }
    }

    update();
  }

  @override
  void onInit() async {
    await getDataProfile();
    super.onInit();
  }
}
