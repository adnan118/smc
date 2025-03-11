import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:smc/Classes/handlingStatusRemotDataView.dart';
import 'package:smc/Core/Constant/color.dart';
import '../../Controller/Subscription/subscriptionController.dart';
import '../../DB/statusRequest.dart';
import 'SubscriptionActive.dart';
import 'SubscriptionProcess.dart';

class Subscription extends StatelessWidget {
  Subscription({Key? key}) : super(key: key);
  final SubscriptionController subscriptionController =
      Get.put(SubscriptionController());

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: ColorApp.bgMain,
      backgroundColor: ColorApp.darkRed,
      onRefresh: () async {
        await Future.delayed(Duration(seconds: 2));
        Get.delete<SubscriptionController>();
        Get.put(SubscriptionController());

        subscriptionController.getSubscription();
        Get.offAllNamed("/RootPage");
        await Get.toNamed("/ViewAndRenewsubscription");

        subscriptionController.update();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Yoursubscription".tr,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        body: subscriptionController.dataSubscription.isEmpty?Center(child: CircularProgressIndicator(color: ColorApp.darkRed,),):GetBuilder<SubscriptionController>(
          builder: (subscriptionController) {
            print("Current page: ${subscriptionController.page}");
            if (subscriptionController.statusRequest == StatusRequest.loading) {
              return Center(child: CircularProgressIndicator(color: ColorApp.darkRed
                ,));
            } else {
              return subscriptionController.page == "Active" &&
                      subscriptionController.dataSubscription[0].subApprove == 1
                  ? SubscriptionActive()
                  : subscriptionController.page == "Active" &&
                          subscriptionController
                                  .dataSubscription[0].subApprove ==
                              0
                      ? SubscriptionProcess()
                      : HandlingStatusRemotDataView(
                          statusRequest: subscriptionController.statusRequest,
                          widget: Neumorphic(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 15),
                              child: ListView(
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        CircularPercentIndicator(
                                          radius: 50.0,
                                          lineWidth: 10,
                                          percent: subscriptionController
                                                  .differenceInDays /
                                              subscriptionController
                                                  .daysInMonth,
                                          center: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "${subscriptionController.differenceInDays} / ${subscriptionController.daysInMonth}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displaySmall!
                                                    .copyWith(
                                                      color: ColorApp.darkBlack,
                                                      fontSize: 12,
                                                    ),
                                              ),
                                              Text(
                                                "Day".tr,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displaySmall!
                                                    .copyWith(
                                                      color: ColorApp.darkBlack,
                                                      fontSize: 12,
                                                    ),
                                              ),
                                            ],
                                          ),
                                          progressColor: ColorApp.darkRed,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 30),
                                  GetBuilder<SubscriptionController>(
                                      builder: (subscriptionController) {
                                    return HandlingStatusRemotDataRequest(
                                        statusRequest: subscriptionController
                                            .statusRequest,
                                        widget: ItemInfo(
                                          title: "Courses".tr,
                                          widget: DropdownButton<String>(
                                            iconEnabledColor: ColorApp.darkRed,
                                            underline: Text(""),
                                            value: subscriptionController
                                                .Courses.toString(),
                                            items: subscriptionController
                                                .dataCourses
                                                .map<DropdownMenuItem<String>>(
                                                    (subscription) {
                                              return DropdownMenuItem<String>(
                                                value: subscription.coursesId
                                                    .toString(),
                                                child: Text(
                                                  subscription.coursesName
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge!
                                                      .copyWith(
                                                        color:
                                                            ColorApp.middleRed,
                                                        fontSize: 15,
                                                      ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              subscriptionController.Courses =
                                                  int.parse(newValue!);
                                              subscriptionController
                                                  .CaculetPrice();
                                              subscriptionController.update();
                                              print(subscriptionController
                                                  .Courses);
                                            },
                                          ),
                                        ));
                                  }),
                                  SizedBox(height: 10),
                                  GetBuilder<SubscriptionController>(
                                    builder: (subscriptionController) {
                                      return HandlingStatusRemotDataView(
                                        statusRequest: subscriptionController
                                            .statusRequest,
                                        widget: Neumorphic(
                                          style: NeumorphicStyle(depth: -25),
                                          child: Container(
                                            height: 250,
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: GridView(
                                              physics: BouncingScrollPhysics(),
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                mainAxisSpacing: 20,
                                                crossAxisSpacing: 90,
                                              ),
                                              children: [
                                                ItemInfo(
                                                  title: "Type".tr,
                                                  widget:
                                                      DropdownButton<String>(
                                                    iconEnabledColor:
                                                        ColorApp.darkRed,
                                                    underline: Text(""),
                                                    value:
                                                        subscriptionController
                                                            .TypeSub.toString(),
                                                    items: subscriptionController
                                                        .dataTypeSubscription
                                                        .map<
                                                                DropdownMenuItem<
                                                                    String>>(
                                                            (subscription) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: subscription
                                                            .typeSubId
                                                            .toString(),
                                                        child: Text(
                                                          subscription
                                                              .typeSubName
                                                              .toString(),
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .displaySmall!
                                                                  .copyWith(
                                                                    fontSize:
                                                                        12,
                                                                    color: ColorApp
                                                                        .lightBlack,
                                                                  ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      );
                                                    }).toList(),
                                                    onChanged: (newValue) {
                                                      subscriptionController
                                                              .TypeSub =
                                                          int.parse(newValue!);
                                                      subscriptionController
                                                          .CaculetPrice();
                                                      subscriptionController
                                                          .update();
                                                    },
                                                  ),
                                                ),
                                                ItemInfo(
                                                  title: "Couch".tr,
                                                  widget:
                                                      DropdownButton<String>(
                                                    iconEnabledColor:
                                                        ColorApp.darkRed,
                                                    underline: Text(""),
                                                    value:
                                                        subscriptionController
                                                            .Couch.toString(),
                                                    items: subscriptionController
                                                        .dataCoach
                                                        .map<
                                                                DropdownMenuItem<
                                                                    String>>(
                                                            (subscription) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: subscription
                                                            .coachId
                                                            .toString(),
                                                        child: Text(
                                                          subscription.coachName
                                                              .toString(),
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .displaySmall!
                                                                  .copyWith(
                                                                    fontSize:
                                                                        12,
                                                                    color: ColorApp
                                                                        .lightBlack,
                                                                  ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      );
                                                    }).toList(),
                                                    onChanged: (newValue) {
                                                      subscriptionController
                                                              .Couch =
                                                          int.parse(newValue!);
                                                      subscriptionController
                                                          .CaculetPrice();
                                                      subscriptionController
                                                          .update();
                                                      print(
                                                          subscriptionController
                                                              .Couch);
                                                    },
                                                  ),
                                                ),
                                                ItemInfo(
                                                  title: "Services".tr,
                                                  widget:
                                                      DropdownButton<String>(
                                                    iconEnabledColor:
                                                        ColorApp.darkRed,
                                                    underline: Text(""),
                                                    value:
                                                        subscriptionController
                                                                .Services
                                                            .toString(),
                                                    items: subscriptionController
                                                        .dataServices
                                                        .map<
                                                                DropdownMenuItem<
                                                                    String>>(
                                                            (subscription) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: subscription
                                                            .servicesId
                                                            .toString(),
                                                        child: Text(
                                                          subscription
                                                              .servicesName
                                                              .toString(),
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .displaySmall!
                                                                  .copyWith(
                                                                    fontSize:
                                                                        12,
                                                                    color: ColorApp
                                                                        .lightBlack,
                                                                  ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      );
                                                    }).toList(),
                                                    onChanged: (newValue) {
                                                      subscriptionController
                                                              .Services =
                                                          int.parse(newValue!);
                                                      subscriptionController
                                                          .CaculetPrice();
                                                      subscriptionController
                                                          .update();
                                                      print(
                                                          subscriptionController
                                                              .Services);
                                                    },
                                                  ),
                                                ),
                                                ItemInfo(
                                                  title: "Fee".tr,
                                                  widget: Text(
                                                    "${subscriptionController.totalPrice} \$",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displaySmall!
                                                        .copyWith(
                                                          fontSize: 12,
                                                          color: ColorApp
                                                              .lightBlack,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(height: 30),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 25),
                                    child: GetBuilder<SubscriptionController>(
                                      builder: (subscriptionController) =>
                                          NeumorphicButton(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Icon(
                                              Icons.fiber_new_outlined,
                                              size: 50,
                                              color: ColorApp.middleRed,
                                            ),
                                            Text(
                                              "Submitsubscription".tr,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displaySmall!
                                                  .copyWith(
                                                    color: ColorApp.lightBlack,
                                                    fontSize: 12,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        style: NeumorphicStyle(
                                          color: ColorApp.bgMain,
                                          depth: 5,
                                        ),
                                        onPressed: () {
                                          subscriptionController
                                              .SubmitSubscription(context);
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
            }
          },
        ),
      ),
    );
  }
}

class ItemInfo extends StatelessWidget {
  ItemInfo({Key? key, required this.title, required this.widget})
      : super(key: key);
  final String title;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    SubscriptionController subscriptionController =
        Get.put(SubscriptionController());
    return Container(
      child: Neumorphic(
        style: NeumorphicStyle(depth: 2, shape: NeumorphicShape.flat),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(color: ColorApp.darkBlack, fontSize: 12),
            ),
            SizedBox(
              height: 10,
            ),
            widget,
          ],
        ),
      ),
    );
  }
}
