import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import '../../Classes/handlingStatusRemotDataView.dart';
import '../../Controller/DayOfLevel/dayOfLevelController.dart';
import '../../Core/Constant/color.dart';
import '../../Widget/DayOfLevel/cardInfo.dart';

class B_dayOffOfLevel extends StatelessWidget {
  B_dayOffOfLevel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DayOfLevelController dayOfLevelController = Get.put(DayOfLevelController());
    dayOfLevelController.unLoading();
    return Scaffold(
        backgroundColor: ColorApp.bgMain,
        appBar: AppBar(title: Text("DayofLevel".tr)),
        body: Neumorphic(
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: GetBuilder<DayOfLevelController>(
                    builder: (controller) => HandlingStatusRemotDataView(
                        statusRequest: controller.statusRequest,
                        widget: ListView(
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Neumorphic(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 15,
                                  ),
                                  child: Container(
                                    height: 75,
                                    child: Center(
                                        child:Row(children: [
                                          Text(
                                            "Level".tr,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall!
                                                .copyWith(
                                                color: ColorApp.darkBlack,
                                                fontSize: 16),
                                          ),
                                          Text(
                                            " ${controller.levelNum} ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall!
                                                .copyWith(
                                                color: ColorApp.darkBlack,
                                                fontSize: 16),
                                          ),
                                        ],)
                                    ),
                                  ),
                                ),
                                Neumorphic(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: Container(
                                    height: 75,
                                    child: Center(
                                        child: Row(children: [
                                          Text(
                                            " ${controller.dayNum} ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall!
                                                .copyWith(
                                                color: ColorApp.darkBlack,
                                                fontSize: 16),
                                          ),
                                          Text(
                                            "Day".tr,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall!
                                                .copyWith(
                                                color: ColorApp.darkBlack,
                                                fontSize: 16),
                                          ),
                                        ],)
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ListTile(
                              title: Text("Exercises".tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(
                                          color: ColorApp.darkBlack,
                                          fontSize: 16)),
                              leading: Image.asset("assets/images/ex.png",
                                  width: 50),
                            ),
                            SingleChildScrollView(

                              padding: EdgeInsets.all(5),
                              child: Neumorphic(
                                style: NeumorphicStyle(
                                    depth: 10,
                                    lightSource: LightSource.top,
                                    color: ColorApp.bacground),
                                padding: EdgeInsets.all(10),
                                child: Table(
                                  children: [
                                    TableRow(children: [
                                      Row(
                                        children: [
                                          Column(
                                            children: [

                                Text("Exercises".tr,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displaySmall!
                                                    .copyWith(
                                                        color:
                                                            ColorApp.darkBlack,
                                                        fontSize: 16),
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          Column(
                                            children: [
                                              Text(
                                                "SetRes".tr,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displaySmall!
                                                    .copyWith(
                                                        color:
                                                            ColorApp.darkBlack,
                                                        fontSize: 16),
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    ]),
                                    TableRow(children: [
                                      Divider(
                                        height: 5,
                                        thickness: 2,
                                        color: ColorApp.lightRed,
                                      ),
                                    ]),
                                    TableRow(children: [
                                      Row(
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.all(5),
                                                child: Text(
                                                  "noExbutNotRest".tr,
                                                   style: (Theme.of(context)
                                                      .textTheme
                                                      .displaySmall!
                                                      .copyWith(
                                                          color: ColorApp
                                                              .lightBlack,
                                                          fontSize: 12)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ])
                                  ],
                                ),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                "Essential nutrients",
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                        color: ColorApp.darkBlack,
                                        fontSize: 16),
                              ),
                              leading: Image.asset("assets/images/eat.png",
                                  width: 50),
                            ),
                            GetBuilder<DayOfLevelController>(
                                builder: (controller) =>
                                    HandlingStatusRemotDataView(
                                        statusRequest: controller.statusRequest,
                                        widget: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            CardInfo(
                                              percent: 1,
                                              img: "assets/images/bread.png",
                                              color: ColorApp.blue
                                                  .withOpacity(0.4),
                                              header: "Carbohydrates",
                                              footer:
                                                  "${controller.carbMinTotal} g",
                                            ),
                                            CardInfo(
                                              percent: 1,
                                              img: "assets/images/egg.png",
                                              color: ColorApp.middleRed
                                                  .withOpacity(0.5),
                                              header: "Proteins",
                                              footer:
                                                  "${controller.proteinMinTotal} g",
                                            ),
                                            CardInfo(
                                              percent: 1,
                                              img: "assets/images/olive.png",
                                              color: ColorApp.green
                                                  .withOpacity(0.2),
                                              header: "Fats",
                                              footer:
                                                  "${controller.fatMinTotal} g",
                                            ),
                                          ],
                                        ))),
                            SizedBox(
                              height: 50,
                            ),
                            SizedBox(
                              height: 50,
                            ),
                          ],
                        ))))));
  }
}
