import 'package:fancy_drawer/fancy_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:smc/Classes/handlingStatusRemotDataView.dart';
import 'dart:ui' as ui;
import '../../Controller/DayOfLevel/levelsController.dart';
import '../../Controller/Subscription/subscriptionController.dart';
import '../../Core/Constant/color.dart';

class Levels extends StatefulWidget {
  const Levels({Key? key}) : super(key: key);

  @override
  State<Levels> createState() => _LevelsState();
}

class _LevelsState extends State<Levels> with SingleTickerProviderStateMixin {
  final index = 0;
  late FancyDrawerController FDC_controller =
      FancyDrawerController(vsync: this, duration: Duration(milliseconds: 500))
        ..addListener(() {
          setState(() {});
        });

  @override
  void dispose() {
    FDC_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    LevelsController levelsController = Get.put(LevelsController());

    SubscriptionController subscriptionController =
        Get.put(SubscriptionController());
    return Scaffold(
      body: GetBuilder<LevelsController>(
        builder: (controller) =>HandlingStatusRemotDataView(


          statusRequest: controller.statusRequest, widget:


        Container(
          child:GetBuilder<SubscriptionController>(
            builder: (subscriptionController) =>
        subscriptionController.isActive == false
            ? NeumorphicButton(
                child: Center(
                  child: Text(
                    "ClicktoCheckaSubscriptionActive".tr,
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(color: ColorApp.lightBlack),
                  ),
                ),
                duration: Duration(seconds: 1),
                onPressed: () {
                  subscriptionController.getSubscriptionActive();
                  Get.delete<LevelsController>();
                  Get.put(LevelsController());
                  subscriptionController.update();
                },
              )
            :  FancyDrawerWrapper(
                      backgroundColor: NeumorphicColors.background,
                      controller: FDC_controller,
                      drawerItems: <Widget>[
                        //  DrawerX()
                      ],
                      child: NeumorphicSlider(
                        onChanged: (b) {},
                        value: 1,
                        thumb: Container(
                          padding: EdgeInsets.only(top: 20),
                          height: 650,
                          color: ColorApp.bgMain,
                          child: ListView(
                            physics: BouncingScrollPhysics(),
                            children: [
                              Row(
                                children: [
                                  LevelBar(
                                    color: controller.viewProfileController
                                                .data[0]!.usersLevel ==
                                            1
                                        ? ColorApp.darkRed
                                        : ColorApp.lightBlack,
                                    levelTitle: "Level1".tr,
                                  ),
                                  LevelBar(
                                    color: controller.viewProfileController
                                                .data[0]!.usersLevel ==
                                            2
                                        ? ColorApp.darkRed
                                        : ColorApp.lightBlack,
                                    levelTitle: "Level2".tr,
                                  ),
                                  LevelBar(
                                    color: controller.viewProfileController
                                                .data[0]!.usersLevel ==
                                            3
                                        ? ColorApp.darkRed
                                        : ColorApp.lightBlack,
                                    levelTitle: "Level3".tr,
                                  ),
                                  LevelBar(
                                    color: controller.viewProfileController
                                                .data[0]!.usersLevel! >
                                            3
                                        ? ColorApp.darkRed
                                        : ColorApp.lightBlack,
                                    levelTitle: "LevelFree".tr,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 250,
                                color: ColorApp.bgMain,
                                child: Neumorphic(
                                  child: GridView.builder(
                                      physics: BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 7,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 2,
                                        crossAxisSpacing: 8,
                                      ),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return  GetBuilder<LevelsController>(
                                            builder: (controller) =>HandlingStatusRemotDataView(statusRequest: controller.statusRequest, widget: NeumorphicButton(
                                          child: Center(
                                              child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                " ${index + 1} ",
                                                style: controller
                                                            .viewProfileController
                                                            .data[0]!
                                                            .usersDaylevel ==
                                                        index + 1
                                                    ? Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge
                                                    : Theme.of(context)
                                                        .textTheme
                                                        .displaySmall!
                                                        .copyWith(
                                                            color: ColorApp
                                                                .lightBlack),
                                              ),
                                              Text(
                                                "Day".tr,
                                                style: controller
                                                            .viewProfileController
                                                            .data[0]!
                                                            .usersDaylevel ==
                                                        index + 1
                                                    ? Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge
                                                    : Theme.of(context)
                                                        .textTheme
                                                        .displaySmall!
                                                        .copyWith(
                                                            color: ColorApp
                                                                .lightBlack),
                                              ),
                                            ],
                                          )),
                                          duration: Duration(seconds: 1),
                                          onPressed: () {
                                            controller.goToDay(
                                                index + 1,
                                                controller.viewProfileController
                                                    .data[0]!.usersLevel);
                                          },
                                        )));
                                      }),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              GetBuilder<LevelsController>(
                                  builder: (controller) => Row(
                                        children: [
                                          NeumorphicButton(
                                            onPressed: () async {
                                              await controller.nextDay();
                                              controller.update();
                                            },
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: Row(
                                              children: [
                                                Text("Nextday".tr,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displaySmall!
                                                        .copyWith(
                                                            color: ColorApp
                                                                .lightBlack),
                                                    textAlign:
                                                        TextAlign.center),
                                                Text(
                                                  " ${controller.nextNumDay()} ",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displaySmall!
                                                      .copyWith(
                                                          color: ColorApp
                                                              .middleRed),
                                                  textAlign: TextAlign.center,
                                                ),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: ColorApp.lightBlack,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Spacer(),
                                          NeumorphicButton(
                                            onPressed: () async {
                                              await controller.preDay();
                                              controller.update();
                                            },
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.arrow_back_ios,
                                                  color: ColorApp.lightBlack,
                                                ),
                                                Text(
                                                    "${controller.preNumDay()}  ",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displaySmall!
                                                        .copyWith(
                                                            color:
                                                                ColorApp.blue),
                                                    textAlign:
                                                        TextAlign.center),
                                                Text("previousday".tr,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displaySmall!
                                                        .copyWith(
                                                            color: ColorApp
                                                                .lightBlack),
                                                    textAlign:
                                                        TextAlign.center),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )),
                              Container(
                                  margin: EdgeInsets.only(
                                      left: 16, right: 8, top: 70, bottom: 15),
                                  child: Table(
                                    defaultVerticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    children: [
                                      TableRow(
                                        children: [
                                          Text(
                                            "Coach".tr,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall!
                                                .copyWith(
                                                    color: ColorApp.darkBlack,
                                                    fontSize: 15),
                                          ),
                                          Text(
                                            "Apprentice".tr,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall!
                                                .copyWith(
                                                    color: ColorApp.darkBlack,
                                                    fontSize: 15),
                                          ),
                                          Text(
                                            "Duration".tr,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall!
                                                .copyWith(
                                                    color: ColorApp.darkBlack,
                                                    fontSize: 15),
                                          ),
                                        ],
                                      ),
                                      TableRow(children: [
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Divider(
                                              height: 5,
                                              thickness: 2,
                                              color: ColorApp.middleRed,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Divider(
                                              height: 5,
                                              thickness: 2,
                                              color: ColorApp.middleRed,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Divider(
                                              height: 5,
                                              thickness: 2,
                                              color: ColorApp.middleRed,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Text(
                                          "${controller.viewProfileController.data[0]!.coachName}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall!
                                              .copyWith(
                                                  color: ColorApp.lightBlack,
                                                  fontSize: 13),
                                        ),
                                        Text(
                                          "${controller.viewProfileController.data[0]!.usersName}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall!
                                              .copyWith(
                                                  color: ColorApp.lightBlack,
                                                  fontSize: 13),
                                        ),
                                        Text(
                                          controller.viewProfileController
                                                      .data[0]!.usersLevel ==
                                                  1
                                              ? "1month".tr
                                              : controller
                                                          .viewProfileController
                                                          .data[0]!
                                                          .usersLevel ==
                                                      2
                                                  ? "2month".tr
                                                  : controller
                                                              .viewProfileController
                                                              .data[0]!
                                                              .usersLevel ==
                                                          3
                                                      ? "3month".tr
                                                      : "Freemonth".tr,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall!
                                              .copyWith(
                                                  color: ColorApp.lightBlack,
                                                  fontSize: 13),
                                        ),
                                      ]),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                        sliderHeight: 100,
                        max: 3,
                        min: 1,
                      ),
                    ),

      ),
      ),
      ),
      ),
    );
  }
}

class LevelBar extends StatelessWidget {
  final Color color;
  final String levelTitle;

  const LevelBar({Key? key, required this.color, required this.levelTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      child: BackdropFilter(
          filter: ui.ImageFilter.blur(
            sigmaX: 5.0,
            sigmaY: 25.0,
          ),
          child: Text(
            levelTitle,
            style: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(color: ColorApp.bacground, fontSize: 11),
          )),
      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
      style: NeumorphicStyle(color: color),
    );
  }
}
