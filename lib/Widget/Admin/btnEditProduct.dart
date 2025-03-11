import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:smc/Classes/handlingStatusRemotDataView.dart';
import '../../Auth/Widget/customTextFormAuth.dart';
import '../../Controller/Store/storeController.dart';
import '../../Core/Constant/color.dart';

import 'package:flutter/cupertino.dart';

import '../../Core/Constant/imageasset.dart';
import '../../Core/Function/validinput.dart';
import '../Home/avatarImage.dart';

class BtnEditProduct extends StatefulWidget {
  BtnEditProduct(
      {Key? key,
      required this.maxPieces,
      required this.price,
      required this.discount})
      : super(key: key);

  final int maxPieces;
  final int price;
  final int discount;

  @override
  _BtnEditProductState createState() => _BtnEditProductState();
}

class _BtnEditProductState extends State<BtnEditProduct> {
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
            tooltip: "Edit".tr,
            onPressed: () async {
              storeController.ProName = TextEditingController(
                  text: storeController.selectedProductINAME);
              storeController.ProNameAr = TextEditingController(
                  text: storeController.selectedProductINAMEar);
              storeController.ProQua = TextEditingController(
                  text: storeController.selectedProductQUNTY.toString());
              storeController.ProPrice = TextEditingController(
                  text: storeController.selectedProductPRICE.toString());
              storeController.ProDiscount = TextEditingController(
                  text: storeController.selectedProductDISCOUNT.toString());
              storeController.ProAvailable = TextEditingController(
                  text: storeController.selectedProductActive.toString());

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
                  ignoreSafeArea: false,
                  isScrollControlled: true,
                  GetBuilder<StoreController>(
                      builder: (storeController) => HandlingStatusRemotDataView(
                            statusRequest: storeController.statusRequest,
                            widget: Container(
                              margin: EdgeInsets.only(top: 15,),
                              decoration: BoxDecoration(
                                color: ColorApp.bgMain,
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20)),
                              ),
                              padding: EdgeInsets.all(20),
                              child: Form(
                                key: storeController.myKeyEpAdmin,
                                child: ListView(
                                  //   mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(height: 20),
                                   Row(
                                     children: [
                                       Stack(
                                         children: [
                                           AvatarImag(
                                             color: ColorApp.darkRed,
                                             img:
                                             "${ImageAssetApp.ImageStorePro}/${storeController.selectedProductIMG}",
                                             radius: 60.0,
                                             numCircle: 0,
                                           ),
                                           Padding(
                                             padding: EdgeInsets.only(
                                                 top: 60, left: 90),
                                             child: IconButton(
                                               splashRadius: 25,
                                               iconSize: 30,
                                               icon: Container(
                                                 decoration: BoxDecoration(
                                                     borderRadius:
                                                     BorderRadius.circular(20),
                                                     color: ColorApp.darkRed),
                                                 child: Icon(
                                                   Icons
                                                       .download_for_offline_outlined,
                                                   color: ColorApp.bgMain,
                                                 ),
                                               ),
                                               onPressed: () {
                                                 storeController.chooesImg();

                                                 storeController.update();
                                               },
                                             ),
                                           ),
                                         ],
                                       ),
                                       IconButton(onPressed: (){Get.back();}, icon: Icon(Icons.highlight_remove_outlined,color: ColorApp.lightBlack,)),

                                     ],
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                   ),
                                    SizedBox(height: 20),

                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'ProductNameEn'.tr + " :",
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall!
                                                .copyWith(
                                                    color: ColorApp.lightBlack,
                                                    fontSize: 12),
                                          ),
                                          flex: 1,
                                        ),
                                        Expanded(
                                          child: Neumorphic(
                                              child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 180,
                                                child: CustomTextFormAuth(
                                                  title:
                                                      "${storeController.ProName.text}"
                                                          .tr,
                                                  hint:
                                                      "${storeController.ProName.text}",
                                                  obscureText: false,
                                                  icon: Icons.space_bar,
                                                  myController:
                                                      storeController.ProName!,
                                                  keyboardTypex:
                                                      TextInputType.text,
                                                  valid: (val) {
                                                    return validinput(
                                                        val!, 3, 35, "");
                                                  },
                                                ),
                                              ),
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
                                            'ProductNameAr'.tr + " :",
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall!
                                                .copyWith(
                                                    color: ColorApp.lightBlack,
                                                    fontSize: 12),
                                          ),
                                          flex: 1,
                                        ),
                                        Expanded(
                                          child: Neumorphic(
                                              child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 180,
                                                child: CustomTextFormAuth(
                                                  title:
                                                      "${storeController.ProNameAr.text}"
                                                          .tr,
                                                  hint:
                                                      "${storeController.ProNameAr.text}",
                                                  obscureText: false,
                                                  icon: Icons.space_bar,
                                                  myController: storeController
                                                      .ProNameAr!,
                                                  keyboardTypex:
                                                      TextInputType.text,
                                                  valid: (val) {
                                                    return validinput(
                                                        val!, 3, 35, "");
                                                  },
                                                ),
                                              ),
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
                                            'Quantity'.tr,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall!
                                                .copyWith(
                                                    color: ColorApp.lightBlack,
                                                    fontSize: 12),
                                          ),
                                          flex: 1,
                                        ),
                                        Expanded(
                                          child: Neumorphic(
                                              child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 180,
                                                child: CustomTextFormAuth(
                                                  title:
                                                      "${storeController.ProQua.text}"
                                                          .tr,
                                                  hint:
                                                      "${storeController.ProQua.text}",
                                                  obscureText: false,
                                                  icon: Icons.category_outlined,
                                                  myController:
                                                      storeController.ProQua!,
                                                  keyboardTypex:
                                                      TextInputType.number,
                                                  valid: (val) {
                                                    return validinput(
                                                        val!, 1, 25, "");
                                                  },
                                                ),
                                              ),
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
                                            'Price'.tr,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall!
                                                .copyWith(
                                                    color: ColorApp.lightBlack,
                                                    fontSize: 12),
                                          ),
                                          flex: 1,
                                        ),
                                        Expanded(
                                          child: Neumorphic(
                                              child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 180,
                                                child: CustomTextFormAuth(
                                                  title:
                                                      "${storeController.ProPrice.text}"
                                                          .tr,
                                                  hint:
                                                      "${storeController.ProPrice.text}",
                                                  obscureText: false,
                                                  icon: Icons
                                                      .monetization_on_outlined,
                                                  myController:
                                                      storeController.ProPrice!,
                                                  keyboardTypex:
                                                      TextInputType.number,
                                                  valid: (val) {
                                                    return validinput(
                                                        val!, 1, 25, "");
                                                  },
                                                ),
                                              ),
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
                                            'Discount'.tr + " :",
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall!
                                                .copyWith(
                                                    color: ColorApp.lightBlack,
                                                    fontSize: 12),
                                          ),
                                          flex: 1,
                                        ),
                                        Expanded(
                                          child: Neumorphic(
                                              child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 180,
                                                child: CustomTextFormAuth(
                                                  title:
                                                      "${storeController.ProDiscount.text}"
                                                          .tr,
                                                  hint:
                                                      "${storeController.ProDiscount.text}",
                                                  obscureText: false,
                                                  icon: Icons.percent,
                                                  myController: storeController
                                                      .ProDiscount!,
                                                  keyboardTypex:
                                                      TextInputType.number,
                                                  valid: (val) {
                                                    return validinput(
                                                        val!, 1, 25, "");
                                                  },
                                                ),
                                              ),
                                            ],
                                          )),
                                          flex: 2,
                                        ),
                                      ],
                                    ),
////////////////////////////////////////********************************************
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
                                          flex: 1,
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
                                                  storeController
                                                          .ProAvailable.text =
                                                      (index).toString();
                                                  setState(() {
                                                    storeController.update();
                                                  });
                                                  print(index);
                                                  ////////////////////////////////////////
                                                },
                                                children: <Widget>[
                                                  ...List.generate(2, (index) {
                                                    return Center(
                                                        child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          ' ${storeController.ProAvailable.text} ',
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
                                                  '${storeController.getTotal(storeController.pice, widget.price * widget.maxPieces, storeController.ship, storeController.selectedProductDISCOUNT)} \$ ',
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
                                        await storeController.updateProAdmin();
                                      },
                                      child: Text("Save".tr),
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
              mainAxisSize: MainAxisSize.min,
              children: [
                NeumorphicIcon(
                  Icons.change_circle_outlined,
                  style: NeumorphicStyle(color: ColorApp.darkBlack,),size: 15,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Edit".tr,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      color: storeController.selectedProductQUNTY != 0
                          ? ColorApp.darkRed
                          : ColorApp.lightBlack,
                  fontSize: 13),
                ),
              ],
            )));
  }
}
