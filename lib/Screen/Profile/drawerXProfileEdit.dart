import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:smc/Classes/handlingStatusRemotDataView.dart';

import '../../Auth/Widget/customTextFormAuth.dart';
import '../../Controller/Home/profileController.dart';
import '../../Core/Constant/color.dart';
import '../../Core/Constant/imageasset.dart';
import '../../Core/Function/validinput.dart';
import '../../Core/Services/services.dart';
import '../../Data/Model/profileModel.dart';
import '../../Widget/Home/avatarImage.dart';
import '../../Widget/Home/btnRegDay.dart';
import '../../Widget/Home/connectionData.dart';

class DrawerXProfileEdit extends StatelessWidget {
  const DrawerXProfileEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ViewProfileController viewProfileController =
        Get.put(ViewProfileController());

    return InfoProfile(ListProfileModel: viewProfileController.data);
  }
}

class InfoProfile extends GetView<ViewProfileController> {
  final List<ProfileModel> ListProfileModel;

  InfoProfile({Key? key, required this.ListProfileModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ViewProfileController viewProfileController =
        Get.put(ViewProfileController());
    Myservices myservices = Get.find();
    return GetBuilder<ViewProfileController>(
        builder: (controller) => HandlingStatusRemotDataRequest(
            statusRequest: viewProfileController.statusRequest,
            widget: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: ListProfileModel.length,
                itemBuilder: (context, index) {
                  return Form(
                      key: viewProfileController.myKeyEp,
                      child: Column(mainAxisSize: MainAxisSize.max, children: [
                        Row(
                            mainAxisAlignment:
                                myservices.sharedPref.getString("myLang") ==
                                        "ar"
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  controller.myfile==null?
                              AvatarImag(
                                    color: ColorApp.darkRed,
                                    img:
                                        "${ImageAssetApp.ImageProfile}/${controller.users_image}",
                                    radius: 45.0,
                                    numCircle: 3,
                                  ):
                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    backgroundImage: FileImage(controller.myfile!) ,
                                    radius: 45.0,
                                  ),

                                  Padding(
                                    padding: EdgeInsets.only(top: 55, left: 50),
                                    child: IconButton(
                                      splashRadius: 25,
                                      iconSize: 30,
                                      icon: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: ColorApp.darkRed),
                                        child: Icon(
                                          Icons.download_for_offline_outlined,
                                          color: ColorApp.bgMain,
                                        ),
                                      ),
                                      onPressed: () {
                                        viewProfileController.chooesImg();

                                        viewProfileController.update();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 50,
                              ),
                              Column(
                                children: [
                                  NeumorphicButton(
                                    style: NeumorphicStyle(
                                        boxShape: NeumorphicBoxShape.circle()),
                                    onPressed: () async {
                                      viewProfileController
                                          .profile_OR_editprofile = "profile";

                                      controller.myfile=null;
                                      viewProfileController.update();
                                    },
                                    child: Image.asset(
                                      'assets/images/backDouble.png',
                                      width: 25,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  NeumorphicButton(
                                    style: NeumorphicStyle(
                                        boxShape: NeumorphicBoxShape.circle()),
                                    onPressed: () {
                                      viewProfileController
                                          .profile_OR_editprofile = "profile";
                                      viewProfileController
                                          .setDataEditProfile();
                                      viewProfileController.update();
                                    },
                                    child: Image.asset(
                                      'assets/images/done.png',
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
                              width: 222,
                              child: CustomTextFormAuth(
                                title: "fildUsername".tr,
                                hint:
                                    "${ListProfileModel[index].usersFullName}",
                                obscureText: false,
                                icon: Icons.person_pin,
                                myController: viewProfileController.fullname!,
                                keyboardTypex: TextInputType.text,
                                valid: (val) {
                                  return validinput(val!, 3, 20, "fullname");
                                },
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
                              width: 222,
                              child: CustomTextFormAuth(
                                title: "fildUsername".tr,
                                hint: "${ListProfileModel[index].usersName}",
                                obscureText: false,
                                icon: Icons.alternate_email,
                                myController: viewProfileController.username!,
                                keyboardTypex: TextInputType.text,
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment:
                              myservices.sharedPref.getString("myLang") == "ar"
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 222,
                              child: CustomTextFormAuth(
                                title: "fildEmail".tr,
                                hint: "${ListProfileModel[index].usersEmail}",
                                icon: Icons.email_outlined,
                                myController: viewProfileController.email,
                                keyboardTypex: TextInputType.text,
                                obscureText: false,
                                valid: (val) {
                                  return validinput(val!, 5, 30, "email");
                                },
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment:
                              myservices.sharedPref.getString("myLang") == "ar"
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 222,
                              child: CustomTextFormAuth(
                                title: "fildPhone".tr,
                                hint: "${ListProfileModel[index].usersPhone}",
                                icon: Icons.phone,
                                myController: viewProfileController.phone,
                                keyboardTypex:
                                    TextInputType.numberWithOptions(),
                                obscureText: false,
                                valid: (val) {
                                  return validinput(val!, 5, 30, "phone");
                                },
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment:
                              myservices.sharedPref.getString("myLang") == "ar"
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 222,
                              child: CustomTextFormAuth(
                                title: "fildPassword".tr,
                                hint:
                                    "${ListProfileModel[index].usersPassword}",
                                obscureText: controller.isShowPassword,
                                icon: controller.IconDataPassword,
                                keyboardTypex: TextInputType.text,
                                myController: viewProfileController.password,
                                onTapicon: () {
                                  controller.funShowPassword();
                                },
                                valid: (val) {
                                  return validinput(val!, 4, 13, "password");
                                },
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                            mainAxisAlignment:
                                myservices.sharedPref.getString("myLang") ==
                                        "ar"
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                            children: [
                              NeumorphicButton(
                                style:
                                    NeumorphicStyle(color: ColorApp.lightBlack),
                                onPressed: () {
                                  //      Get.toNamed("/ViewAndRenewsubscription");
                                },
                                child: Text(
                                  "Subscriptionview".tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(
                                          color: ColorApp.bacground,
                                          fontSize: 11),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              //        BtnRegDay()
                            ]),
                        Row(
                            mainAxisAlignment:
                                myservices.sharedPref.getString("myLang") ==
                                        "ar"
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
                      ]));
                })));
  }
}
