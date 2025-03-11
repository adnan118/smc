import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import '../../Classes/handlingStatusRemotDataView.dart';
import '../../Controller/DayOfLevel/dayOfLevelController.dart';
import '../../Core/Constant/color.dart';
import '../../Widget/DayOfLevel/cardInfo.dart';
import '../../Widget/General/myStepper.dart';

class B_dayOfLevel extends StatelessWidget {
  B_dayOfLevel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DayOfLevelController dayOfLevelController = Get.put(DayOfLevelController());

    return Scaffold(
        backgroundColor: ColorApp.bgMain,
        appBar: AppBar(title: Text("DayofLevel".tr)),
        body: Neumorphic(
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: GetBuilder<DayOfLevelController>(
                    builder: (controller) => HandlingStatusRemotDataView(
                        statusRequest: controller.statusRequest,
                        widget:
                        controller.dataM1.isEmpty || controller.dataM2.isEmpty?Center(child: CircularProgressIndicator(color: ColorApp.darkRed,),):
                        ListView(
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
                              height: 30,
                            ),
                            Neumorphic(
                                style: NeumorphicStyle(
                                    depth: 10,
                                    lightSource: LightSource.top,
                                    color: ColorApp.bacground),
                                child: Container(
                                    width: 300,
                                    height: 250,
                                    margin: EdgeInsets.all(3),
                                    padding: EdgeInsets.all(3),
                                    child: MyStepper(
                                      stepperTypex: StepperType.horizontal,
                                      img1: "assets/images/list.png",
                                      title1: "Exercisesystem".tr,
                                      content1: "Regular".tr,
                                      img2: "assets/images/timer.png",
                                      title2: "Repetitions".tr,
                                      content2: controller.dataM2.isNotEmpty
                                          ? " ${controller.dataM2[0].trainingSet} Sets \n${controller.dataM2[0].trainingRes} repetitions "
                                          : "No data",
                                      img3: "assets/images/muscle.png",
                                      title3: "Targetmuscles".tr,
                                      content3: controller.dataM1.isNotEmpty &&
                                              controller.dataM2.length > 1
                                          ? "${controller.dataM1[0].muscleName}\t\t\t\t\t\t\t\t\t\t\t\t\t\t${controller.dataM2[1].muscleName}"
                                          : "No data",
                                    ))),
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
                                                          color: ColorApp
                                                              .darkBlack,
                                                          fontSize: 16)),
                                            ],
                                          ),
                                          Spacer(),
                                          Column(
                                            children: [
                                              Text("SetRes".tr,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displaySmall!
                                                      .copyWith(
                                                          color: ColorApp
                                                              .darkBlack,
                                                          fontSize: 16)),
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
                                      ListView.builder(
                                          physics: BouncingScrollPhysics(),
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount: controller.dataM1.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            if (controller.dataM1.isEmpty ||
                                                controller.dataM2.isEmpty ||
                                                index >=
                                                    controller.dataM1.length ||
                                                index >=
                                                    controller.dataM2.length) {
                                              return Text("Nodataavailable".tr,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displaySmall!
                                                      .copyWith(
                                                          color: ColorApp
                                                              .darkBlack,
                                                          fontSize: 14));
                                            }
                                            return Row(
                                              children: [
                                                Column(
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.all(5),
                                                      child: Text(
                                                          "${controller.dataM1[index].trainingName} ",
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .displaySmall!
                                                              .copyWith(
                                                                  color: ColorApp
                                                                      .middleRed,
                                                                  fontSize:
                                                                      12)),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.all(5),
                                                      child: Text(
                                                          "${controller.dataM2[index].trainingName} ",
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .displaySmall!
                                                              .copyWith(
                                                                  color: ColorApp
                                                                      .lightBlack,
                                                                  fontSize:
                                                                      12)),
                                                    )
                                                  ],
                                                ),
                                                Spacer(),
                                                Column(
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.all(5),
                                                      child: Text(
                                                          "${controller.dataM1[index].trainingRes} / ${controller.dataM1[index].trainingSet} ",
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .displaySmall!
                                                              .copyWith(
                                                                  color: ColorApp
                                                                      .middleRed,
                                                                  fontSize:
                                                                      12)),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.all(5),
                                                      child: Text(
                                                          "${controller.dataM2[index].trainingRes} / ${controller.dataM2[index].trainingSet} ",
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .displaySmall!
                                                              .copyWith(
                                                                  color: ColorApp
                                                                      .lightBlack,
                                                                  fontSize:
                                                                      12)),
                                                    )
                                                  ],
                                                )
                                              ],
                                            );
                                          })
                                    ])
                                  ],
                                ),
                              ),
                            ),
                            ListTile(
                              title: Text("Essentialnutrients".tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(
                                          color: ColorApp.darkBlack,
                                          fontSize: 16)),
                              leading: Image.asset("assets/images/eat.png",
                                  width: 50),
                            ),
                            GetBuilder<DayOfLevelController>(
                                builder: (controller) =>
                                    HandlingStatusRemotDataRequest(
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
                                              header: "Carbohydrates".tr,
                                              footer:
                                                  "${controller.carbMinTotal}-${controller.carbMaxTotal} g",
                                            ),
                                            CardInfo(
                                              percent: 1,
                                              img: "assets/images/egg.png",
                                              color: ColorApp.middleRed
                                                  .withOpacity(0.5),
                                              header: "Proteins".tr,
                                              footer:
                                                  "${controller.proteinMinTotal}-${controller.proteinMaxTotal} g",
                                            ),
                                            CardInfo(
                                              percent: 1,
                                              img: "assets/images/olive.png",
                                              color: ColorApp.green
                                                  .withOpacity(0.2),
                                              header: "Fats".tr,
                                              footer:
                                                  "${controller.fatMinTotal}-${controller.fatMaxTotal} g",
                                            ),
                                          ],
                                        ))),

                            SizedBox(
                              height: 50,
                            ),
                          ],
                        ))))));
  }
}
