import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Constant/color.dart';

Future<bool> AlertExitApp(){
   Get.defaultDialog(
    title: "Alert".tr,
    middleText: "bodyAlert".tr,titleStyle: TextStyle(fontSize: 22),
    actions: [
      ElevatedButton(
          style:  ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(ColorApp.darkRed),
      ),
           onPressed: (){
            exit(0);
          },
          child: Text("btnConfirm".tr,    style: TextStyle(fontSize: 12),
          )
      ),SizedBox(width: 30,),
      ElevatedButton(
          style:  ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(ColorApp.lightRed),
          ),
          onPressed: (){
            Get.back();
          },
          child: Text("btnCancel".tr,style: TextStyle(fontSize: 12),)
      ),
    ]
  );


   return Future.value(true);
}