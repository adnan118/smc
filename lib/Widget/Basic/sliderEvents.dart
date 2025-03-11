/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../Controller/Home/basicScreenController.dart';
import '../../Controller/Home/statusController.dart';
import '../../Core/Constant/color.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'dart:ui' as ui;

class SliderEvents extends StatelessWidget {
  SliderEvents({Key? key}) : super(key: key);
  StatusController statusController =
      Get.put(StatusController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BasicScreenController>(
        builder: (basicScreenController) => Stack(
              fit: StackFit.expand,
              children: [
                Neumorphic(
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        color: Colors.black12,
                        child: Row(
                          children: [
                            BtnRegDay()
                          ],
                        )

                        )),

                statusController.visiableBlur ==1?
                BackdropFilter(
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
                          size: 50,style: NeumorphicStyle(color: ColorApp.middleRed,),
                        ),
                        value: 1,
                        onChanged: (v) {
                          statusController.imgMode='assets/lottie/break.json';
                          statusController.visiableBlur=0;
                          statusController.titleMode="Break";
                          basicScreenController.rf();
                        },
                      ),
                      NeumorphicRadio(
                        groupValue: "mode",
                        child: NeumorphicIcon(
                          Icons.nights_stay_outlined,
                          size: 50,style: NeumorphicStyle(color: ColorApp.middleRed),
                        ),
                        value: 2,
                        onChanged: (v) {
                          statusController.imgMode='assets/lottie/sleeping.json';
                          statusController.visiableBlur=0;
                          statusController.titleMode="Sleep";
                          basicScreenController.rf();
                        },
                      ),
                      NeumorphicRadio(
                        groupValue: "mode",
                        child: NeumorphicIcon(
                          Icons.data_saver_off_rounded,
                          size: 50,style: NeumorphicStyle(color: ColorApp.middleRed),
                        ),
                        value: 3,
                        onChanged: (v) {
                          statusController.imgMode='assets/lottie/play.json';
                          statusController.visiableBlur=0;
                          statusController.titleMode="Training";
                          basicScreenController.rf();
                        },
                      )
                    ],
                  ),
                ):   ImgMode(),
              ],
            ));
  }
}






class BtnRegDay extends StatelessWidget {
  const BtnRegDay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BasicScreenController basicScreenController =
    Get.put(BasicScreenController());
    return  NeumorphicButton(
      provideHapticFeedback: true,
      style: NeumorphicStyle(
        boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.circular(100)),
        shape: NeumorphicShape.convex,
        depth: 5,
      ),
      onPressed: () {
        Get.toNamed("/ViewAndRenewsubscription");
      },
      child: CircularPercentIndicator(
        //   linearGradient: LinearGradient(begin:Alignment.bottomLeft,end: Alignment.bottomRight,colors: [ColorApp.blue,ColorApp.darkRed],stops:[0.1,0.9]),
        radius: 50.0,
        lineWidth: 10,
        percent: basicScreenController.perStep,
        center: Text("14 day "),
        progressColor:
        basicScreenController.perStep > 0.5
            ? ColorApp.blue
            : ColorApp.darkRed,
      ),
    );
  }
}


class ImgMode extends StatelessWidget {
  const ImgMode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StatusController statusController =
    Get.put(StatusController());
    return     Positioned(
        left: 160,
        top: 80,
        child: Container(
          width: 150,
          height: 200,
          child:
          // Lottie.asset('assets/lottie/sleeping.json', ),
          //    Lottie.asset('assets/lottie/play.json', ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                NeumorphicSwitch(
                  value: statusController.clickToStart,
                  height: 30,
                  style: NeumorphicSwitchStyle(activeTrackColor: ColorApp.middleRed),
                  onChanged: (v){
                    statusController.clickToStart= statusController.clickToStart==false?true:false;

                  },

                ),
                Text("${DateTime.now().hour} h - ${DateTime.now().minute} m")
              ],),
              InkWell(
                onTap: (){
                  statusController.visiableBlur=1;
                  print( statusController.visiableBlur);

                },
                child:  Lottie.asset(statusController.imgMode),
              ),
            ],
          )
        ));
  }
}
*/