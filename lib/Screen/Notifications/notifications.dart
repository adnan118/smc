import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';

import '../../Classes/handlingStatusRemotDataView.dart';
import '../../Controller/Notifications/NotificationsController.dart';
import '../../Core/Constant/color.dart';

class Notifications extends StatelessWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NotificationController notificationController =
        Get.put(NotificationController());
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Notification".tr,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        body: Container(
            margin: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
            child: GetBuilder<NotificationController>(
                builder: (notificationController) =>
                    HandlingStatusRemotDataView(
                        statusRequest: notificationController.statusRequest,
                        widget: RefreshIndicator(
                            color: ColorApp.bgMain,
                            backgroundColor: ColorApp.darkRed,
                            onRefresh: () async {
                              await Future.delayed(Duration(seconds: 2));
                              Get.delete<NotificationController>();
                              Get.put(NotificationController());
                            },
                            child:
                                ListView.builder(itemCount: notificationController.dataNotifications.length,itemBuilder: (context, index) {
                              return NeumorphicButton(margin: EdgeInsets.all(10),
                                child: ListTile(

                                title: Row(children: [
                                  Image.asset(
                                    'assets/images/iconsnotification.png',
                                    width: 15,
                                  ),
                                  Text(
                                      "   ${notificationController.dataNotifications[index].notificationTitle}   ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!.copyWith(color: ColorApp.middleRed,fontSize: 12)
                                  ),

                                ],),
                                subtitle: Text(
                                    "${notificationController.dataNotifications[index].notificationBody}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(
                                      color: ColorApp
                                          .darkBlack,
                                      fontSize: 10),),
                                trailing: Text(
                                    "${notificationController.dataNotifications[index].notificationDate }",
                                    style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                    color: ColorApp
                                        .lightBlack,
                                    fontSize: 7),
                                ),
                                ),
                                onPressed: (){
                                Get.toNamed( "${notificationController.dataNotifications[index].notificationNamePage }");
                                },
                              );
                            }))
                    ))
        ));
  }
}
