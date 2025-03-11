import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:smc/Classes/handlingStatusRemotDataView.dart';
import '../../Controller/Home/profileController.dart';
import '../../Core/Constant/color.dart';
import '../../Core/Constant/imageasset.dart';
import '../../Core/Services/services.dart';
import '../../Widget/Home/avatarImage.dart';
import '../../Widget/Home/btnRegDay.dart';
import '../../Widget/Home/connectionData.dart';

class DrawerXProfile extends StatelessWidget {
  const DrawerXProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Myservices myservices = Get.find();

    ViewProfileController viewProfileController =
        Get.put(ViewProfileController());

    return GetBuilder<ViewProfileController>(
        builder: (controller) => HandlingStatusRemotDataView(
            statusRequest: controller.statusRequest,
            widget: controller.data.isEmpty?
            Center(
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: ColorApp.darkRed,
                  ),
                  Text(
                      "gettingyouprofile".tr,
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!.copyWith(color: ColorApp.darkBlack)

                  ),
                ],
              ),
            )
                :Column(mainAxisSize: MainAxisSize.max, children: [
              Row(
                  mainAxisAlignment:
                      myservices.sharedPref.getString("myLang") == "ar"
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                  children: [
                    AvatarImag(
                      color: ColorApp.darkRed,
                      img:
                          "${ImageAssetApp.ImageProfile}/${controller.users_image}",
                      radius: 45.0,
                      numCircle: 3,
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Column(
                      children: [
                        NeumorphicButton(
                          style: NeumorphicStyle(
                              boxShape: NeumorphicBoxShape.circle()),
                          tooltip: "Exit".tr,
                          onPressed: () async {
                            Get.defaultDialog(
                                title: "Alert".tr,
                                middleText: "bodyAlert".tr,
                                titleStyle: TextStyle(fontSize: 22),
                                actions: [
                                  ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                ColorApp.darkRed),
                                      ),
                                      onPressed: () async {
                                        // اشعار للكل
                                        FirebaseMessaging.instance.unsubscribeFromTopic("users");
                                        // اشعار لمستخدم معين
                                        String userId =                myservices.sharedPref.getInt("users_id").toString()!;
                                        FirebaseMessaging.instance.unsubscribeFromTopic("users$userId");
                                        await myservices.sharedPref.clear();
                                        print("Exit");
                                        Get.offAllNamed("/");
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
                                            MaterialStateProperty.all<Color>(
                                                ColorApp.lightRed),
                                      ),
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: Text(
                                        "btnCancel".tr,
                                        style: TextStyle(fontSize: 12),
                                      )),
                                ]);
                          },
                          child: Image.asset(
                            'assets/images/logout.png',
                            width: 25,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        NeumorphicButton(
                          style: NeumorphicStyle(
                              boxShape: NeumorphicBoxShape.circle()),
                          tooltip: "Edit".tr,
                          onPressed: () {
                            viewProfileController.profile_OR_editprofile =
                                "editprofile";

                            viewProfileController.update();
                          },
                          child: Image.asset(
                            'assets/images/edit.png',
                            width: 25,
                          ),
                        )
                      ],
                    )
                  ]),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment:
                    myservices.sharedPref.getString("myLang") == "ar"
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      "@${viewProfileController.username.text}",
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(color: ColorApp.darkBlack, fontSize: 20),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment:
                    myservices.sharedPref.getString("myLang") == "ar"
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      "${viewProfileController.users_role}",
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(color: ColorApp.middleRed, fontSize: 15),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment:
                myservices.sharedPref.getString("myLang") == "ar"
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: [

                  Container(
                    child: Text(
                      "ID_${viewProfileController.profileModel!.usersId} ",
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(color: ColorApp.middleRed, fontSize: 15),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: ConnectionData(
                      image: "assets/images/iconmail.png",
                      content: "${viewProfileController.email.text}",
                      mail1Phone2Link3Sms4: 1,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: ConnectionData(
                      image: "assets/images/iconphone.png",
                      content: "${viewProfileController.phone.text}",
                      mail1Phone2Link3Sms4: 2,
                    ),
                  ),
                ],
              ),

              viewProfileController.data[0].usersRole==2&&
             // viewProfileController.data[0].usersRole==2?

              viewProfileController.data[0].useresCoachMember==0?
              Row(
                mainAxisAlignment:
                myservices.sharedPref.getString("myLang") == "ar"
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: [
    GetBuilder<ViewProfileController>(
    builder: (controller) => HandlingStatusRemotDataView(
    statusRequest: controller.statusRequest,
    widget:

    Container(
      child: NeumorphicButton(
        child:Center(child: Text(
          "Coachmembership".tr,
          style: Theme.of(context)
              .textTheme
              .displaySmall!
              .copyWith(color: ColorApp.middleRed, fontSize: 10),
        ),),
        onPressed: (){
          Get.defaultDialog(
            title: "Coachmembership".tr,titleStyle:  TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: "Exo",
            fontSize: 15,
            color: ColorApp.darkRed,
            height: 1.5,
          ),
            content:Container(padding: EdgeInsets.all(20),child: Text("CoachmembershipBody".tr,
              style:  TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: "Exo",
                fontSize: 12,
                color: ColorApp.lightBlack,
                height: 1.5,
              ),)),
            confirm: NeumorphicButton(
              style: NeumorphicStyle(depth: 1),
              child: Text("btnContinue".tr,
                style:  TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: "Exo",
                  fontSize: 13,
                  color: ColorApp.darkRed,
                  height: 1.5,
                ),),
              onPressed: (){
                viewProfileController.   updateCoachMemberShip();
                Get.back();

              },
            ),


          );
        },
      ),

    ),
                )
                )
                ],
              ):
              viewProfileController.data[0].useresCoachMember==1?
              Row(
                mainAxisAlignment:
                myservices.sharedPref.getString("myLang") == "ar"
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: [
                  Container(
                    child: NeumorphicButton(
                      child:Text(
                        "Process".tr,
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(color: ColorApp.middleRed, fontSize: 10),
                      ),

                    ),

                  ),
                ],
              ):



        //      SizedBox(
         //       height: 50,
          //    ):


              viewProfileController.data[0].usersRole!=0?
              Row(
                mainAxisAlignment:
                myservices.sharedPref.getString("myLang") == "ar"
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: [
                  Container(
                    child: NeumorphicButton(
                      child:Text(
                        "CoachTools".tr,
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                             ,
                      ),
                      onPressed: (){
Get.toNamed("/CoachTools");
                      },
                    ),

                  ),
                ],
              ):   SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 50,
              ),
              viewProfileController.data[0].usersRole==0?SizedBox(height: 0,):
              Row(
                  mainAxisAlignment:
                      myservices.sharedPref.getString("myLang") == "ar"
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                  children: [
                    NeumorphicButton(
                      style: NeumorphicStyle(color: ColorApp.lightRed),
                      onPressed: () {
                        Get.toNamed("/ViewAndRenewsubscription");
                      },
                      child: Text(
                        "Subscriptionview".tr,
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(color: ColorApp.bacground, fontSize: 11),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    BtnRegDay()
                  ]),






              Row(
                  mainAxisAlignment:
                      myservices.sharedPref.getString("myLang") == "ar"
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                  children: [
                    Text(
                      "       © 2024 SVU, Org.",
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(color: Colors.grey, fontSize: 10),
                    ),
                  ]),
            ])));
  }
}
