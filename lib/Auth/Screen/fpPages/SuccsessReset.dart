import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Core/Constant/color.dart';
import '../../../Core/Constant/imageasset.dart';
import '../../Controller/fg_password/SuccsessReset_Controller.dart';
import '../../Widget/customButtomAuth.dart';

class SuccsessReset extends StatelessWidget {
  const SuccsessReset({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SuccsessReset_Controller succsessReset_Controller =
        Get.put(SuccsessReset_Controller());

    return Scaffold (
      appBar: AppBar(
        backgroundColor: ColorApp.bacground,
        elevation: 0,
        centerTitle: true,
        title:    Text("titleCongratulations".tr,style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.grey) ),
        leading: Text(""),
      ),
      body: Form(
        key: succsessReset_Controller.myKeysu,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 40),
          child: Stack(

            children: [
              Image.asset(
                ImageAssetApp.SuccessReset,
                height: double.infinity,
                width: double.infinity,
              ),
              SizedBox(height: 100,),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                  Text("Successrepas".tr,style: Theme.of(context).textTheme.bodyLarge,textAlign: TextAlign.center,),
                  SizedBox(height: 50,),
                  Container(
                    width: double.infinity,
                    child: CustomButtomAuth(
                      elevation: 5,
                      colorText: ColorApp.bacground,
                      colorBg: ColorApp.darkRed,
                      text: "titlebtnSuccsessSignup".tr,
                      onPressed: (){
                        succsessReset_Controller.login();
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
