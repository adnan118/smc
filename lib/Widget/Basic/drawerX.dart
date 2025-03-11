import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:smc/Classes/handlingStatusRemotDataView.dart';

import '../../Controller/Home/profileController.dart';
import '../../Controller/Subscription/subscriptionController.dart';
import '../../Core/Constant/color.dart';
import '../../Core/Constant/imageasset.dart';
import '../../Core/Services/services.dart';
import '../../Screen/Profile/drawerXProfile.dart';
import '../../Screen/Profile/drawerXProfileEdit.dart';
import '../Home/avatarImage.dart';
import '../Home/btnRegDay.dart';
import '../Home/connectionData.dart';

class DrawerX extends StatelessWidget {
  const DrawerX({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ViewProfileController viewProfileController =
        Get.put(ViewProfileController());

    return GetBuilder<ViewProfileController>(
        builder: (controller) => HandlingStatusRemotDataView(
            statusRequest: controller.statusRequest,
            widget: viewProfileController.profile_OR_editprofile == "profile"
                ? DrawerXProfile()
                : DrawerXProfileEdit()));
  }
}
