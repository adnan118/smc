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

class BtnViewProduct extends StatefulWidget {
  BtnViewProduct(
      {Key? key,
      required this.maxPieces,
      required this.price,
      required this.discount})
      : super(key: key);

  final int maxPieces;
  final int price;
  final int discount;

  @override
  _BtnViewProductState createState() => _BtnViewProductState();
}

class _BtnViewProductState extends State<BtnViewProduct> {
  @override
  Widget build(BuildContext context) {
    final StoreController storeController = Get.put(StoreController());
    final int maxPices;
    final int price;
    return GetBuilder<StoreController>(
        builder: (storeController) => NeumorphicButton(
            margin: EdgeInsets.symmetric(
              horizontal: 5,
            ),
            tooltip: "View".tr,
            onPressed: () async {
              if (storeController.selectedProductID == 0) {
                Get.snackbar("", "",
                    titleText: Text(
                      "SMC",
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(color: ColorApp.darkRed, fontSize: 15),
                    ),
                    messageText: Text(
                      "Selectaproduct".tr,
                      style: Theme.of(context)
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
                storeController.ship = 0;
                storeController.pice = 1;
                storeController.price = 0;
                Get.bottomSheet(
                  isScrollControlled: true,
                  GetBuilder<StoreController>(
                      builder: (storeController) => HandlingStatusRemotDataView(
                            statusRequest: storeController.statusRequest,
                            widget: Container(
                              decoration: BoxDecoration(
                                color: ColorApp.bgMain,
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20)),
                              ),
                              padding: EdgeInsets.all(20),
                              child: Form(
                                key: storeController.formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "Product-ID".tr,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall!
                                                .copyWith(
                                                    color: ColorApp.lightBlack,
                                                    fontSize: 12),
                                          ),
                                          flex: 2,
                                        ),
                                        Expanded(
                                          child: Neumorphic(
                                              padding: EdgeInsets.all(5),
                                              style: NeumorphicStyle(
                                                boxShape: NeumorphicBoxShape
                                                    .roundRect(
                                                        BorderRadius.circular(
                                                            10)),
                                              ),
                                              child: Center(
                                                  child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    ' # ${storeController.selectedProductID} ',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displaySmall!
                                                        .copyWith(
                                                            color: ColorApp
                                                                .darkRed,
                                                            fontSize: 14),
                                                  ),
                                                ],
                                              ))),
                                          flex: 3,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'ProductName'.tr + " :",
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall!
                                                .copyWith(
                                                    color: ColorApp.lightBlack,
                                                    fontSize: 12),
                                          ),
                                          flex: 2,
                                        ),
                                        Expanded(
                                          child: Neumorphic(
                                              padding: EdgeInsets.all(5),
                                              style: NeumorphicStyle(
                                                boxShape: NeumorphicBoxShape
                                                    .roundRect(
                                                        BorderRadius.circular(
                                                            10)),
                                              ),
                                              child: Center(
                                                  child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    '"${translateDB(
                                                      storeController
                                                          .selectedProductINAMEar,
                                                      storeController
                                                          .selectedProductINAME,
                                                    )}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displaySmall!
                                                        .copyWith(
                                                            color: ColorApp
                                                                .darkRed,
                                                            fontSize: 12),
                                                  ),
                                                ],
                                              ))),
                                          flex: 3,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Quantity'.tr,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall!
                                                .copyWith(
                                                    color: ColorApp.lightBlack,
                                                    fontSize: 12),
                                          ),
                                          flex: 2,
                                        ),
                                        Expanded(
                                          child: Neumorphic(
                                              padding: EdgeInsets.all(5),
                                              style: NeumorphicStyle(
                                                boxShape: NeumorphicBoxShape
                                                    .roundRect(
                                                        BorderRadius.circular(
                                                            10)),
                                              ),
                                              child: Center(
                                                  child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    ' ${widget.maxPieces} ',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displaySmall!
                                                        .copyWith(
                                                            color: ColorApp
                                                                .darkRed,
                                                            fontSize: 14),
                                                  ),
                                                  Text(
                                                    'PIC'.tr,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displaySmall!
                                                        .copyWith(
                                                            color: ColorApp
                                                                .darkRed,
                                                            fontSize: 14),
                                                  ),
                                                ],
                                              ))),
                                          flex: 3,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Price'.tr,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall!
                                                .copyWith(
                                                    color: ColorApp.lightBlack,
                                                    fontSize: 12),
                                          ),
                                          flex: 2,
                                        ),
                                        Expanded(
                                          child: Neumorphic(
                                              padding: EdgeInsets.all(5),
                                              style: NeumorphicStyle(
                                                boxShape: NeumorphicBoxShape
                                                    .roundRect(
                                                        BorderRadius.circular(
                                                            10)),
                                              ),
                                              child: Center(
                                                  child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    '${widget.price} \$',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displaySmall!
                                                        .copyWith(
                                                            color: ColorApp
                                                                .darkRed,
                                                            fontSize: 12),
                                                  ),
                                                ],
                                              ))),
                                          flex: 3,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Discount'.tr + " :",
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall!
                                                .copyWith(
                                                    color: ColorApp.lightBlack,
                                                    fontSize: 12),
                                          ),
                                          flex: 2,
                                        ),
                                        Expanded(
                                          child: Neumorphic(
                                              padding: EdgeInsets.all(5),
                                              style: NeumorphicStyle(
                                                boxShape: NeumorphicBoxShape
                                                    .roundRect(
                                                        BorderRadius.circular(
                                                            10)),
                                              ),
                                              child: Center(
                                                  child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    '${storeController.selectedProductDISCOUNT} %',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displaySmall!
                                                        .copyWith(
                                                            color: ColorApp
                                                                .darkRed,
                                                            fontSize: 12),
                                                  ),
                                                ],
                                              ))),
                                          flex: 3,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Active'.tr + " :",
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall!
                                                .copyWith(
                                                    color: ColorApp.lightBlack,
                                                    fontSize: 12),
                                          ),
                                          flex: 2,
                                        ),
                                        Expanded(
                                          child: Neumorphic(
                                              padding: EdgeInsets.all(5),
                                              style: NeumorphicStyle(
                                                boxShape: NeumorphicBoxShape
                                                    .roundRect(
                                                        BorderRadius.circular(
                                                            10)),
                                              ),
                                              child: Center(
                                                  child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    storeController
                                                                .selectedProductActive ==
                                                            1
                                                        ? 'ActiveStatus'.tr
                                                        : 'UnActiveStatus'.tr,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displaySmall!
                                                        .copyWith(
                                                            color: ColorApp
                                                                .darkRed,
                                                            fontSize: 12),
                                                  ),
                                                ],
                                              ))),
                                          flex: 3,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text(
                                                'Total'.tr,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displaySmall!
                                                    .copyWith(
                                                        color:
                                                            ColorApp.darkBlack,
                                                        fontSize: 15),
                                              ),
                                              Text(
                                                "withoutshipprice".tr,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displaySmall!
                                                    .copyWith(
                                                        color:
                                                            ColorApp.middleRed,
                                                        fontSize: 10),
                                              ),
                                            ],
                                          ),
                                          flex: 2,
                                        ),
                                        Expanded(
                                          child: Neumorphic(
                                              padding: EdgeInsets.all(10),
                                              style: NeumorphicStyle(
                                                depth: 1,
                                                boxShape: NeumorphicBoxShape
                                                    .roundRect(
                                                        BorderRadius.circular(
                                                            8)),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  '${storeController.getTotal(storeController.pice, widget.price, storeController.ship, storeController.selectedProductDISCOUNT)} \$ ',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displaySmall!
                                                      .copyWith(
                                                          color:
                                                              ColorApp.lightRed,
                                                          fontSize: 14),
                                                ),
                                              )),
                                          flex: 3,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    BtnEditProduct(
                                        maxPieces: storeController
                                            .selectedProductQUNTY,
                                        price: storeController
                                            .selectedProductPRICE,
                                        discount: storeController
                                            .selectedProductDISCOUNT),
                                  ],
                                ),
                              ),
                            ),
                          )),
                );
              }
            },
            child: Row(
              children: [
                NeumorphicIcon(
                  Icons.view_in_ar,
                  style: NeumorphicStyle(color: ColorApp.darkBlack),size: 15,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "View".tr,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      color: storeController.selectedProductQUNTY != 0
                          ? ColorApp.darkRed
                          : ColorApp.lightBlack,fontSize: 13),
                ),
              ],
            )));
  }
}
