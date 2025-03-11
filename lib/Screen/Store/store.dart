import 'package:cached_network_image/cached_network_image.dart';
import 'package:fancy_drawer/fancy_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import '../../Classes/handlingStatusRemotDataView.dart';
import '../../Controller/Store/storeController.dart';
import '../../Core/Constant/color.dart';
import '../../Core/Constant/imageasset.dart';
import '../../Core/Localization/translateDB.dart';
import '../../Widget/Store/btnBuyStore.dart';
import '../../Widget/Store/btnBillsStore.dart';

class Store extends StatefulWidget {
  const Store({Key? key}) : super(key: key);

  @override
  State<Store> createState() => _StoreState();
}

class _StoreState extends State<Store> with SingleTickerProviderStateMixin {
  late FancyDrawerController FDC_controller =
      FancyDrawerController(vsync: this, duration: Duration(milliseconds: 500))
        ..addListener(() {
          setState(() {});
        });

  @override
  void dispose() {
    FDC_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final StoreController storeController = Get.put(StoreController());
    return FancyDrawerWrapper(
        backgroundColor: NeumorphicColors.background,
        controller: FDC_controller,
        drawerItems: <Widget>[
          //  DrawerX()
        ],
        child:
        RefreshIndicator(
            color: ColorApp.bgMain,
            backgroundColor: ColorApp.darkRed,
            onRefresh: () async {
              await Future.delayed(Duration(seconds: 2));
              Get.delete<StoreController>();
              Get.put(StoreController());
              storeController.StoreAll();
              //   Get.offAllNamed("/RootPage");
            //     Get.offNamed("/Store");

            },
            child:
        Neumorphic(
            child: Stack(children: [
          ListView(
            children: [
              SizedBox(
                height: 250,
              ),
              Container(
                  padding: EdgeInsets.all(15),
                  child: GetBuilder<StoreController>(
                      builder: (storeController) => HandlingStatusRemotDataView(
                            statusRequest: storeController.statusRequest,
                            widget: Container(
                              color: ColorApp.bgMain,
                              child: Neumorphic(
                                child: GridView.builder(
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: storeController.dataStore.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 15,
                                      crossAxisSpacing: 15,
                                    ),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Stack(
                                        children: [
                                          NeumorphicButton(
                                            style: NeumorphicStyle(
                                                color: storeController
                                                            .dataStore[index]
                                                            .productDiscount! >
                                                        0
                                                    ? ColorApp.green
                                                        .withOpacity(0.1)
                                                    : null),
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  child: Neumorphic(
                                                      child: CachedNetworkImage(
                                                    imageUrl:
                                                        "${ImageAssetApp.ImageStorePro}/${storeController.dataStore[index].productImg}",
                                                    fit: BoxFit.cover,
                                                    placeholder: (context,
                                                            url) =>
                                                        Image.asset(
                                                            "assets/images/product.png"),
                                                    // صورة افتراضية
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        Image.asset(
                                                            "assets/images/product.png"), // صورة افتراضية في حال حدوث خطأ
                                                  )),
                                                  flex: 4,
                                                ),
                                                Expanded(
                                                    child: Neumorphic(
                                                      child: Center(
                                                          child: Text(
                                                        "${translateDB(
                                                          storeController
                                                              .dataStore[index]
                                                              .productNameAr,
                                                          storeController
                                                              .dataStore[index]
                                                              .productName,
                                                        )}",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .displaySmall!
                                                            .copyWith(
                                                                color: ColorApp
                                                                    .darkBlack,
                                                                fontSize: 9),
                                                      )),
                                                    ),
                                                    flex: 1),
                                              ],
                                            ),
                                            duration: Duration(seconds: 1),
                                            onPressed: () {
                                              storeController
                                                      .selectedProductID =
                                                  storeController
                                                      .dataStore[index]
                                                      .productId!;

                                              storeController
                                                      .selectedProductQUNTY =
                                                  storeController
                                                      .dataStore[index]
                                                      .productQuantity!;
                                              storeController
                                                      .selectedProductPRICE =
                                                  storeController
                                                      .dataStore[index]
                                                      .productPrice!;
                                              storeController
                                                      .selectedProductDISCOUNT =
                                                  storeController
                                                      .dataStore[index]
                                                      .productDiscount!;
                                              storeController
                                                      .selectedProductIMG =
                                                  storeController
                                                      .dataStore[index]
                                                      .productImg!;
                                              storeController
                                                      .selectedProductINAME =
                                                  storeController
                                                      .dataStore[index]
                                                      .productName!;
                                              storeController
                                                      .selectedProductINAMEar =
                                                  storeController
                                                      .dataStore[index]
                                                      .productNameAr!;
                                              storeController.update();
                                              print(storeController
                                                  .selectedProductID);
                                            },
                                          ),
                                          storeController.dataStore[index]
                                                      .productDiscount! >
                                                  0
                                              ? Column(
                                                  children: [
                                                    Image.asset(
                                                      "assets/images/sale.png",
                                                      color: ColorApp.lightRed,
                                                      width: 40,
                                                    ),
                                                    Text(
                                                      "${storeController.dataStore[index].productDiscount} %",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .displaySmall!
                                                          .copyWith(
                                                              color: ColorApp
                                                                  .lightBlack,
                                                              fontSize: 12),
                                                    )
                                                  ],
                                                )
                                              : Text("")
                                        ],
                                      );
                                    }),
                              ),
                            ),
                          )))
            ],
          ),
          /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
          /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
          GetBuilder<StoreController>(
              builder: (storeController) => (Container(
                    decoration: BoxDecoration(
                        color: ColorApp.bgMain,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Neumorphic(
                                    style: NeumorphicStyle(
                                        shape: NeumorphicShape.convex,
                                        boxShape: NeumorphicBoxShape.circle(),
                                        color: ColorApp.bacground,
                                      border: NeumorphicBorder(width: 7,isEnabled:storeController.selectedProductDISCOUNT >0?true:false ,color: storeController.selectedProductDISCOUNT >0
                                          ? ColorApp.green.withOpacity(0.1)

                                          : null)

                                    ),
                                    padding: EdgeInsets.all(10),
                                    child: CachedNetworkImage(
                                      height: 100,
                                      imageUrl:
                                          "${ImageAssetApp.ImageStorePro}/${storeController.selectedProductIMG}",
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          Image.asset(
                                        "assets/images/qr.png",
                                      ),
                                      // صورة افتراضية
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                        "assets/images/qr.png",
                                      ), // صورة افتراضية في حال حدوث خطأ
                                    )),
                                SizedBox(
                                  height: 5,
                                ),
                                Center(
                                    child: Text(
                                  "${translateDB(
                                    storeController.selectedProductINAMEar,
                                    storeController.selectedProductINAME,
                                  )}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(
                                          color: ColorApp.lightBlack,
                                          fontSize: 10),
                                )),
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 0,
                                    ),
                                    Text(
                                      "Product-ID".tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(
                                              color: ColorApp.lightBlack,
                                              fontSize: 12),
                                    ),
                                    Text(
                                      "${storeController.selectedProductID}" ??
                                          "00000",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(
                                              color: ColorApp.blue,
                                              fontSize: 11),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Text(
                                      "Quantity".tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(
                                              color: ColorApp.lightBlack,
                                              fontSize: 12),
                                    ),
                                    Text(
                                      "${storeController.selectedProductQUNTY}" ??
                                          "0",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(
                                              color: ColorApp.blue,
                                              fontSize: 11),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 0,
                                    ),
                                    Text(
                                      "Price".tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(
                                              color: ColorApp.lightBlack,
                                              fontSize: 12),
                                    ),
                                    Text(
                                      "${storeController.selectedProductPRICE} \$" ??
                                          "0 \$",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(
                                              color: ColorApp.blue,
                                              fontSize: 11),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          Column( children: [
                            BtnBuyStore(
                                maxPieces: storeController.selectedProductQUNTY,
                                price: storeController.selectedProductPRICE,
                                discount:
                                storeController.selectedProductDISCOUNT),
                            SizedBox(
                              height: 15,
                            ),
                            BtnBillsStore(),
                          ],)
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        storeController.dataCategories.isEmpty?Text(""):
                        Container(
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                            storeController
                                .CurrentPageCategories ==0?"All".tr:
                            "${translateDB(
                                    storeController
                                        .dataCategories[storeController
                                                .CurrentPageCategories -
                                            1]
                                        .categoriesNameAr,
                                    storeController
                                        .dataCategories[storeController
                                                .CurrentPageCategories -   1]
                                        .categoriesName,
                                  )}",
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                ),
                                Text(
                                  "${storeController.CurrentPageCategories == 0 ? storeController.dataStore.length : storeController.dataStore.where((item) => item.categoriesId == storeController.CurrentPageCategories).length}",
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                ),
                                storeController.CurrentPageCategories ==0?
                                Icon(Icons.all_inclusive,color: ColorApp.darkRed,size: 30,)
                                    :
                                CachedNetworkImage(
                                  imageUrl:



                                  "${ImageAssetApp.ImageStoreCat}/${storeController.dataCategories[storeController.CurrentPageCategories - 1].categoriesImg}",
                                  width: 30,
                                  fit: BoxFit.contain,
                                  placeholder: (context, url) => Image.asset(
                                    "assets/images/qr.png",
                                  ),
                                  // صورة افتراضية
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                    "assets/images/qr.png",
                                  ), // صورة افتراضية في حال حدوث خطأ
                                )
                              ],
                            )),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                                color: ColorApp.middleRed,
                                borderRadius: BorderRadius.circular(10)),
                            margin: EdgeInsets.symmetric(
                              horizontal: 5,
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 2,
                            ),
                            child: ListView.builder(
                                reverse: true,
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    storeController.dataCategories.length + 1,
                                itemBuilder: (context, index) {
                                  return index + 1 ==
                                          storeController
                                                  .dataCategories.length +
                                              1
                                      ? NeumorphicButton(
                                          margin: EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          child: Icon(Icons.all_inclusive,color: ColorApp.darkRed,),
                                          onPressed: () {
                                            storeController.changCategories(0);
                                            storeController.update();
                                            setState(() {});
                                          },
                                        )
                                      : NeumorphicButton(
                                          margin: EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          child: Row(
                                            children: [
                                              Text(
                                                "${translateDB(
                                                  storeController
                                                      .dataCategories[index]
                                                      .categoriesNameAr,
                                                  storeController
                                                      .dataCategories[index]
                                                      .categoriesName,
                                                )}",
                                                style: TextStyle(
                                                    color: ColorApp.darkRed,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "Exo"),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              CachedNetworkImage(
                                                width: 25,
                                                imageUrl:
                                                    "${ImageAssetApp.ImageStoreCat}/${storeController.dataCategories[index].categoriesImg}",
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) =>
                                                    Image.asset(
                                                        "assets/images/product.png"),
                                                // صورة افتراضية
                                                errorWidget: (context, url,
                                                        error) =>
                                                    Image.asset(
                                                        "assets/images/product.png"), // صورة افتراضية في حال حدوث خطأ
                                              )
                                            ],
                                          ),
                                          onPressed: () {
                                            storeController.changCategories(
                                                storeController
                                                    .dataCategories[index]
                                                    .categoriesId!);
                                          },
                                        );
                                })),
                      ],
                    ),
                  )))
        ]))));
  }
}
