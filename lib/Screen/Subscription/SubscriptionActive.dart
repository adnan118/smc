import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:smc/Classes/handlingStatusRemotDataView.dart';
import 'package:smc/Core/Constant/color.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Controller/Home/basicScreenController.dart';
import '../../Controller/Subscription/subscriptionController.dart';
import '../../Widget/Home/cardTopInfoUser.dart';
import '../../Widget/Home/connectionData.dart';

class SubscriptionActive extends StatelessWidget {
  SubscriptionActive({Key? key}) : super(key: key);
  final SubscriptionController subscriptionController = Get.put(SubscriptionController());

  @override
  Widget build(BuildContext context) {
    return

      GetBuilder<SubscriptionController>(
      builder: (subscriptionController) =>
        HandlingStatusRemotDataView(
          statusRequest: subscriptionController.statusRequest,
          widget:subscriptionController.dataSubscription.isEmpty?Center(child: CircularProgressIndicator(color: ColorApp.darkRed,),): Neumorphic(
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
                              " ${subscriptionController.dataSubscription[0].subApprove == 1 ? 'Approve'.tr : subscriptionController.dataSubscription[0].subApprove == 0 ? 'Process'.tr : 'Unacceptable'.tr}",
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
                  SizedBox(
                    height: 30,
                  ),
                  ItemInfo(
                    title: "Courses".tr,
                    widget:  Text(subscriptionController.convertCourses(subscriptionController.dataSubscription[0].subCourse,)
                        .toString(),
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorApp.middleRed),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  GetBuilder<SubscriptionController>(
                    builder: (subscriptionController) {
                      return HandlingStatusRemotDataView(
                        statusRequest: subscriptionController.statusRequest,
                        widget: Neumorphic(
                          style: NeumorphicStyle(depth: -25),
                          child: Container(
                            height: 250,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: GridView(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 20,
                                crossAxisSpacing: 90,
                              ),
                              children: [
                                ItemInfo(
                                  title: "Type".tr,
                                  widget: Text(subscriptionController.convertType(subscriptionController.dataSubscription[0].subType,)
                                      .toString(),
                                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                      fontSize: 12,
                                      color: ColorApp.lightBlack,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),

                                ItemInfo(
                                  title: "Couch".tr,
                                  widget: Column(children: [
                                    Text("${subscriptionController.convertCouch(subscriptionController.dataSubscription[0].subCouch,)}"
                                      ,
                                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                        fontSize: 12,
                                        color: ColorApp.lightBlack,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                 InkWell(child:     Text("${subscriptionController.convertCouchPhone(subscriptionController.dataSubscription[0].subCouch,) }"
                                   ,
                                   style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                     fontSize: 12,
                                     color: ColorApp.middleRed,
                                   ),
                                   overflow: TextOverflow.ellipsis,
                                 ),onTap: (){ launchUrl(Uri.parse("tel:${subscriptionController.convertCouchPhone(subscriptionController.dataSubscription[0].subCouch,) }"));},)

                                  ],)
                                ),

                                ItemInfo(
                                  title: "Services".tr,
                                  widget:  Text(subscriptionController.convertServices(subscriptionController.dataSubscription[0].subServices,)
                                      .toString(),
                                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                      fontSize: 12,
                                      color: ColorApp.lightBlack,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                ItemInfo(
                                  title: "Fee".tr,
                                  widget: Text(
                                    "${subscriptionController.dataSubscription[0].subFee} \$",
                                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                      fontSize: 12,
                                      color: ColorApp.lightBlack,
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
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),

    );
  }
}

class ItemInfo extends StatelessWidget {
  final String title;
  final Widget widget;

  ItemInfo({Key? key, required this.title, required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(depth: 2, shape: NeumorphicShape.flat),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorApp.darkBlack, fontSize: 12),
          ),
          SizedBox(
            height: 10,
          ),
          widget,
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
