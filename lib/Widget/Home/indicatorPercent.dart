import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../Controller/Home/basicScreenController.dart';
import '../../Core/Constant/color.dart';

class IndicatorPercent extends StatelessWidget {
  final String title;
  final double percent ;
  const IndicatorPercent({
    Key? key,
    required this.title, required this.percent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BasicScreenController basicScreenController =
        Get.put(BasicScreenController());
    return Container(
      height: 103,
      width: 50,
      child: NeumorphicButton(
          provideHapticFeedback: false,
          onPressed: () {},
          style: NeumorphicStyle(
            shape: NeumorphicShape.concave,
            depth: 1,
          ),
          padding: EdgeInsets.all(5),
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: NeumorphicIndicator(orientation: NeumorphicIndicatorOrientation.vertical,
                  style: IndicatorStyle(depth: -5,
                      variant: ColorApp.middleRed,
                    accent: ColorApp.darkRed,

                  ),
                  percent: percent,
                ),
              ),
              Expanded(flex: 1, child: Text(title))
            ],
          )),
    );
  }
}
