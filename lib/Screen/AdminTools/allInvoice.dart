import 'package:cached_network_image/cached_network_image.dart';
import 'package:fancy_drawer/fancy_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Classes/handlingStatusRemotDataView.dart';
import '../../Controller/AdminTools/AdminToolsController.dart';
import '../../Controller/Store/InvoicController.dart';
import '../../Core/Constant/color.dart';
import '../../Core/Constant/imageasset.dart';
import '../../Widget/Home/connectionData.dart';
import '../../Widget/Store/generateQr.dart';

class InvoiceAllAdmin extends StatefulWidget {
  const InvoiceAllAdmin({Key? key}) : super(key: key);

  @override
  State<InvoiceAllAdmin> createState() => _InvoiceAllAdminState();
}

class _InvoiceAllAdminState extends State<InvoiceAllAdmin>
    with SingleTickerProviderStateMixin {
  late FancyDrawerController FDC_controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AdminToolsController invoicController = Get.put(AdminToolsController());

    final List cell;
    List cols = [
      "invoiceID",
      "Name",
      "User",
      "Total",
      "Date",
      "Paid",
    ];

    return Scaffold(
        backgroundColor: ColorApp.bgMain,
        appBar: AppBar(
          title: Text(
            "AllInvoice".tr,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        body: GetBuilder<AdminToolsController>(
            builder: (invoicController) => HandlingStatusRemotDataRequest(
                statusRequest: invoicController.statusRequest,
                widget: ListView(
                  children: [
                    Table(children: [
                      TableRow(
                          children: [
                            TableCell(
                                child: Center(
                              heightFactor: 2,
                              child: Text(
                                cols[0],
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                        color: ColorApp.bacground,
                                        fontSize: 12),
                              ),
                            )),
                            TableCell(
                                child: Center(
                              heightFactor: 2,
                              child: Text(
                                cols[1],
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                        color: ColorApp.bacground,
                                        fontSize: 12),
                              ),
                            )),
                            TableCell(
                                child: Center(
                              heightFactor: 2,
                              child: Text(
                                cols[2],
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                        color: ColorApp.bacground,
                                        fontSize: 12),
                              ),
                            )),
                            TableCell(
                                child: Center(
                              heightFactor: 2,
                              child: Text(
                                cols[3],
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                        color: ColorApp.bacground,
                                        fontSize: 12),
                              ),
                            )),
                            TableCell(
                                child: Center(
                              heightFactor: 2,
                              child: Text(
                                cols[4],
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                        color: ColorApp.bacground,
                                        fontSize: 12),
                              ),
                            )),
                            TableCell(
                                child: Center(
                              heightFactor: 2,
                              child: Text(
                                cols[5],
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                        color: ColorApp.bacground,
                                        fontSize: 12),
                              ),
                            )),
                          ],
                          decoration: BoxDecoration(
                              color: ColorApp.darkRed,
                              borderRadius: BorderRadius.circular(5))),
                    ]),
                    SizedBox(
                      height: 15,
                    ),
                    ListView.builder(
                        itemCount: invoicController.dataInvoice.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return InkWell(
                            child: Table(
                              border: TableBorder.symmetric(
                                  outside: BorderSide.merge(
                                      BorderSide(color: ColorApp.lightBlack),
                                      BorderSide(color: ColorApp.lightBlack))),
                              children: [
                                TableRow(
                                    children: [
                                      TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Center(
                                            heightFactor: 5,
                                            child: Text(
                                              "${invoicController.dataInvoice[index].invoiceId}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displaySmall!
                                                  .copyWith(
                                                      color:
                                                          ColorApp.lightBlack,
                                                      fontSize: 10),
                                            ),
                                          )),
                                      TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Center(
                                            child: Text(
                                              "${invoicController.dataInvoice[index].invoiceProductName}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displaySmall!
                                                  .copyWith(
                                                      color:
                                                          ColorApp.lightBlack,
                                                      fontSize: 10),
                                            ),
                                          )),
                                      TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Center(
                                            child: Text(
                                              "${invoicController.dataInvoice[index].invoiceUserId}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displaySmall!
                                                  .copyWith(
                                                      color:
                                                          ColorApp.lightBlack,
                                                      fontSize: 10),
                                            ),
                                          )),
                                      TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Center(
                                            child: Text(
                                              "${invoicController.dataInvoice[index].invoiceTotalPrice} \$",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displaySmall!
                                                  .copyWith(
                                                      color:
                                                          ColorApp.lightBlack,
                                                      fontSize: 10),
                                            ),
                                          )),
                                      TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Center(
                                            child: Text(
                                              "${invoicController.dataInvoice[index].invoiceDate}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displaySmall!
                                                  .copyWith(
                                                      color:
                                                          ColorApp.lightBlack,
                                                      fontSize: 10),
                                            ),
                                          )),
                                      TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Center(
                                              child: NeumorphicButton(
                                            style: NeumorphicStyle(depth: 2),
                                            child: invoicController
                                                        .dataInvoice[index]
                                                        .invoicePaid ==
                                                    0
                                                ? Icon(
                                                    Icons.question_mark,
                                                    color: ColorApp.orange,
                                                  )
                                                : Icon(
                                                    Icons.done,
                                                    color: ColorApp.darkRed,
                                                  ),
                                            onPressed: () {},
                                          ))),
                                    ],
                                    decoration: BoxDecoration(
                                        color: invoicController
                                                    .dataInvoice[index]
                                                    .invoicePaid ==
                                                1
                                            ? ColorApp.middleRed
                                                .withOpacity(0.2)
                                            : ColorApp.bgMain,
                                        borderRadius: BorderRadius.circular(5)))
                              ],
                            ),
                            onTap: () async {
                              await invoicController.InvoiceOne(index);

                              Get.bottomSheet(

                                GetBuilder<AdminToolsController>(
                                    builder: (invoicController) =>
                                        HandlingStatusRemotDataRequest(
                                          statusRequest:
                                              invoicController.statusRequest,
                                          widget: Container(
                                            decoration: BoxDecoration(
                                              color: ColorApp.bgMain,
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                      top: Radius.circular(20)),
                                            ),
                                            padding: EdgeInsets.all(20),
                                            child: Form(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Neumorphic(

                                                            child:
                                                                CachedNetworkImage(
                                                                  width: 140,
                                                                  height: 150,
                                                          imageUrl:
                                                              "${ImageAssetApp.ImageStorePro}/${invoicController.dataInvoiceOne[0].invoiceProductImg}",
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
                                                        flex: 1,
                                                      ),
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            '${invoicController.dataInvoiceOne[0].invoiceProductName}',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .displaySmall!,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                'Product-ID'.tr,
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .displaySmall!
                                                                    .copyWith(
                                                                        color: ColorApp
                                                                            .lightBlack),
                                                              ),
                                                              Text(
                                                                ' ${invoicController.dataInvoiceOne[0].invoiceProductID} ',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .displaySmall!
                                                                    .copyWith(
                                                                        color: ColorApp
                                                                            .lightBlack),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                'invoice-ID'.tr,
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .displaySmall!
                                                                    .copyWith(
                                                                        color: ColorApp
                                                                            .lightBlack),
                                                              ),
                                                              Text(
                                                                ' ${invoicController.dataInvoiceOne[0].invoiceId} ',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .displaySmall!
                                                                    .copyWith(
                                                                        color: ColorApp
                                                                            .lightBlack),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(height: 20),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          'calculetway'.tr,
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .displaySmall!
                                                              .copyWith(
                                                                  color: ColorApp
                                                                      .lightBlack,
                                                                  fontSize: 8),
                                                        ),
                                                        flex: 1,
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          ' (  ${invoicController.dataInvoiceOne[0].invoiceProductQuantity}  X  ${invoicController.dataInvoiceOne[0].invoiceProductPrice}  ) + (  ${invoicController.dataInvoiceOne[0].invoiceProductQuantity}  X  ${invoicController.dataInvoiceOne[0].invoicePriceShip}  )  ,Discount (  ${invoicController.getTotalDiscount(invoicController.dataInvoiceOne[0].invoiceProductQuantity, invoicController.dataInvoiceOne[0].invoiceProductPrice, invoicController.dataInvoiceOne[0].invoicePriceShip, invoicController.dataInvoiceOne[0].invoiceProductDiscount)!} \$ )  ',
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .displaySmall!
                                                              .copyWith(
                                                                  color: ColorApp
                                                                      .lightBlack,
                                                                  fontSize: 12),
                                                        ),
                                                        flex: 1,
                                                      ),
                                                    ],
                                                  ),

                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          'Total'.tr,
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .displaySmall!
                                                              .copyWith(
                                                                  color: ColorApp
                                                                      .middleRed,
                                                                  fontSize: 12),
                                                        ),
                                                        flex: 1,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          ' ${invoicController.getTotal(invoicController.dataInvoiceOne[0].invoiceProductQuantity, invoicController.dataInvoiceOne[0].invoiceProductPrice, invoicController.dataInvoiceOne[0].invoicePriceShip, invoicController.dataInvoiceOne[0].invoiceProductDiscount)}',
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .displaySmall!
                                                              .copyWith(
                                                                  color: ColorApp
                                                                      .middleRed,
                                                                  fontSize: 12),
                                                        ),
                                                        flex: 1,
                                                      ),
                                                    ],
                                                  ),
                                                   Expanded(
                                                    child: Neumorphic(
                                                        style: NeumorphicStyle(
                                                          depth: 1,
                                                          boxShape: NeumorphicBoxShape
                                                              .roundRect(
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                        ),
                                                        child: Center(
                                                          child: Table(
                                                            children: [
                                                              TableRow(
                                                                  children: [
                                                                    Expanded(
                                                                      child: GenerateQr(
                                                                          h: 110,
                                                                          w: 110,
                                                                          value: "${invoicController.dataInvoiceOne[0].invoiceProductQuantity}\n"
                                                                              "${invoicController.dataInvoiceOne[0].invoiceProductName}\n"
                                                                              "${invoicController.dataInvoiceOne[0].invoiceProductImg}\n"
                                                                              "${invoicController.dataInvoiceOne[0].invoiceProductID}\n"
                                                                              "${invoicController.dataInvoiceOne[0].invoiceProductPrice}\n"
                                                                              "${invoicController.dataInvoiceOne[0].invoiceProductDiscount}\n"
                                                                              "${invoicController.getTotal(invoicController.dataInvoiceOne[0].invoiceProductQuantity, invoicController.dataInvoiceOne[0].invoiceProductPrice, invoicController.dataInvoiceOne[0].invoicePriceShip, invoicController.dataInvoiceOne[0].invoiceProductDiscount)}\n"
                                                                              "${invoicController.dataInvoiceOne[0].invoicePriceShip}\n"
                                                                              "${invoicController.dataInvoiceOne[0].invoiceShipCo}\n"
                                                                              "${invoicController.dataInvoiceOne[0].invoiceUserId}\n"
                                                                              "${invoicController.dataInvoiceOne[0].invoiceId}\n"
                                                                              "${invoicController.dataInvoiceOne[0].invoicePaid}\n"
                                                                              "${invoicController.dataInvoiceOne[0].invoiceDate}"),
                                                                      flex: 3,
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Expanded(
                                                                          child: invoicController.dataInvoiceOne[0].invoicePaid == 0
                                                                              ? NeumorphicButton(
                                                                                  style: NeumorphicStyle(depth: 2),
                                                                                  child: Text("NotPaid".tr, style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorApp.lightRed, fontSize: 12)),
                                                                                  onPressed: () {
                                                                                    Get.defaultDialog(
                                                                                      title: "Payment".tr,
                                                                                      titleStyle: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 15),
                                                                                      content: Neumorphic(
                                                                                          child: Column(
                                                                                        children: [
                                                                                          Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            children: [
                                                                                              Text("PaidMsg".tr, style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorApp.darkBlack, fontSize: 12)),

                                                                                              Text("  ${invoicController.getTotal(invoicController.dataInvoiceOne[0].invoiceProductQuantity, invoicController.dataInvoiceOne[0].invoiceProductPrice, invoicController.dataInvoiceOne[0].invoicePriceShip, invoicController.dataInvoiceOne[0].invoiceProductDiscount)} \$", style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorApp.darkRed, fontSize: 12))
                                                                                            ],
                                                                                          ),
                                                                                          SizedBox(height: 20,),
                                                                                          NeumorphicButton(
                                                                                            child: Text("Clickhere".tr, style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorApp.darkRed, fontSize: 12)),
                                                                                            onPressed: () async {
                                                                                              invoicController.InvoiceUpadte(invoicController.dataInvoiceOne[0].invoiceId, invoicController.dataInvoiceOne[0].invoiceProductID,invoicController.dataInvoiceOne[0].invoiceProductQuantity);
                                                                                              Get.back();              Get.back();
                                                                                            },

                                                                                          ),
                                                                                        ],
                                                                                      )),
                                                                                    );

                                                                                  },
                                                                                )
                                                                              :   NeumorphicButton(
                                                                            style: NeumorphicStyle(depth: 2),
                                                                            child:
                                                                            Column(children: [
                                                                              Text("Paid".tr, style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorApp.blue, fontSize: 12)),
                                                                           invoicController.dataSelectUser.isEmpty?CircularProgressIndicator(color: ColorApp.darkRed,):

                                                                              Text("${invoicController.profileModelSelectUser!.usersEmail}", style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorApp.blue, fontSize: 12)),

                                                                            ],),

                                                                            onPressed: () {
                                                                              invoicController.dataSelectUser.isNotEmpty?  launchUrl(Uri.parse("mailto:${invoicController.profileModelSelectUser!.usersEmail}",)):null;
                                                                            },
                                                                          ),
                                                                          flex:
                                                                              1,
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ]),
                                                            ],
                                                          ),
                                                        )),
                                                    flex: 1,
                                                  ),

                                                ],
                                              ),
                                            ),
                                          ),
                                        )),
                              );
                            },
                          );
                        }),
                  ],
                ))));
  }
}
