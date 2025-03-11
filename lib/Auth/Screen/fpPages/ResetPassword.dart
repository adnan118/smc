import '../../../Classes/handlingStatusRemotDataView.dart';
import '../../../Core/Constant/imageasset.dart';
import '../../../Core/Function/validinput.dart';
import '../../../Core/Localization/changelocal.dart';
import '../../../core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/fg_password/ResetPassword_Controller.dart';
import '../../Widget/customButtomAuth.dart';
import '../../Widget/customTextFormAuth.dart';

class ResetPassword extends GetView<LocalController> {
  ResetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ResetPassword_Controller resetPassword_Controller =
        Get.put(ResetPassword_Controller());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorApp.bacground,
          elevation: 0,
          centerTitle: true,
          title: Text("titleRestPassword".tr,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: ColorApp.lightBlack,
                  )),
          leading: Text(""),
        ),
        body: Stack(children: [
          Image.asset(
            ImageAssetApp.Resetpass,
            height: 450,
            width: double.infinity,
          ),
          GetBuilder<ResetPassword_Controller>(
              builder: (resetPassword_Controller) =>
                  HandlingStatusRemotDataRequest(
                      statusRequest: resetPassword_Controller.statusRequest,
                      widget: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 40),
                          child: Form(
                            key: resetPassword_Controller.myKeyRs,
                            child: ListView(
                              physics: BouncingScrollPhysics(),
                              children: [
                                Text(
                                  "bodyRestPassword".tr,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 280,
                                ),
                                CustomTextFormAuth(
                                  title: "fildPasswordRestPassword".tr,
                                  hint: "********",
                                  keyboardTypex: TextInputType.text,
                                  myController:
                                      resetPassword_Controller.password,
                                  obscureText: resetPassword_Controller.isShowPassword1,
                                  valid: (val) {
                                    return validinput(val!, 4, 13, "password");
                                  },
                                  onTapicon: (){resetPassword_Controller.funShowPassword(1);},
                                   icon: resetPassword_Controller.IconDataPassword1,
                                ),
                                CustomTextFormAuth(
                                  title: "fildRePasswordRestPassword".tr,
                                  hint: "********",
                                  keyboardTypex: TextInputType.text,
                                  myController:
                                  resetPassword_Controller.repassword,
                                  obscureText: resetPassword_Controller.isShowPassword2,
                                  valid: (val) {
                                    return validinput(val!, 4, 13, "password");
                                  },
                                  onTapicon: (){resetPassword_Controller.funShowPassword(2);},
                                  icon: resetPassword_Controller.IconDataPassword2,
                                ),
                                CustomButtomAuth(
                                  text: "CheckPass".tr,
                                  onPressed: () {
                                    resetPassword_Controller
                                        .SuccsessResetPage();
                                  },
                                  colorText: ColorApp.bacground,
                                  colorBg: ColorApp.darkRed,
                                  elevation: 5,
                                ),
                              ],
                            ),
                          )))
          )
        ]));
  }
}
