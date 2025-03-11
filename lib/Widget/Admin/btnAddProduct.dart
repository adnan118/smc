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
import '../../Core/Localization/translateDB.dart';
import '../Home/avatarImage.dart';

class BtnAddProduct extends StatefulWidget {
  BtnAddProduct(
      {Key? key,
      required this.maxPieces,
      required this.price,
      required this.discount})
      : super(key: key);

  final int maxPieces;
  final int price;
  final int discount;

  @override
  _BtnAddProductState createState() => _BtnAddProductState();
}

class _BtnAddProductState extends State<BtnAddProduct> {

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
            tooltip: "Add".tr,
            onPressed: () async {
              /*
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
 */
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


                                           storeController.myfile==null?
                                       Image.asset("assets/images/product.png"):
                                           CircleAvatar(
                                             backgroundColor: Colors.transparent,
                                             backgroundImage: FileImage(storeController.myfile!) ,
                                             radius: 45.0,
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
                                                      "ProductNameEn"
                                                          .tr,
                                                  hint:
                                                      "ProductNameEn".tr,
                                                  obscureText: false,
                                                  icon: Icons.space_bar,
                                                  myController:
                                                      storeController.ProNameAdd!,
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
                                                  "ProductNameAr"
                                                      .tr,
                                                  hint:
                                                  "ProductNameAr".tr,
                                                  obscureText: false,
                                                  icon: Icons.space_bar,
                                                  myController:
                                                  storeController.ProNameArAdd!,
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
                                                      "Quantity"
                                                          .tr,
                                                  hint:
                                                      "Quantity".tr,
                                                  obscureText: false,
                                                  icon: Icons.category_outlined,
                                                  myController:
                                                      storeController.ProQuaAdd!,
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
                                                      "Price"
                                                          .tr,
                                                  hint:
                                                      "Price".tr,
                                                  obscureText: false,
                                                  icon: Icons
                                                      .monetization_on_outlined,
                                                  myController:
                                                      storeController.ProPriceAdd!,
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
                                                      "Discount"
                                                          .tr,
                                                  hint:
                                                      "Discount".tr,
                                                  obscureText: false,
                                                  icon: Icons.percent,
                                                  myController: storeController
                                                      .ProDiscountAdd!,
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
                                                          .ProAvailableAdd.text =
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
                                                          ' ${storeController.ProAvailableAdd.text} ',
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
                                            'Category'.tr + " :",
                                            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                              color: ColorApp.lightBlack,
                                              fontSize: 12,
                                            ),
                                          ),
                                          flex: 1,
                                        ),
                                        Expanded(
                                          child: Neumorphic(
                                            style: NeumorphicStyle(
                                              depth: -25,
                                              boxShape: NeumorphicBoxShape.roundRect(
                                                BorderRadius.circular(10),
                                              ),
                                            ),
                                            child: CupertinoPicker(
                                              itemExtent: 50.0,
                                              backgroundColor: ColorApp.bgMain,
                                              onSelectedItemChanged: (int index) {
                                                // تحديث قيمة حقل الإدخال عند اختيار التصنيف
                                                storeController.ProCategoryAdd.text = storeController.dataCategories[index].categoriesId.toString(); // تعيين ID التصنيف
                                                setState(() {
                                                  storeController.update();
                                                });
                                              },
                                              children: <Widget>[
                                                ...List.generate(storeController.dataCategories.length, (index) {
                                                  return Center(
                                                    child: Text(
                                                        storeController.  convertCategory(storeController.dataCategories[index].categoriesId), // استخدم الدالة لترجمة الاسم
                                                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                                        color: ColorApp.darkRed,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  );
                                                }),
                                              ],
                                            ),
                                          ),
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

                                        await storeController.addProAdmin();
                                    //    Get.back();
                                      },
                                      child: Text("Add".tr),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )),
                );

            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                NeumorphicIcon(
                  Icons.add_circle_outline,
                  style: NeumorphicStyle(color: ColorApp.darkBlack),size: 15,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Add".tr,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      color: storeController.selectedProductQUNTY != 0
                          ? ColorApp.darkRed
                          : ColorApp.lightBlack,fontSize: 13),
                ),
              ],
            )));
  }
}
