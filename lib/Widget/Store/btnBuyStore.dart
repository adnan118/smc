import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:smc/Classes/handlingStatusRemotDataView.dart';
import '../../Controller/Store/storeController.dart';
import '../../Core/Constant/color.dart';

import 'package:flutter/cupertino.dart';

import 'generateQr.dart';

class BtnBuyStore extends StatefulWidget {
  BtnBuyStore(
      {Key? key,
      required this.maxPieces,
      required this.price,
      required this.discount})
      : super(key: key);

  final int maxPieces;
  final int price;
  final int discount;

  @override
  _BtnBuyStoreState createState() => _BtnBuyStoreState();
}

class _BtnBuyStoreState extends State<BtnBuyStore> {
  @override
  Widget build(BuildContext context) {
    final StoreController storeController = Get.put(StoreController());
    final int maxPices;
    final int price;
    return GetBuilder<StoreController>(
        builder: (storeController) => NeumorphicButton(
            margin: EdgeInsets.symmetric(
              horizontal: 25,
            ),
            tooltip: "Buy".tr,
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
              } else if (storeController.selectedProductQUNTY == 0) {
                Get.snackbar(" ", " ",
                    titleText: Text(
                      "SMC",
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(color: ColorApp.darkRed, fontSize: 15),
                    ),
                    messageText: Text(
                      "PieceofthisproductisOver".tr,
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(color: ColorApp.lightBlack, fontSize: 13),
                    ),
                    duration: Duration(seconds: 8),
                    icon: Icon(
                      Icons.hourglass_empty,
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
                                            'Quantity'.tr,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall!
                                                .copyWith(
                                                    color: ColorApp.lightBlack,
                                                    fontSize: 12),
                                          ),
                                          flex: 3,
                                        ),
                                        Expanded(
                                          child: Neumorphic(
                                              style: NeumorphicStyle(
                                                depth: -25,
                                                boxShape: NeumorphicBoxShape
                                                    .roundRect(
                                                        BorderRadius.circular(
                                                            10)),
                                              ),
                                              child: CupertinoPicker(
                                                itemExtent: 50.0,
                                                backgroundColor:
                                                    ColorApp.bgMain,
                                                onSelectedItemChanged:
                                                    (int index) {
                                                  ////////////////////////////////////////
                                                  storeController.pice =
                                                      index + 1;
                                                  setState(() {
                                                    storeController.getTotal(
                                                        storeController.pice,
                                                        widget.price,
                                                        storeController.ship,
                                                        storeController
                                                            .selectedProductDISCOUNT);
                                                    storeController.update();
                                                  });
                                                  print(index);
                                                  ////////////////////////////////////////
                                                },
                                                children: <Widget>[
                                                  ...List.generate(
                                                      widget.maxPieces,
                                                      (index) {
                                                    return Center(
                                                        child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          ' ${storeController.pice} ',
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .displaySmall!
                                                              .copyWith(
                                                                  color: ColorApp
                                                                      .darkRed,
                                                                  fontSize: 14),
                                                        ),
                                                        Text(
                                                          'PIC'.tr,
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .displaySmall!
                                                              .copyWith(
                                                                  color: ColorApp
                                                                      .darkRed,
                                                                  fontSize: 14),
                                                        ),
                                                      ],
                                                    ));
                                                  }),
                                                ],
                                              )),
                                          flex: 2,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Location'.tr,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall!
                                                .copyWith(
                                                    color: ColorApp.lightBlack,
                                                    fontSize: 12),
                                          ),
                                          flex: 3,
                                        ),
                                        Expanded(
                                          child: Neumorphic(
                                              style: NeumorphicStyle(
                                                depth: -25,
                                                boxShape: NeumorphicBoxShape
                                                    .roundRect(
                                                        BorderRadius.circular(
                                                            10)),
                                              ),
                                              child: CupertinoPicker(
                                                itemExtent: 50.0,
                                                backgroundColor:
                                                    ColorApp.bgMain,
                                                onSelectedItemChanged:
                                                    (int index) {
                                                  //    selectedValue = index;
                                                  if (index == 0) {
                                                    storeController.ship = 0;
                                                    storeController
                                                        .wayShip =
                                                    "BOPIS";
                                                  } else if (index == 1) {
                                                    storeController.ship = 5;
                                                  } else {
                                                    storeController.ship = 15;
                                                  }
                                                  setState(() {
                                                    storeController.getTotal(
                                                        storeController.pice,
                                                        widget.price,
                                                        storeController.ship,
                                                        storeController
                                                            .selectedProductDISCOUNT);
                                                    storeController.update();
                                                  });
                                                  print(index);
                                                },
                                                children: <Widget>[
                                                  Center(
                                                    child: Text(
                                                      ' BOPIS ',
                                                      // "Buy Online, Pick Up In Store
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .displaySmall!
                                                          .copyWith(
                                                              color: ColorApp
                                                                  .darkRed,
                                                              fontSize: 14),
                                                    ),
                                                  ),
                                                  Center(
                                                    child: Text(
                                                      'InSyria'.tr,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .displaySmall!
                                                          .copyWith(
                                                              color: ColorApp
                                                                  .darkRed,
                                                              fontSize: 14),
                                                    ),
                                                  ),
                                                  Center(
                                                    child: Text(
                                                      'OutSyria'.tr,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .displaySmall!
                                                          .copyWith(
                                                              color: ColorApp
                                                                  .darkRed,
                                                              fontSize: 14),
                                                    ),
                                                  )
                                                ],
                                              )),
                                          flex: 2,
                                        ),
                                      ],
                                    ),
                                    storeController.ship != 0
                                        ? SizedBox(height: 20)
                                        : SizedBox(height: 0),
                                    storeController.ship != 0
                                        ? AnimatedContainer(
                                            duration: Duration(seconds: 5),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    'ShipCo'.tr,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displaySmall!
                                                        .copyWith(
                                                            color: ColorApp
                                                                .lightBlack,
                                                            fontSize: 12),
                                                  ),
                                                  flex: 1,
                                                ),
                                                Expanded(
                                                  child: Neumorphic(
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      style: NeumorphicStyle(
                                                        depth: 1,
                                                        boxShape:
                                                            NeumorphicBoxShape
                                                                .roundRect(
                                                                    BorderRadius
                                                                        .circular(
                                                                            8)),
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Center(
                                                              child:
                                                                  NeumorphicRadio(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10),
                                                            child: Image.asset(
                                                                "assets/images/DHL.png",
                                                                width: 75,
                                                                color: storeController
                                                                            .wayShip ==
                                                                        "DHL"
                                                                    ? null
                                                                    : storeController
                                                                        .wayShipColor
                                                                        .withOpacity(
                                                                            0.2)),
                                                            groupValue:
                                                                storeController
                                                                    .wayShip,
                                                            value: "DHL",
                                                            onChanged: (v) {
                                                              storeController
                                                                      .wayShip =
                                                                  "DHL";

                                                              print(v);
                                                              storeController
                                                                  .update();
                                                              setState(() {});
                                                            },
                                                          )),
                                                          Spacer(),
                                                          Center(
                                                              child:
                                                                  NeumorphicRadio(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10),
                                                            //    child: Image.asset("assets/images/aramex.png",width: 75,color: storeController. wayShipColor2,),
                                                            child: Image.asset(
                                                                "assets/images/aramex.png",
                                                                width: 75,
                                                                color: storeController
                                                                            .wayShip ==
                                                                        "ARAMEX"
                                                                    ? null
                                                                    : storeController
                                                                        .wayShipColor
                                                                        .withOpacity(
                                                                            0.2)),
                                                            groupValue:
                                                                storeController
                                                                    .wayShip,
                                                            value: "ARAMEX",

                                                            onChanged: (v) {
                                                              storeController
                                                                      .wayShip =
                                                                  "ARAMEX";
                                                              storeController
                                                                  .update();

                                                              print(v);
                                                              setState(() {});
                                                            },
                                                          ))
                                                        ],
                                                      )),
                                                  flex: 3,
                                                ),
                                              ],
                                            ))
                                        : Text(""),
                                    SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Total'.tr,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall!
                                                .copyWith(
                                                    color: ColorApp.lightBlack,
                                                    fontSize: 12),
                                          ),
                                          flex: 3,
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
                                                              ColorApp.darkRed,
                                                          fontSize: 14),
                                                ),
                                              )),
                                          flex: 2,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .displaySmall,
                                          primary: ColorApp.darkRed,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          padding: EdgeInsets.all(11)),
                                      onPressed: () async {
                                        Get.back();
                                        await storeController.insertInvoice();

                                        storeController.ship = 0;
                                        storeController.pice = 1;
                                        storeController.price = 0;
                                      },
                                      child: Text("GenerateInvoice".tr),
                                    ),
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
                  Icons.payments_outlined,
                  style: NeumorphicStyle(
                      color: storeController.selectedProductQUNTY != 0
                          ? ColorApp.lightRed
                          : ColorApp.lightBlack),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Buy".tr,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      color: storeController.selectedProductQUNTY != 0
                          ? ColorApp.darkRed
                          : ColorApp.lightBlack),
                ),
              ],
            )));
  }
}
