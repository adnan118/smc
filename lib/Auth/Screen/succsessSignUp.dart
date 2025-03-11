
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Core/Constant/color.dart';
import '../../Core/Constant/imageasset.dart';
import '../Controller/signUp_Controller.dart';
import '../Widget/customButtomAuth.dart';

class SuccsessSignUp extends StatelessWidget {
  const SuccsessSignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SignUp_Controller signUp_Controller =Get.put(SignUp_Controller());

    return Scaffold (
      appBar: AppBar(
          backgroundColor: ColorApp.bacground,
          elevation: 0,
          centerTitle: true,
          title:    Text("titleCongratulations".tr,style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.grey) ),
          leading: Text(""),
      ),
      body: Form(
        key: signUp_Controller.myKeyS,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 40),
          child: Stack(

            children: [
              Image.asset(
                ImageAssetApp.Congratulations,
                height: double.infinity,
                width: double.infinity,
              ),
              SizedBox(height: 100,),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                  Text("SuccessSignUp".tr,style: Theme.of(context).textTheme.bodyLarge,textAlign: TextAlign.center,),
                  SizedBox(height: 50,),
                  Container(
                    width: double.infinity,
                    child: CustomButtomAuth(
                      elevation: 5,
                      colorText: ColorApp.bacground,
                      colorBg: ColorApp.darkRed,
                      text: "titlebtnSuccsessSignup".tr,
                      onPressed: (){
                        signUp_Controller.login();
                      } ,
                    ),
                  )
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}
