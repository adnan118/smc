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
import '../../Widget/Admin/btnAddProduct.dart';
import '../../Widget/Admin/btnDeleteProduct.dart';
import '../../Widget/Admin/btnEditProduct.dart';
import '../../Widget/Admin/btnViewProduct.dart';
import '../../Widget/Home/avatarImage.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class StoreManage extends StatefulWidget {
  const StoreManage({Key? key}) : super(key: key);

  @override
  State<StoreManage> createState() => _StoreManageState();
}

class _StoreManageState extends State<StoreManage>
    with SingleTickerProviderStateMixin {
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
        child: RefreshIndicator(
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
            child: Neumorphic(
                child: Stack(children: [
              ListView(
                children: [
                  SizedBox(
                    height: 250,
                  ),
                  Container(
                      padding: EdgeInsets.all(15),
                      child: GetBuilder<StoreController>(
                          builder: (storeController) =>
                              HandlingStatusRemotDataView(
                                statusRequest: storeController.statusRequest,
                                widget: Container(
                                  color: ColorApp.bgMain,
                                  child: Neumorphic(
                                    child: GridView.builder(
                                        physics: BouncingScrollPhysics(),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: storeController
                                            .dataStoreView.length,
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
                                                                .dataStoreView[
                                                                    index]
                                                                .productDiscount! >
                                                            0
                                                        ? ColorApp.green
                                                            .withOpacity(0.1)
                                                        : null),
                                                child: Column(
                                                  children: [
                                                    Expanded(
                                                      child: Neumorphic(
                                                          child:
                                                              CachedNetworkImage(
                                                        imageUrl:
                                                            "${ImageAssetApp.ImageStorePro}/${storeController.dataStoreView[index].productImg}",
                                                        fit: BoxFit.cover,
                                                        placeholder: (context,
                                                                url) =>
                                                            Image.asset(
                                                                "assets/images/product.png"),
                                                        // صورة افتراضية
                                                        errorWidget: (context,
                                                                url, error) =>
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
                                                                  .dataStoreView[
                                                                      index]
                                                                  .productNameAr,
                                                              storeController
                                                                  .dataStoreView[
                                                                      index]
                                                                  .productName,
                                                            )}",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .displaySmall!
                                                                .copyWith(
                                                                    color: ColorApp
                                                                        .darkBlack,
                                                                    fontSize:
                                                                        9),
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
                                                          .dataStoreView[index]
                                                          .productId!;

                                                  storeController
                                                          .selectedProductActive =
                                                      storeController
                                                          .dataStoreView[index]
                                                          .productActive!;
                                                  storeController
                                                          .selectedProductQUNTY =
                                                      storeController
                                                          .dataStoreView[index]
                                                          .productQuantity!;
                                                  storeController
                                                          .selectedProductPRICE =
                                                      storeController
                                                          .dataStoreView[index]
                                                          .productPrice!;
                                                  storeController
                                                          .selectedProductDISCOUNT =
                                                      storeController
                                                          .dataStoreView[index]
                                                          .productDiscount!;
                                                  storeController
                                                          .selectedProductIMG =
                                                      storeController
                                                          .dataStoreView[index]
                                                          .productImg!;
                                                  storeController
                                                          .selectedProductINAME =
                                                      storeController
                                                          .dataStoreView[index]
                                                          .productName!;
                                                  storeController
                                                          .selectedProductCat =
                                                      storeController
                                                          .dataStoreView[index]
                                                          .productCategories!;
                                                  storeController
                                                          .selectedProductINAMEar =
                                                      storeController
                                                          .dataStoreView[index]
                                                          .productNameAr!;
                                                  storeController.update();
                                                },
                                              ),
                                              storeController
                                                          .dataStoreView[index]
                                                          .productDiscount! >
                                                      0
                                                  ? Column(
                                                      children: [
                                                        Image.asset(
                                                          "assets/images/sale.png",
                                                          color:
                                                              ColorApp.lightRed,
                                                          width: 40,
                                                        ),
                                                        Text(
                                                          "${storeController.dataStoreView[index].productDiscount} %",
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .displaySmall!
                                                              .copyWith(
                                                                  color: ColorApp
                                                                      .lightBlack,
                                                                  fontSize: 12),
                                                        ),

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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                Column(                          crossAxisAlignment: CrossAxisAlignment.center,

                                  children: [
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Neumorphic(
                                      style: NeumorphicStyle(
                                          shape: NeumorphicShape.convex,
                                          boxShape: NeumorphicBoxShape.circle(),
                                          color: ColorApp.bacground,
                                          border: NeumorphicBorder(
                                              width: 7,
                                              isEnabled: storeController
                                                          .selectedProductDISCOUNT >
                                                      0
                                                  ? true
                                                  : false,
                                              color: storeController
                                                          .selectedProductDISCOUNT >
                                                      0
                                                  ? ColorApp.green
                                                      .withOpacity(0.1)
                                                  : null)),
                                      padding: EdgeInsets.all(3),
                                      child:
                                          storeController.selectedProductIMG ==
                                                  ""
                                              ? Image.asset(
                                                  "assets/images/qr.png",
                                                )
                                              : AvatarImag(
                                                  color: ColorApp.darkRed,
                                                  img:
                                                      "${ImageAssetApp.ImageStorePro}/${storeController.selectedProductIMG}",
                                                  radius: 50.0,
                                                  numCircle: 0,
                                                ),
                                    ),
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

                              ],
                            ),
                            SingleChildScrollView(
 scrollDirection: Axis.horizontal                             ,
                              child:
                            Row(
                              children: [

                                BtnEditProduct(
                                  maxPieces: storeController.selectedProductQUNTY,
                                  price: storeController.selectedProductPRICE,
                                  discount: storeController.selectedProductDISCOUNT,
                                ),
                                BtnAddProduct(
                                  maxPieces: storeController.selectedProductQUNTY,
                                  price: storeController.selectedProductPRICE,
                                  discount: storeController.selectedProductDISCOUNT,
                                ),
                                    BtnViewProduct(
                                      maxPieces: storeController.selectedProductQUNTY,
                                      price: storeController.selectedProductPRICE,
                                      discount: storeController.selectedProductDISCOUNT,
                                    ),
                                    BtnDeleteProduct(
                                      productID: storeController.selectedProductID.toString(),
                                    ),


                                  ],
                                ),
                                ),

                            SizedBox(
                              height: 25,
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
                                        storeController.dataCategories.length +
                                            1,
                                    itemBuilder: (context, index) {
                                      return index + 1 ==
                                              storeController
                                                      .dataCategories.length +
                                                  1
                                          ? NeumorphicButton(
                                              margin: EdgeInsets.symmetric(
                                                horizontal: 10,
                                              ),
                                              child: Icon(
                                                Icons.all_inclusive,
                                                color: ColorApp.darkRed,
                                              ),
                                              onPressed: () {
                                                storeController
                                                    .changCategories(0);
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
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                                    placeholder: (context,
                                                            url) =>
                                                        Image.asset(
                                                            "assets/images/product.png"),
                                                    // صورة افتراضية
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        Image.asset(
                                                            "assets/images/product.png"), // صورة افتراضية في حال حدوث خطأ
                                                  ),
                                                ],
                                              ),
                                              onPressed: () {
                                                storeController.changCategories(
                                                    storeController
                                                        .dataCategories[index]
                                                        .categoriesId!);
                                              },
                                            );
                                    },
                                    )
                            ),
                          ],
                        ),
                      )))
            ]))));
  }
}
