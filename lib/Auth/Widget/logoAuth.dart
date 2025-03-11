
import 'package:flutter/material.dart';

import '../../Core/Constant/imageasset.dart';

class LogoAuth extends StatelessWidget {
  const LogoAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(ImageAssetApp.logo,height:125,);
  }
}
