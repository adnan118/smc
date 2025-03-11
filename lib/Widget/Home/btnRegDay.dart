import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../Controller/Home/basicScreenController.dart';
import '../../Controller/Subscription/subscriptionController.dart';
import '../../Core/Constant/color.dart';

class BtnRegDay extends StatelessWidget {
  const BtnRegDay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SubscriptionController subscriptionController =
        Get.put(SubscriptionController());
    BasicScreenController basicScreenController =
        Get.put(BasicScreenController());
    return MaterialButton(
      onPressed: () {
        Get.toNamed("/ViewAndRenewsubscription");
      },
      child: CircularPercentIndicator(
        radius: 35.0,
        lineWidth: 5,
        percent: subscriptionController.differenceInDays / subscriptionController.daysInMonth,
        center:  Column(
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
        progressColor: basicScreenController.perStep > 0.5
            ? ColorApp.darkRed
            : ColorApp.darkRed,
      ),
    );
  }
}
