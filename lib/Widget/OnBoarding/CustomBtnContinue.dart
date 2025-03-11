import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import '../../Controller/OnBoarding/onBoardingController.dart';
import '../../Core/Constant/color.dart';

class CustomBtnContinue extends GetView<OnBoardingControllerImp> {
  const CustomBtnContinue({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      height: 30,
      child: NeumorphicButton(

style: NeumorphicStyle(        color: ColorApp.darkRed,),
        padding: EdgeInsets.symmetric(horizontal: 50),
        onPressed: () {
          controller.next();
        },
        child: Text("btnContinue".tr, style: Theme.of(context).textTheme.displaySmall!.copyWith(color:ColorApp.bacground )),
      ),
    );
  }
}
