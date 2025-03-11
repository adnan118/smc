import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../Controller/Home/basicScreenController.dart';
import '../../Core/Constant/color.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'dart:ui' as ui;
import '../../Controller/Home/statusController.dart'; // Import the StatusController

class CardTopInfoUser extends StatelessWidget {
  CardTopInfoUser({Key? key}) : super(key: key);
  BasicScreenController basicScreenController =
      Get.put(BasicScreenController());
  StatusController statusController =
      Get.put(StatusController()); // Initialize StatusController

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StatusController>(
      builder: (statusController) => Stack(
        fit: StackFit.expand,
        children: [
          Neumorphic(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              color: Colors.black12,
            ),
          ),
          statusController.visiableBlur == 1
              ? BackdropFilter(
                  filter: ui.ImageFilter.blur(
                    sigmaX: 10.0,
                    sigmaY: 10.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      NeumorphicRadio(
                        groupValue: "mode",
                        child: NeumorphicIcon(
                          Icons.free_breakfast_outlined,
                          size: 50,
                          style: NeumorphicStyle(
                            color: ColorApp.middleRed,
                          ),
                        ),
                        value: 1,
                        onChanged: (v) {  basicScreenController.rf();
                          statusController.imgMode = 'assets/lottie/Break.json';
                          statusController.visiableBlur = 0;
                          statusController.titleMode = "Break";
                      //  statusController.currentMode = "Break";

                          statusController .startTiming("Break"); // Start timing for Break
                          statusController .clickToStart=false; // Start timing for Break
                        statusController .stopTiming(); // Start timing for Break
                        },
                      ),
                      NeumorphicRadio(
                        groupValue: "mode",
                        child: NeumorphicIcon(
                          Icons.nights_stay_outlined,
                          size: 50,
                          style: NeumorphicStyle(color: ColorApp.middleRed),
                        ),
                        value: 2,
                        onChanged: (v) {
                          statusController.imgMode =
                              'assets/lottie/Sleep.json';
                          statusController.visiableBlur = 0;
                          statusController.titleMode = "Sleep";
                        //   statusController.currentMode = "Sleep";
                          basicScreenController.rf();
                          statusController
                              .startTiming("Sleep"); // Start timing for Sleep
                          statusController .clickToStart=false; // Start timing for Break
                          statusController .stopTiming(); // Start timing for Break
                        },
                      ),
                      NeumorphicRadio(
                        groupValue: "mode",
                        child: NeumorphicIcon(
                          Icons.data_saver_off_rounded,
                          size: 50,
                          style: NeumorphicStyle(color: ColorApp.middleRed),
                        ),
                        value: 3,
                        onChanged: (v) {
                          statusController.imgMode = 'assets/lottie/Training.json';
                          statusController.visiableBlur = 0;
                          statusController.titleMode = "Training";
                  // statusController.currentMode = "Training";
                          basicScreenController.rf();
                          statusController.startTiming(
                              "Training"); // Start timing for Training
                          statusController .clickToStart=false; // Start timing for Break
                          statusController .stopTiming(); // Start timing for Break
                        },
                      )
                    ],
                  ),
                )
              : ImgMode(),
        ],
      ),
    );
  }
}

class ImgMode extends StatelessWidget {
  const ImgMode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    StatusController statusController =
        Get.put(StatusController()); // Initialize StatusController
    return GetBuilder<StatusController>(
      builder: (statusController) => Positioned(
        left:  statusController.myservices.sharedPref
            .getString("myLang") ==
            "ar"
            ? 30
            :  130,
        top: 25,
        child: Container(
          width: 200,
          height: 170,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NeumorphicSwitch(
                    value: statusController.clickToStart,
                    height: 30,
                    style: NeumorphicSwitchStyle(
                      activeTrackColor: ColorApp.middleRed,
                    ),
                    onChanged: (v) {
                      print(v);
                      statusController.clickToStart = !statusController.clickToStart;
                      if (statusController.clickToStart) {
                        statusController.startTiming(statusController
                            .titleMode); // Start timing for the current mode
                      } else {
                        statusController.stopTiming(); // Stop timing
                      }
                      statusController.rf();
                    },
                  ),
                  Text(statusController.clickToStart == true?statusController.getCurrentModeDuration():"0 h - 0 m - 0 s"),
                  // Display calculated time
                ],
              ),
              InkWell(
                onTap: () {
                  statusController.rf();
                  statusController.visiableBlur = 1;
                  print(statusController.visiableBlur);
                  statusController.rf();
                },
                child: Lottie.asset(statusController.imgMode, width: 80),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
