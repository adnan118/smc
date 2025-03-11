import 'package:fancy_drawer/fancy_drawer.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'dart:ui' as ui;
import '../../Classes/handlingStatusRemotDataView.dart';
import '../../Controller/Home/basicScreenController.dart';
import '../../Core/Constant/color.dart';
import 'dart:math' as math;

import '../../Widget/Sport/infoSport.dart';
import '../../Widget/Sport/slidingCardView.dart';
import '../../Widget/Sport/slidingCardViewCouch.dart';


class Sports extends StatefulWidget {
  const Sports({Key? key}) : super(key: key);

  @override
  State<Sports> createState() => _SportsState();
}

class _SportsState extends State<Sports> with SingleTickerProviderStateMixin {
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
    return Scaffold(
        appBar: AppBar(
          elevation: 3.0,
          title: Text(
            "Sports",
            style: Theme
                .of(context)
                .textTheme
                .bodyLarge,
          ),
          backgroundColor: ColorApp.bgMain,
        ),
        body: Neumorphic(
          child:
          ListView(
            children: [



          ListTile(
            title: Text(
              "All Sports",
              style: Theme
                  .of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(
                  color: ColorApp.darkBlack,
                  fontSize: 15),
            ),
          ),
          SlidingCardView(),
              InfoSport(),
          ListTile(
            title: Text(
              "Couches",
              style: Theme
                  .of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(
                  color: ColorApp.darkBlack,
                  fontSize: 15),
            ),
          ),
          SlidingCardViewCouch(),
              NeumorphicButton(
                  margin: EdgeInsets.symmetric(horizontal: 105,vertical: 30),
                  style: NeumorphicStyle(color: ColorApp.darkRed,depth: -3,),
                  onPressed: () {  Get.toNamed("/ViewAndRenewsubscription");},
                  child: Text(
                    "Confirm Subscription",
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(color: ColorApp.bacground, fontSize: 11),
                  ),
                ),


]

    )
    ));
  }
}
