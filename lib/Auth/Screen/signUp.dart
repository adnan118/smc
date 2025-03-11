import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Classes/handlingStatusRemotDataView.dart';
import '../../Core/Constant/color.dart';
import '../../Core/Constant/imageasset.dart';
import '../../Core/Function/alertExitApp.dart';
import '../../Core/Function/validinput.dart';
import '../../Core/Localization/changelocal.dart';
import '../../DB/CRUD.dart';
import '../Controller/signUp_Controller.dart';
import '../Widget/customButtomAuth.dart';
import '../Widget/customTextFormAuth.dart';
import '../Widget/logoAuth.dart';

class SignUp extends StatelessWidget {
  //GetView<LocalController> لاجل حفظ الاعدادات المختارة -المستخدم- اللغة
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SignUp_Controller signUp_Controller = Get.put(SignUp_Controller());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorApp.bacground,
        elevation: 0,
        centerTitle: true,
        title: Text("titleBtnAuthSignUp".tr,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: ColorApp.lightBlack,
                )),
        leading: Text(""),
      ),
      body: GetBuilder<SignUp_Controller>(
          builder: (signUp_Controller) => HandlingStatusRemotDataRequest(
              statusRequest: signUp_Controller.statusRequest,
              widget: WillPopScope(
                  onWillPop: AlertExitApp,
                  child: SafeArea(
                      child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 40),
                          child: Form(

                            key: signUp_Controller.myKeyS,
                            child: ListView(
                              physics: BouncingScrollPhysics(),
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                /*
                      شهادة نظام إدارة الجودة في فندق HOTEQ 500 تشير إلى أن الفندق قد حصل على شهادة تثبت أنه يتبع معايير عالية لضمان جودة الخدمات التي يقدمها.
                      يعني ذلك أن الفندق يدير عملياته بطريقة مرنة وفعالة لضمان رضا
                       العملاء وتلبية احتياجاتهم بشكل مستمر. تلك الشهادة تعكس التزام الفندق بتحقيق أعلى معايير الجودة وتحسين أدائه بشكل مستمر.
                      */
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    LogoAuth(),
                                  //  Image.asset(     ImageAssetApp.HQ500,                  height: 70,                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "WelcomApp".tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(color: ColorApp.darkBlack),
                                  textAlign: TextAlign.center,
                                ),

                                Text(
                                  "WelcomAppHint".tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          fontSize: 11, color: Colors.grey),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                CustomTextFormAuth(
                                  title: "fildUsername".tr,
                                  hint: "adnan",
                                  obscureText: false,
                                  icon: Icons.alternate_email_outlined,
                                  myController: signUp_Controller.username,
                                  keyboardTypex: TextInputType.text,
                                  valid: (val) {
                                    return validinput(val!, 3, 10, "username");
                                  },
                                ),
                                CustomTextFormAuth(
                                  title: "fildFullname".tr,
                                  hint: "adnan barakat",
                                  obscureText: false,
                                  icon: Icons.perm_identity,
                                  myController: signUp_Controller.fullname,
                                  keyboardTypex: TextInputType.text,
                                  valid: (val) {
                                    return validinput(val!, 3, 25, "fullname");
                                  },
                                ),
                                CustomTextFormAuth(
                                  title: "fildEmail".tr,
                                  hint: "user@example.com",
                                  icon: Icons.email_outlined,
                                  myController: signUp_Controller.email,
                                  keyboardTypex: TextInputType.text,
                                  obscureText: false,
                                  valid: (val) {
                                    return validinput(val!, 5, 30, "email");
                                  },
                                ),
                                CustomTextFormAuth(
                                  title: "fildPhone".tr,
                                  hint: "0996183101",
                                  icon: Icons.phone,
                                  myController: signUp_Controller.phone,
                                  keyboardTypex:
                                      TextInputType.numberWithOptions(),
                                  obscureText: false,
                                  valid: (val) {
                                    return validinput(val!, 5, 30, "phone");
                                  },
                                ),
                                CustomTextFormAuth(
                                  title: "fildPassword".tr,
                                  hint: "********",
                                  obscureText: signUp_Controller.isShowPassword,
                                  icon: signUp_Controller.IconDataPassword,
                                  onTapicon: () {
                                    signUp_Controller.funShowPassword();
                                  },
                                  keyboardTypex: TextInputType.text,
                                  myController: signUp_Controller.password,
                                  valid: (val) {
                                    return validinput(val!, 4, 13, "password");
                                  },
                                ),

                                CustomButtomAuth(
                                  text: "titleBtnAuthSignUp".tr,
                                  onPressed: () {

                                    signUp_Controller.signUp();
                                  },
                                  colorBg: ColorApp.middleRed,
                                  colorText: ColorApp.bacground,
                                  elevation: 5,
                                ),
                                CustomButtomAuth(
                                  text: "titleBtnAuthLogin".tr,
                                  onPressed: () {
                                    signUp_Controller.login();
                                  },
                                  colorBg: ColorApp.darkRed,
                                  colorText: ColorApp.bacground,
                                  elevation: 0,
                                ),
                              ],
                            ),
                          )))))),
    );
  }
}
