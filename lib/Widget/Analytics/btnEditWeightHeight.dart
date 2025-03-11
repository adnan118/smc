import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Controller/Analytics/analytics.dart';
import '../../Core/Constant/color.dart';
import '../../Core/Function/validinput.dart';

class BtnEditWeightHeight extends StatelessWidget {
  final AnalyticsController analyticsController =
      Get.put(AnalyticsController());

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      onPressed: () async {

        SharedPreferences prefs = await SharedPreferences.getInstance();

        DateTime now = DateTime.now();
        print(now.month==analyticsController.month.last);
        if (true) {

          if ( now.month.toString()==analyticsController.month.last.toString()) {
            // إذا كان الفرق أقل من 30 يومًا، اعرض رسالة تنبيه
            Get.snackbar(
              'Alert'.tr,
              'Youcanonlyeditonceamonth'.tr,
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: ColorApp.darkRed,
              overlayBlur: 2,
              duration: Duration(seconds: 4),

              colorText: ColorApp.bacground,
            );
            return;
          }
        }
         Get.bottomSheet(
          Container(
            decoration: BoxDecoration(
              color: ColorApp.bgMain,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            padding: EdgeInsets.all(20),
            child: Form(
              key: analyticsController.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Neumorphic(
                    style: NeumorphicStyle(
                      depth: -5,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(10)),
                    ),
                    child: TextFormField(
                      cursorColor: ColorApp.middleRed,
                      style: Theme.of(context).textTheme.displaySmall,
                      validator: (val) {
                        return validinput(val!, 1, 3, "");
                      },
                      controller: analyticsController.heightController,
                      decoration: InputDecoration(
                          labelText: "Enterheight".tr,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          labelStyle: TextStyle(color: ColorApp.lightBlack)),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(height: 20),
                  Neumorphic(
                    style: NeumorphicStyle(
                      depth: -5,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(10)),
                    ),
                    child: TextFormField(
                      cursorColor: ColorApp.middleRed,
                      style: Theme.of(context).textTheme.displaySmall,
                      controller: analyticsController.weightController,
                      decoration: InputDecoration(
                          labelText: "Enterweight".tr,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          labelStyle: TextStyle(color: ColorApp.lightBlack)),
                      keyboardType: TextInputType.number,
                      validator: (val) {
                        return validinput(val!, 1, 3, "");
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.displaySmall,
                      primary: ColorApp.darkRed,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),padding: EdgeInsets.all(11)
                    ),
                    onPressed: () async {
                      if (analyticsController.formKey.currentState
                              ?.validate() ??
                          false) {
                        // الحصول على القيم المدخلة إذا كانت صالحة
                        String height =
                            analyticsController.heightController.text;
                        String weight =
                            analyticsController.weightController.text;
                        // القيام بأي عملية حفظ أو معالجة مطلوبة
                        print('Height: $height, Weight: $weight');

                        // حفظ تاريخ الإدخال الحالي
                        await prefs.setString(
                            'lastEntryDate', now.toIso8601String());
                        analyticsController.inserAWH();


                        // إغلاق الـ BottomSheet
                        Get.back();
                      }
                    },
                    child: Text("Save".tr),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: Text(
        "EditWeight".tr,
        style: TextStyle(
          color: ColorApp.lightRed,
          fontSize: 12,
          fontFamily: "Exo",
        ),
      ),
    );
  }
}
