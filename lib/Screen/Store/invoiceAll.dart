import 'package:cached_network_image/cached_network_image.dart';
import 'package:fancy_drawer/fancy_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../../Classes/handlingStatusRemotDataView.dart';
import '../../Controller/Store/InvoicController.dart';
import '../../Core/Constant/color.dart';
import '../../Core/Constant/imageasset.dart';
import '../../Widget/Store/generateQr.dart';

class InvoiceAll extends StatefulWidget {
  const InvoiceAll({Key? key}) : super(key: key);

  @override
  State<InvoiceAll> createState() => _InvoiceAllState();
}

class _InvoiceAllState extends State<InvoiceAll>
    with SingleTickerProviderStateMixin {
  late FancyDrawerController FDC_controller;

  @override
  void initState() {
    super.initState();
    FDC_controller = FancyDrawerController(
        vsync: this, duration: Duration(milliseconds: 500))
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    FDC_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     InvoicController invoicController = Get.put(InvoicController());

    final List cell;
   //  invoicController.myservices.sharedPref        .getString("myLang") ==        "ar"        ?         :  ,
    List cols = [
      "invoiceID",
      "Name",
      "Quantity",
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
        body: GetBuilder<InvoicController>(
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
                                              "${invoicController.dataInvoice[index].invoiceProductQuantity}",
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
                                GetBuilder<InvoicController>(
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
                                                  SizedBox(
                                                    height: 10,
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
                                                  SizedBox(height: 20),
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
                                                                          h: 115,
                                                                          w: 115,
                                                                          value: "${invoicController.dataInvoiceOne[0].invoiceProductQuantity}\n"
                                                                              "${invoicController.dataInvoiceOne[0].invoiceProductName}\n"
                                                                              "${invoicController.dataInvoiceOne[0].invoiceProductImg}\n"
                                                                              "${invoicController.dataInvoiceOne[0].invoiceProductID}\n"
                                                                              "${invoicController.dataInvoiceOne[0].invoiceProductPrice}\n"
                                                                              "${invoicController.dataInvoiceOne[0].invoiceProductDiscount}\n"
                                                                              "${invoicController.getTotal(invoicController.dataInvoiceOne[0].invoiceProductQuantity, invoicController.dataInvoiceOne[0].invoiceProductPrice, invoicController.dataInvoiceOne[0].invoicePriceShip, invoicController.dataInvoiceOne[0].invoiceProductDiscount)}\n"
                                                                              "${invoicController.dataInvoiceOne[0].invoicePriceShip}\n"
                                                                              "${invoicController.dataInvoiceOne[0].invoiceShipCo}\n"
                                                                              "${invoicController.viewProfileController.data[0].usersFullName}\n"
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
                                                                                      content: PaymentDialog(
                                                                                        invoiceID: invoicController.dataInvoiceOne[0].invoiceId,
                                                                                        productID: invoicController.dataInvoiceOne[0].invoiceProductID,
                                                                                        productQuantity: invoicController.dataInvoiceOne[0].invoiceProductQuantity,
                                                                                      ),
                                                                                    );
                                                                                  },
                                                                                )
                                                                              : NeumorphicButton(
                                                                                  style: NeumorphicStyle(depth: 2),
                                                                                  child: Text("Paid".tr, style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorApp.blue, fontSize: 12)),
                                                                                  onPressed: () {},
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

class PaymentDialog extends StatelessWidget {
  final invoiceID;
  final productID;
  final productQuantity;

  const PaymentDialog({Key? key, required this.invoiceID, required this.productID,required this.productQuantity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GetBuilder<InvoicController>(
            builder: (invoicController) => HandlingStatusRemotDataRequest(
                  statusRequest: invoicController.statusRequest,
                  widget: TextButton(
                      onPressed: () {    invoicController.InvoiceUpadte(invoiceID,productID,productQuantity);},
                      style: TextButton.styleFrom(
                        backgroundColor: ColorApp.bacground,
                        foregroundColor: ColorApp.bgMain,
                        shape: const BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                "assets/images/paypal.png",
                                width: 100,
                                height: 100,
                              ),
                              NeumorphicButton(
                                child: Text("Clickhere".tr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall!
                                        .copyWith(
                                            color: ColorApp.darkRed,
                                            fontSize: 12)),
                                onPressed: () async {
                                  invoicController.InvoiceUpadte(invoiceID,productID,productQuantity);
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        PaypalCheckout(
                                      sandboxMode: true,
                                      clientId:
                                          "AZ4Q8PrXEzjor2JFj6Tp-7Wd95Awu-dOxniekkKbS-DmTzM2WJ62JXQuDdkS3cFDCtqpEgFcfB-9Lg4a",
                                      secretKey:
                                          "EOhrzDNT4dnjDLwA8ccY63SxoDBILjo51VCkTWIom0icVVj4Kb3wvxr7BY6YdVAg9k1HO5yTnDE07ePs",
                                      returnURL: "success.snippetcoder.com",
                                      cancelURL: "cancel.snippetcoder.com",
                                      transactions: const [
                                        {
                                          "amount": {
                                            "total": '70',
                                            "currency": "USD",
                                            "details": {
                                              "subtotal": '70',
                                              "shipping": '0',
                                              "shipping_discount": 0
                                            }
                                          },
                                          "description":
                                              "The payment transaction description.",
                                          // "payment_options": {
                                          //   "allowed_payment_method":
                                          //       "INSTANT_FUNDING_SOURCE"
                                          // },
                                          "item_list": {
                                            "items": [
                                              {
                                                "name": "Apple",
                                                "quantity": 4,
                                                "price": '5',
                                                "currency": "USD"
                                              },
                                              {
                                                "name": "Pineapple",
                                                "quantity": 5,
                                                "price": '10',
                                                "currency": "USD"
                                              }
                                            ],
                                          }
                                        }
                                      ],
                                      note: "Contact us for any questions.",
                                      onSuccess: (Map params) async {
                                        invoicController.InvoiceUpadte(invoiceID,productID,productQuantity);
                                        print("onSuccess: $params");
                                      },
                                      onError: (error) {
                                        print("onError: $error");
                                        Navigator.pop(context);
                                      },
                                      onCancel: () {
                                        print('cancelled:');
                                      },
                                    ),
                                  ));
                                  //  invoicController.InvoiceUpadte(invoiceID);
                                },
                              )
                            ],
                          ),
                          Text("Conditionsofcarriage".tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(
                                      color: ColorApp.darkRed, fontSize: 14)),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "ConditionsofcarriageBody".tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(
                                      color: ColorApp.lightBlack,
                                      fontSize: 10)),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                              "noteWayBill".tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(
                                      color: ColorApp.middleRed, fontSize: 8)),
                        ],
                      )),
                )));
  }
}
