 import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:smc/Classes/handlingStatusRemotDataView.dart';
import 'package:smc/Core/Constant/color.dart';
import '../../Controller/Subscription/subscriptionController.dart';
import '../../DB/statusRequest.dart';

class SubscriptionProcess extends StatelessWidget {
  SubscriptionProcess({Key? key}) : super(key: key);
  final SubscriptionController subscriptionController = Get.put(SubscriptionController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubscriptionController>(
      builder: (subscriptionController) {
        print("Current page: ${subscriptionController.page}");
        if (subscriptionController.statusRequest == StatusRequest.loading) {
          return Center(child: CircularProgressIndicator());
        } else {
          return


            HandlingStatusRemotDataView(
            statusRequest: subscriptionController.statusRequest,
            widget: Neumorphic(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                            Row(children: [
                              Text(
                                "End".tr,
                                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                  color: ColorApp.darkBlack,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                " ${subscriptionController.dataSubscription[0].subEndDate.toString().substring(0, 10)} ",
                                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                  color: ColorApp.darkBlack,
                                  fontSize: 12,
                                ),
                              ),
                            ],),
                              Text(
                                " ${subscriptionController.dataSubscription[0].subApprove == 1 ? 'Approve'.tr : subscriptionController.dataSubscription[0].subApprove == 0 ? 'Process' : 'Unacceptable'}",
                                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                  color: subscriptionController.dataSubscription[0].subApprove == 1 ? ColorApp.green : subscriptionController.dataSubscription[0].subApprove == 0 ? ColorApp.orange : ColorApp.lightRed,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          CircularPercentIndicator(
                            radius: 50.0,
                            lineWidth: 10,
                            percent: subscriptionController.differenceInDays / subscriptionController.daysInMonth,
                            center: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${subscriptionController.differenceInDays} / ${subscriptionController.daysInMonth}",
                                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                    color: ColorApp.darkBlack,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "Day".tr,
                                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
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
                    ItemInfo(
                      title: "Courses".tr,
                      widget:  Text(subscriptionController.convertCourses(subscriptionController.dataSubscription[0].subCourse,)
                          .toString(),
                        style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorApp.middleRed),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),

          );
        }
      },
    );
  }
}

class ItemInfo extends StatelessWidget {
  ItemInfo({Key? key, required this.title, required this.widget}) : super(key: key);
  final String title;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Neumorphic(
        style: NeumorphicStyle(depth: 2, shape: NeumorphicShape.flat),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorApp.darkBlack, fontSize: 12),
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
