import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Classes/handlingStatusRemotDataView.dart';
import '../../../Core/Constant/color.dart';
import '../../../Core/Constant/imageasset.dart';
import '../../../Core/Function/validinput.dart';
import '../../../Core/Localization/changelocal.dart';
import '../../Controller/fg_password/FP_Controller.dart';
import '../../Widget/customButtomAuth.dart';
import '../../Widget/customTextFormAuth.dart';

class ForgetPassword extends GetView<LocalController> {
  ForgetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FP_Controller fp_controller = Get.put(FP_Controller());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorApp.bacground,
          elevation: 0,
          centerTitle: true,
          title: Text("titleFP".tr,
              style: Theme
                  .of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(
                color: ColorApp.lightBlack,
              )),
          leading: Text(""),
        ),
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
            child: Form(
                key: fp_controller.myKeyF,
                child: Stack(
                  children: [
                  Image.asset(
                  ImageAssetApp.Forgotpassword,
                  height: 450,
                  width: double.infinity,
                ),
                GetBuilder<FP_Controller>(
                    builder: (fp_controller) =>
                        HandlingStatusRemotDataRequest(
                            statusRequest: fp_controller.statusRequest,
                            widget: Container(
                                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                                child: ListView(
                                    children: [
                                      Text(
                                        "bodyFP".tr,
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .bodyLarge,
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(
                                        height: 300,
                                      ),
                                      CustomTextFormAuth(
                                        title: "Email",
                                        hint: "user@example.com",
                                        icon: Icons.email_outlined,
                                        myController: fp_controller.chKemail,
                                        keyboardTypex: TextInputType.text,
                                        obscureText: false,
                                        valid: (val) {
                                          return validinput(val!, 20, 30,
                                              "email");
                                        },
                                      ),
                                      CustomButtomAuth(
                                        text: "ChickEmailbtnFB".tr,
                                        onPressed: () {
                                          fp_controller.checkEmail();
                                        },
                                        colorBg: ColorApp.darkRed,
                                        colorText: ColorApp.middleRed,
                                        elevation: 5,
                                      ),
                                    ]
                                )
                            )
                        )
                )
                ]
            )
        )
    )
    );
  }
}
