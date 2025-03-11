import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';

import '../../Core/Constant/color.dart';

class BtnBack extends StatelessWidget {
  const BtnBack({Key? key, })
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return      NeumorphicButton(
      style: NeumorphicStyle(
          boxShape: NeumorphicBoxShape.circle()),
      onPressed: () async {
        Get.back(canPop: true);
        Get.offAllNamed("/");

      },
      child: Image.asset(
        'assets/images/backDouble.png',
        width: 25,

      ),
    );
  }
}
