import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;
import '../../Classes/handlingStatusRemotDataView.dart';
import '../../Controller/CoachTools/coachToolsController.dart';
import '../../Controller/Notifications/NotificationsController.dart';
import '../../Core/Constant/color.dart';
import '../../Core/Constant/imageasset.dart';
import '../../Core/Function/validinput.dart';
import '../../Core/Services/services.dart';
import '../../Data/Model/profileModel.dart';
import '../../Widget/Home/avatarImage.dart';
import '../../Widget/Home/connectionData.dart';

class SendNotification extends StatelessWidget {
  const SendNotification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NotificationController notificationController =
        Get.put(NotificationController());
    return GetBuilder<CoachToolsController>(
        builder: (controller) => HandlingStatusRemotDataView(
            statusRequest: controller.statusRequest,
            widget: Column(children: [
              Container(
                  child: InfoProfile(
                ListProfileModel: controller.dataSelectUser,
              )),
              Flexible(
                  child: Neumorphic(
                      child: GetBuilder<NotificationController>(
                          builder: (notificationController) =>
                              HandlingStatusRemotDataView(
                                  statusRequest:
                                      notificationController.statusRequest,
                                  widget: ListView.builder(
                                      physics: BouncingScrollPhysics(),
                                      itemCount: notificationController
                                          .dataNotifications.length,
                                      itemBuilder: (context, index) {
                                        return NeumorphicButton(
                                          margin: EdgeInsets.all(10),
                                          child: ListTile(
                                            title: Row(
                                              children: [
                                                Image.asset(
                                                  'assets/images/iconsnotification.png',
                                                  width: 15,
                                                ),
                                                Text(
                                                  "   ${notificationController.dataNotifications[index].notificationTitle}   ",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displaySmall!
                                                      .copyWith(
                                                        color:
                                                            ColorApp.middleRed,
                                                        fontSize: 13,
                                                      ),
                                                ),
                                              ],
                                            ),
                                            subtitle: Text(
                                              "${notificationController.dataNotifications[index].notificationBody} \n${notificationController.dataNotifications[index].notificationDate}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displaySmall!
                                                  .copyWith(
                                                    color: ColorApp.darkBlack,
                                                    fontSize: 10,
                                                  ),
                                            ),
                                          ),
                                          onPressed: () {
                                            Get.toNamed(
                                                "${notificationController.dataNotifications[index].notificationNamePage}");
                                          },
                                        );
                                      })))))
            ])));
  }
}

class InfoProfile extends GetView<CoachToolsController> {
  final List<ProfileModel> ListProfileModel;

  InfoProfile({Key? key, required this.ListProfileModel}) : super(key: key);
  Myservices myservices = Get.find();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      Neumorphic(
        child: Container(
          decoration: BoxDecoration(
            color: ColorApp.bgMain,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: EdgeInsets.all(20),
          child: Form(
            key: controller.formKeySendnoti,
            child: Row(
              children: [
                Expanded(
                    child: Neumorphic(
                  style: NeumorphicStyle(
                    depth: -5,
                    boxShape: NeumorphicBoxShape.roundRect(
                      BorderRadius.circular(10),
                    ),
                  ),
                  child: TextField(
                    maxLines: 5,
                    cursorColor: ColorApp.middleRed,
                    style: Theme.of(context).textTheme.displaySmall,
                    controller: controller.notificationBody,
                    decoration: InputDecoration(
                      labelText: "massage".tr,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      labelStyle: TextStyle(color: ColorApp.lightBlack),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                )),
                SizedBox(width: 10),
                Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        textStyle: Theme.of(context).textTheme.displaySmall,
                        primary: ColorApp.darkRed,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.all(11),
                      ),
                      onPressed: () {
                        //     controller.getData(controller.SelectUser);
                        controller.user = controller.SelectUser.text.toString();
                        controller.inserNotificationBoth();
                      },
                      child: Text("Send".tr),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GetBuilder<CoachToolsController>(builder: (controller) {
                      return HandlingStatusRemotDataRequest(
                          statusRequest: controller.statusRequest,
                          widget: ItemInfo(
                            title: "sendToUser".tr,
                            widget: DropdownButton<String>(
                              iconEnabledColor: ColorApp.darkRed,
                              underline: Text(""),
                              value: controller.sendToUser.toString(),
                              items: controller.dataAllTrainees
                                  .map<DropdownMenuItem<String>>((Traine) {
                                return DropdownMenuItem<String>(
                                  value: Traine.usersId.toString(),
                                  child: Text(
                                    Traine.usersName.toString() +
                                        Traine.usersId.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          color: ColorApp.middleRed,
                                          fontSize: 10,
                                        ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                controller.sendToUser = newValue.toString();
                                controller.update();
                              },
                            ),
                          ));
                    }),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ]));
  }
}

class ItemInfo extends StatelessWidget {
  ItemInfo({Key? key, required this.title, required this.widget})
      : super(key: key);
  final String title;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Neumorphic(
        style: NeumorphicStyle(depth: 2, shape: NeumorphicShape.flat),
        child: Column(
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(color: ColorApp.darkBlack, fontSize: 12),
            ),
            widget,
          ],
        ),
      ),
    );
  }
}
