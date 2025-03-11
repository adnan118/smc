import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../../Controller/Store/storeController.dart';
import '../../Core/Constant/color.dart';
import 'package:flutter/cupertino.dart';


class BtnBillsStore extends StatefulWidget {
  BtnBillsStore({
    Key? key,
  }) : super(key: key);

  @override
  _BtnBillsStoreState createState() => _BtnBillsStoreState();
}

class _BtnBillsStoreState extends State<BtnBillsStore> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreController>(
        builder: (storeController) => NeumorphicButton(
            style: NeumorphicStyle(depth: 3),
            margin: EdgeInsets.symmetric(
              horizontal: 5,
            ),
            tooltip: "Bills".tr,
            onPressed: () async {
              storeController.goToInvoiceAll();
            },
            child: Row(
              children: [
                NeumorphicIcon(
                  Icons.inventory_outlined,
                  style: NeumorphicStyle(color: ColorApp.darkBlack),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Bills".tr,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(color: ColorApp.darkBlack),
                ),
              ],
            )));
  }
}
