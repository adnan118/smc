import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../Controller/Home/basicScreenController.dart';
import '../../Core/Constant/color.dart';

class CardInfo extends StatelessWidget {
  final String header;
  final String footer;
  final Color color;
  final double percent ;
  final String img ;
  const CardInfo({Key? key, required this.header, required this.footer, required this.color,  required this.percent, required this.img}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BasicScreenController basicScreenController =
    Get.put(BasicScreenController());
    return   Container(
        height: 120,

        child: Column(
          children: [
            NeumorphicButton(
              provideHapticFeedback: false,


              onPressed: () {},
              style: NeumorphicStyle(
                shape: NeumorphicShape.concave,
                depth: 2,
              ),
              padding: EdgeInsets.all(5),
              child: CircularPercentIndicator(
                header: Text(header ,style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorApp.darkBlack,fontSize: 10)),
                footer: Text(footer,style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorApp.darkBlack,fontSize: 10)),
                //   linearGradient: LinearGradient(begin:Alignment.bottomLeft,end: Alignment.bottomRight,colors: [ColorApp.blue,ColorApp.darkRed],stops:[0.1,0.9]),
                radius: 30.0,
                lineWidth: 3,
                percent: percent,
                center: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Image.asset(img,width: 40,)
                  ],
                ),
                progressColor:color,
              ),
            ),
          ],
        )
    );
  }
}