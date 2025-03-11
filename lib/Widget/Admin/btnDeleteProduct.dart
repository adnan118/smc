import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:smc/Classes/handlingStatusRemotDataView.dart';
import '../../Controller/Store/storeController.dart';
import '../../Core/Constant/color.dart';

import 'package:flutter/cupertino.dart';

import '../../Core/Localization/translateDB.dart';
import 'btnEditProduct.dart';


class BtnDeleteProduct extends StatefulWidget {
  BtnDeleteProduct(
      {Key? key, required this.productID,
      })
      : super(key: key);
final String ?productID;

  @override
  _BtnDeleteProductState createState() => _BtnDeleteProductState();
}

class _BtnDeleteProductState extends State<BtnDeleteProduct> {
  @override
  Widget build(BuildContext context) {
    final StoreController storeController = Get.put(StoreController());

    return GetBuilder<StoreController>(
        builder: (storeController) => NeumorphicButton(
            margin: EdgeInsets.symmetric(
              horizontal: 5,
            ),
            tooltip: "Delete".tr,
            onPressed: () async {
              if (storeController.selectedProductID == 0) {
                Get.snackbar("", "",
                    titleText: Text(
                      "SMC",
                      style: Theme
                          .of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(color: ColorApp.darkRed, fontSize: 15),
                    ),
                    messageText: Text(
                      "Selectaproduct".tr,
                      style: Theme
                          .of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(color: ColorApp.lightBlack, fontSize: 13),
                    ),
                    duration: Duration(seconds: 8),
                    icon: Icon(
                      Icons.warning_amber,
                      color: ColorApp.darkRed,
                    ));
              } else {
               storeController.StoreDelete(widget.productID) ;
              }
            },child: Row(
          children: [
            NeumorphicIcon(
              Icons.playlist_remove,
              style: NeumorphicStyle(
                  color: ColorApp.darkBlack),size: 15,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "Delete".tr,
              style: Theme.of(context).textTheme.displaySmall!.copyWith(

                  color: storeController.selectedProductQUNTY != 0
                      ? ColorApp.darkRed
                      : ColorApp.lightBlack
                  ,fontSize: 13
              ),
            ),
          ],
        ),
              )
    );
}
}
