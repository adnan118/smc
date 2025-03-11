import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smc/Core/Constant/color.dart';

import '../../Classes/HandlingDataController.dart';
import '../../Core/Localization/changelocal.dart';
import '../../Core/Services/services.dart';
import '../../DB/statusRequest.dart';
import '../../Data/DataSource/Remote/AnalyticsRemoteData.dart';
import '../../Data/DataSource/Remote/SocialRemoteData.dart';
import '../../Data/DataSource/Remote/coachRemoteData.dart';
import '../../Data/Model/notificationsModel.dart';
import '../../Data/Model/profileModel.dart';
import '../../Data/Model/socialBSModel.dart';
import '../../Screen/Analytics/analytics.dart';
import '../../Screen/B_DayOfLevel/levels.dart';
import '../../Screen/Basic/basicScreen.dart';
import '../../Screen/Store/store.dart';
import '../Notifications/NotificationsController.dart';

class CoachToolsController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  Myservices myservices = Get.find();
  late TextEditingController SelectUser;
  List<ProfileModel> dataSelectUser = [];
  List<ProfileModel> dataAllTrainees = [];
  ProfileModel? profileModelSelectUser;
  ProfileModel? profileModelAllTraineesr;
  CoachRemoteData coachRemoteData = CoachRemoteData(Get.find());
  late String user = "1";
  String sendToUser = "1";
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeySendnoti = GlobalKey<FormState>();
  late TextEditingController notificationBody;

  @override
  getData(SelectUser) {
    //   SelectUser.text.isEmpty
    SelectUser.toString() == ""
        ? getDataAllTrainees()
        : getDataProfileSelectUser(SelectUser);
  }

  getDataAllTrainees() async {
    dataAllTrainees.clear();
    //loading
    statusRequest = StatusRequest.loading;
    update();
    var response = await coachRemoteData
         .getDataAllTrainees(  myservices.sharedPref.getInt("users_id").toString()!   );
     //   .getDataAllTrainees("1");
    print("$response *****");
    //
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        if (dataAllTrainees == null) {
          Get.defaultDialog(
            title: "Loading".tr,
            middleText: "Please Waiting",
            content: CircularProgressIndicator(
              color: ColorApp.darkRed,
            ),
            onCancel: () {},
          );
        } else {
          List<dynamic> responseData = response['data'];

          for (var userData in responseData) {
            ProfileModel profile = ProfileModel.fromJson(userData);
            dataAllTrainees.add(profile);
            sendToUser = dataAllTrainees[0].usersId!.toString();
          }
        }
      } else {
        //   statusRequest = StatusRequest.failuer;
      }
    }
    update();
  }

  @override
  getDataProfileSelectUser(SelectUserx) async {
    dataSelectUser.clear();
    //loading
    statusRequest = StatusRequest.loading;
    update();

    SelectUser = TextEditingController(text: SelectUserx.toString());

    var response =
        await coachRemoteData.getDataProfileSelectUser(SelectUser.text);
    print("$response *****00000");
    print("${SelectUser.text} *****0000001");
    print("${SelectUserx} *****0000002");
    if (response == StatusRequest.serverfailuer) {
      getDataAllTrainees();
      Get.defaultDialog(
        title: "errortitleresendcode".tr,
        middleText: "tryagain".tr,
      );
    }
    //
    else {
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          if (dataSelectUser == null) {
            Get.defaultDialog(
              title: "Loading".tr,
              middleText: "Please Waiting",
              content: CircularProgressIndicator(
                color: ColorApp.darkRed,
              ),
              onCancel: () {},
            );
          } else {
            profileModelSelectUser = ProfileModel.fromJson(response["data"]);
            dataSelectUser.add(profileModelSelectUser!);
            getAWH(SelectUser.text);
          }
        } else {
          getDataAllTrainees();
          Get.defaultDialog(
            title: "errortitleresendcode".tr,
            middleText: "noUser".tr,
          );
        }
      }
    }

    update();
  }

  NotificationController notificationController =
      Get.put(NotificationController());

  insertNotificationstoCoach() async {
    notificationController.dataNotifications.clear();
    statusRequest = StatusRequest.loading;
    var response = await coachRemoteData.insertNotification(
        myservices.sharedPref.getInt("users_id").toString()!,
        "SMC From Coach ID_${myservices.sharedPref.getInt("users_id")}",
        notificationBody.text.toString(),
        "/Notifications");
    print("$response *****");
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        var dataList = response["data"];
        notificationController.dataNotifications =
            dataList.map((item) => NotificationsModel.fromJson(item)).toList();
      } else {
        statusRequest = StatusRequest.failuer;
      }
    }
    update();
  }

  insertNotificationstoUser() async {
    notificationController.dataNotifications.clear();
    statusRequest = StatusRequest.loading;
    var response = await coachRemoteData.insertNotification(
        sendToUser.toString(),
        "SMC From Coach ID_${myservices.sharedPref.getInt("users_id")}",
        notificationBody.text.toString(),
        "/Notifications");
    print("$response *****");
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        var dataList = response["data"];
        notificationController.dataNotifications =
            dataList.map((item) => NotificationsModel.fromJson(item)).toList();
      } else {
        statusRequest = StatusRequest.failuer;
      }
    }
    update();
  }

  deleteSelectUserfromcoach(index) async {
    Get.defaultDialog(
        title: "Alert".tr,
        content: Center(
          child: Text(
            "AlertDeleteBody".tr,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: "Exo",
              fontSize: 13,
              color: ColorApp.lightBlack,
              height: 1.5,
            ),
          ),
        ),
        actions: [
          ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(ColorApp.darkRed),
              ),
              onPressed: () async {
                //    dataAllTrainees.clear();
                //    statusRequest = StatusRequest.loading;
                var response = await coachRemoteData.deleteSelectUserfromcoach(
                    index.toString(), "1"); //1 -> coach free
                print("$response *****");
                statusRequest = handlingData(response);

                if (StatusRequest.success == statusRequest) {
                  if (response['status'] == "success") {
                    dataAllTrainees.clear();
                    getDataAllTrainees();
                  } else {
                    statusRequest = StatusRequest.failuer;
                  }
                }
                Get.back();
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
                    MaterialStateProperty.all<Color>(ColorApp.lightBlack),
              ),
              onPressed: () {
                Get.back();
              },
              child: Text(
                "btnCancel".tr,
                style: TextStyle(fontSize: 12),
              )),
        ]);

    update();
  }

  inserNotificationBoth() async {
    // يمكنك استخدام هذا النموذج للتحقق من عدم وجود أيموجي في النص المدخل
    String emojiRegex = r'[^\x00-\x7F]';
    RegExp regExp = RegExp(emojiRegex);

// تحقق من عدم وجود أيموجي في النص المدخل
    bool hasEmoji = regExp.hasMatch(notificationBody.text);

    if (hasEmoji) {
      Get.defaultDialog(
        title: "Alert".tr,
        content: Center(
          child: Text(
            "AlertTextBody".tr,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: "Exo",
              fontSize: 13,
              color: ColorApp.lightBlack,
              height: 1.5,
            ),
          ),
        ),
      );
    } else {
      print("111111111111111");
      await insertNotificationstoCoach();
      print("22222222222222");
      await insertNotificationstoUser();
      print("33333333333333");
      await notificationController.getAllNotifications();
      notificationBody.text = "";
    }
  }

  changelevelSelectUser() async {
    Get.defaultDialog(
        title: "changeLevel".tr,
        content: Center(
          child: Text(
            "AlertchangeLevelBody".tr,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: "Exo",
              fontSize: 13,
              color: ColorApp.lightBlack,
              height: 1.5,
            ),
          ),
        ),
        actions: [
          ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(ColorApp.darkRed),
              ),
              onPressed: () async {
                if (dataSelectUser[0].usersLevel == 4) {
                  Get.defaultDialog(
                    title: "Alert".tr,
                    content: Center(
                      child: Text(
                        "AlertLevelBodyUp".tr,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: "Exo",
                          fontSize: 13,
                          color: ColorApp.lightBlack,
                          height: 1.5,
                        ),
                      ),
                    ),
                  );
                } else {
                  statusRequest = StatusRequest.loading;
                  update();

                  var response = await coachRemoteData.changelevelSelectUser(
                      "${dataSelectUser[0].usersId}",
                      "${dataSelectUser[0].usersLevel! + 1}");

                  print("$response *****");
                  //
                  statusRequest = handlingData(response);
                  if (StatusRequest.success == statusRequest) {
                    if (response['status'] == "success") {
                      getDataProfileSelectUser(SelectUser.text);
                    } else {
                      statusRequest = StatusRequest.failuer;
                    }
                  }
                  Get.back();
                }
              },
              child: Text(
                "Levelup".tr,
                style: TextStyle(fontSize: 12),
              )),
          SizedBox(
            width: 30,
          ),
          ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(ColorApp.lightBlack),
              ),
              onPressed: () async {
                if (dataSelectUser[0].usersLevel == 1) {
                  Get.defaultDialog(
                    title: "Alert".tr,
                    content: Center(
                      child: Text(
                        "AlertLevelBodyDown".tr,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: "Exo",
                          fontSize: 13,
                          color: ColorApp.lightBlack,
                          height: 1.5,
                        ),
                      ),
                    ),
                  );
                } else {
                  statusRequest = StatusRequest.loading;
                  update();

                  var response = await coachRemoteData.changelevelSelectUser(
                      "${dataSelectUser[0].usersId}",
                      "${dataSelectUser[0].usersLevel! - 1}");

                  print("$response *****");
                  //
                  statusRequest = handlingData(response);
                  if (StatusRequest.success == statusRequest) {
                    if (response['status'] == "success") {
                      getDataProfileSelectUser(SelectUser.text);
                    } else {
                      statusRequest = StatusRequest.failuer;
                    }
                  }
                  Get.back();
                }
              },
              child: Text(
                "Leveldown".tr,
                style: TextStyle(fontSize: 12),
              )),
        ]);

    update();
  }

  /////analytics
  List<int> month = [];
  List<int> height = [];
  List<int> weight = [];
  AnalyticsRemoteData analyticsRemoteData = AnalyticsRemoteData(Get.find());

  getAWH(user) async {
    statusRequest = StatusRequest.loading;
    month.clear();
    height.clear();
    weight.clear();
    update();
    var response = await analyticsRemoteData.getAnalyticsWH(user.toString()!);

    print("$response *****");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List<dynamic> data = response['data'];
        data.forEach((item) {
          int numMonth = item['spotsWH_numMonth'];
          int heightValue = item['spotsWH_height'];
          int weightValue = item['spotsWH_weight'];

          month.add(numMonth);
          height.add(heightValue);
          weight.add(weightValue);
        });

        print(month);
        print(height);
        print(weight);
      }
    } else {
      statusRequest = StatusRequest.failuer;
    }

    update();
  }

  @override
  void onInit() {
    SelectUser = TextEditingController(text: "");
    getDataAllTrainees();
    notificationBody = TextEditingController();
    notificationController.getAllNotifications();
    super.onInit();
  }
}
