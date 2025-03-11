import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smc/Controller/Home/profileController.dart';

import '../../Classes/HandlingDataController.dart';
import '../../Core/Localization/changelocal.dart';
import '../../Core/Services/services.dart';
import '../../DB/statusRequest.dart';
import '../../Data/DataSource/Remote/SocialRemoteData.dart';
import '../../Data/Model/socialBSModel.dart';
import '../../Screen/AdminTools/Coaches.dart';
import '../../Screen/AdminTools/mainToolAdmin.dart';
import '../../Screen/AdminTools/societySMC.dart';
import '../../Screen/AdminTools/storeManage.dart';
import '../../Screen/AdminTools/unPaidSubscription.dart';
import '../../Screen/Analytics/analytics.dart';
import '../../Screen/B_DayOfLevel/levels.dart';
import '../../Screen/Basic/basicScreen.dart';
import '../../Screen/Store/store.dart';

class BasicScreenController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  Myservices myservices = Get.find();
  int x = 1;
  LocalController localController = Get.find();

  String Codelanguage = Get.deviceLocale!.languageCode;
  bool isBtnPress = false;
  double perStep = 1;
  double perCaloriy =1;
  double perWater = 0.5;

  bool selectCourse = false;
  var iconListA =  [
    "assets/images/taskmanager.png",
    "assets/images/coach.png",

    "assets/images/SocietySMC.png",
    "assets/images/store.png",
  ];
  final pagesListA = [
    MainToolAdmin(),
    Coaches(),
    SocietySMC(),
    StoreManage(),
  ];
  final titlePagesListA = [
    "TaskManager".tr,
    "Coach".tr,
    "societySMC".tr,
    "Store".tr,
  ];

  ////////////////////////////////////////////////////////////////////
  var iconList =  [
    "assets/images/homepage.png",
    "assets/images/badge.png",
    "assets/images/analys.png",
    "assets/images/product.png",
  ];

  final pagesList = [
    BasicScreen(),
    Levels(),
    Analytics(),
    Store(),
  ];
  final titlePagesList = [
    "BasicScreen".tr,
    "Levels".tr,
    "Analytics".tr,
    "Store".tr,
  ];
  var bottomNavIndex = 0;

  @override
  changPage(int page) {
    bottomNavIndex = page;
    update();
  }

  rf() {
    update();
  }

  btnPressed() {
    update();
    if (isBtnPress == false) {
      isBtnPress = true;
    } else if (isBtnPress == true) {
      isBtnPress = false;
    }
  }

  changeLan() {
    Codelanguage = myservices.sharedPref.getString("myLang")!;
    localController.changeLanguage(Codelanguage == "ar" ? "en" : "ar");
    Codelanguage = Codelanguage == "ar" ? "en" : "ar";
    print(Codelanguage);
  }

//*****************************************
  SocialRemoteData socialRemoteData = SocialRemoteData(Get.find());
  List<SocialBSModel> dataBS = [];
  SocialBSModel? socialBSModel;

  late TextEditingController socialBS_url = TextEditingController();
  late TextEditingController socialBS_title = TextEditingController();
  late TextEditingController socialBS_title_ar = TextEditingController();

  late var socialBS_img = "smartLogo.png";
  late var socialBS_id = 1;
  final socialBS_date = DateTime.now();

  getSocialAllMy() async {
    dataBS.clear();
    statusRequest = StatusRequest.loading;

    var response = await socialRemoteData.getSocialAllBS();
    print("$response *****");
    update();
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        var dataList = response["data"] as List;
        // Map the list to dataBS
        dataBS = dataList.map((item) => SocialBSModel.fromJson(item)).toList();
         if (dataList.isNotEmpty) {
          socialBSModel = SocialBSModel.fromJson(dataList[0]);
          socialBS_img=socialBSModel!.socialBSImg!;
        }

      } else {
        statusRequest = StatusRequest.failuer;
      }
    }

    update();
  }


  GlobalKey<FormState> myKeyEp = GlobalKey<FormState>();
  GlobalKey<FormState> myKeyEpAdmin = GlobalKey<FormState>();

  XFile? xfile;
  File? myfile;
  chooesImg() async {
    update();
    // Pick an image from the gallery
    xfile = await ImagePicker().pickImage(source: ImageSource.gallery);

    // Check if xfile is null before proceeding
    if (xfile != null) {
      myfile = File(xfile!.path); // No need for null check here since xfile is not null
      print(myfile);
      update();
    } else {
      print("No image selected."); // Handle the case where no image was selected
    }

    update();
  }
  @override
  setSocialAllMy(socialBS_id) async {
    dataBS.clear();
    var formdata = myKeyEpAdmin.currentState;

    if (formdata!.validate()) {
      // Loading
      statusRequest = StatusRequest.loading;
      update();
      var response;
      if (myfile == null) {
        var response = await socialRemoteData.setSocialAllBS(
            socialBS_id.toString(),
            socialBS_img,
            socialBS_url.text,
            socialBS_date.toString(),
            socialBS_title.text,
            socialBS_title_ar.text
        );

        print("$response ****uuuuu*");
        statusRequest = StatusRequest.none;
        update();
      } else {
        response = await socialRemoteData.setSocialAllBSWithFile(
          socialBS_id.toString(),
          socialBS_img,
          socialBS_url.text,
          socialBS_date.toString(),
          socialBS_title.text,
          socialBS_title_ar.text,

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
      xfile = null;
      getSocialAllMy();
      update();
    }
  }

  @override
  void onInit() {
    getSocialAllMy();
    super.onInit();
  }
}
