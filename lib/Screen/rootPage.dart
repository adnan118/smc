import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:fancy_drawer/fancy_drawer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:smc/Classes/handlingStatusRemotDataView.dart';
import '../Controller/Home/basicScreenController.dart';
import '../Controller/Home/profileController.dart';
import '../Core/Constant/color.dart';
import '../Core/Function/alertExitApp.dart';
import '../../Widget/Basic/drawerX.dart';
import '../Core/Services/services.dart';
import '../Widget/Store/ReadQr.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage>
    with SingleTickerProviderStateMixin {
  BasicScreenController basicScreenController =
      Get.put(BasicScreenController());
  ViewProfileController viewProfileController =
      Get.put(ViewProfileController());
  late FancyDrawerController FDC_controller;

  @override
  void initState() {
    super.initState();

    FDC_controller = FancyDrawerController(
        vsync: this, duration: Duration(milliseconds: 500))
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    FDC_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Myservices myservices = Get.find();
    return Scaffold(
        body: FancyDrawerWrapper(
            backgroundColor: NeumorphicColors.background,
            controller: FDC_controller,
            drawerItems: <Widget>[DrawerX()],
            child: GetBuilder<BasicScreenController>(
                builder: (controller) => HandlingStatusRemotDataView(
                    statusRequest: controller.statusRequest,
                    widget: Scaffold(
                      appBar: AppBar(
                        centerTitle: true,
                        elevation: 3.0,
                        title:
                        viewProfileController.data.isNotEmpty?
                        Text(
                          viewProfileController.data[0].usersRole==0?    controller.titlePagesListA[controller.bottomNavIndex]
                      :    controller.titlePagesList[controller.bottomNavIndex],
                          style: Theme.of(context).textTheme.bodyLarge,
                        ):CircularProgressIndicator(color: ColorApp.darkRed,),




                        backgroundColor: ColorApp.bgMain,
                        leading: IconButton(
                          icon: Icon(
                            Icons.menu,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            FDC_controller.toggle();
                          },
                        ),
                        actions: [
                          PopupMenuButton(
                            shape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            position: PopupMenuPosition.under,
                            color: ColorApp.bgMain,
                            itemBuilder: (context) {
                              return [
                                PopupMenuItem(
                                  value: "/Notifications",
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                    Text(
                                    'Notifications'.tr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall!
                                        .copyWith(
                                        color: ColorApp.darkBlack,
                                        fontSize: 12),
                                  ),
                                      Image.asset(
                                        'assets/images/notification.png',
                                        width: 30,
                                      ),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  value: "Translation",
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            'Translation'.tr,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall!
                                                .copyWith(
                                                    color: ColorApp.darkBlack,
                                                    fontSize: 12),
                                          ),
                                          Text(
                                            '${basicScreenController.Codelanguage}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall!
                                                .copyWith(
                                                    color: ColorApp.lightBlack,
                                                    fontSize: 10),
                                          ),
                                        ],
                                      ),
                                      Image.asset(
                                        'assets/images/translation.png',
                                        width: 30,
                                      ),
                                    ],
                                  ),
                                ),

                                PopupMenuItem(
                                  value: "/AboutUs",
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        'aboutUsTitle'.tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall!
                                            .copyWith(
                                                color: ColorApp.darkBlack,
                                                fontSize: 12),
                                      ),
                                      Image.asset(
                                        'assets/images/about-us.png',
                                        width: 30,
                                      ),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  value: "/",
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        'Exit'.tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall!
                                            .copyWith(
                                                color: ColorApp.darkBlack,
                                                fontSize: 12),
                                      ),
                                      Image.asset(
                                        'assets/images/logout.png',
                                        width: 30,
                                      ),
                                    ],
                                  ),
                                ),
                              ];
                            },
                            onSelected: (value) async {
                              if (value == "/") {
                                Get.defaultDialog(
                                    title: "Alert".tr,
                                    middleText: "bodyAlert".tr,
                                    titleStyle: TextStyle(fontSize: 22),
                                    actions: [
                                      ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(ColorApp.darkRed),
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
                                                MaterialStateProperty.all<
                                                    Color>(ColorApp.lightRed),
                                          ),
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: Text(
                                            "btnCancel".tr,
                                            style: TextStyle(fontSize: 12),
                                          )),
                                    ]);
                              } else if (value == "Translation") {
                                basicScreenController.changeLan();
                              } else {
                                print('Selected: $value');
                                Get.toNamed("$value");
                              }
                            },
                          )
                        ],
                      ),
////////////////////////////////////////////////////////////////////////////////      BtnNavigationBar
                      backgroundColor: ColorApp.bgMain,
                      floatingActionButton: FloatingActionButton(
                        tooltip: "Read Invoice",
                        onPressed: () {
                          Get.bottomSheet(
                              ignoreSafeArea: false,
                              isScrollControlled: true,
                              ReadCodeInvoice());
                        },
                        elevation: 1,
                        backgroundColor: ColorApp.darkRed,
                        child: Image.asset(
                          "assets/images/qr.png",
                          width: 40,
                        ),
                        //params
                      ),
                      floatingActionButtonLocation:
                          FloatingActionButtonLocation.centerDocked,
                      bottomNavigationBar:

                      viewProfileController.data.isEmpty?Text(""):
                       viewProfileController.data[0].usersRole==0?
                      AnimatedBottomNavigationBar.builder(
                        backgroundColor: ColorApp.bgMain,
                        height: 50,
                        elevation: 20,
                        itemCount: controller.iconListA.length,
                        tabBuilder: (int index, bool isActive) {
                          return Container(
                              padding: EdgeInsets.all(10),
                              child: Neumorphic(
                                style: NeumorphicStyle(
                                  color: isActive
                                      ? ColorApp.bacground
                                      : ColorApp.bgMain,
                                ),
                                child: Image.asset(
                                  controller.iconListA[index],
                                  color: isActive ? null : ColorApp.lightBlack,
                                ),
                              ));
                        },
                        activeIndex: controller.bottomNavIndex,
                        gapLocation: GapLocation.center,
                        notchSmoothness: NotchSmoothness.softEdge,
                        leftCornerRadius: 10,
                        rightCornerRadius: 10,
                        onTap: (index) {
                          controller.changPage(index);
                        },
                        //other params
                      ): AnimatedBottomNavigationBar.builder(
                         backgroundColor: ColorApp.bgMain,
                         height: 50,
                         elevation: 20,
                         itemCount: controller.iconList.length,
                         tabBuilder: (int index, bool isActive) {
                           return Container(
                               padding: EdgeInsets.all(10),
                               child: Neumorphic(
                                 style: NeumorphicStyle(
                                   color: isActive
                                       ? ColorApp.bacground
                                       : ColorApp.bgMain,
                                 ),
                                 child: Image.asset(
                                   controller.iconList[index],
                                   color: isActive ? null : ColorApp.lightBlack,
                                 ),
                               ));
                         },
                         activeIndex: controller.bottomNavIndex,
                         gapLocation: GapLocation.center,
                         notchSmoothness: NotchSmoothness.softEdge,
                         leftCornerRadius: 10,
                         rightCornerRadius: 10,
                         onTap: (index) {
                           controller.changPage(index);
                         },
                         //other params
                       ),
                      body: WillPopScope(
                          child:
                          viewProfileController.data.isEmpty?Text(""):
                          viewProfileController.data[0].usersRole==0?
                          (controller.pagesListA.elementAt(controller.bottomNavIndex)):
                          (controller.pagesList.elementAt(controller.bottomNavIndex)),
                          onWillPop: () {
                            return AlertExitApp();
                          }),
                    )))));
  }
}
