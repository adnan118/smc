import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:smc/Core/Constant/imageasset.dart';
import '../../Controller/Store/readCodeController.dart';
import '../../Core/Constant/color.dart';
import 'generateQr.dart';

class TemplateInvoice extends StatelessWidget {
  //info App
  final String nameApp;
  final String addressApp;
  final String taxID;
  final String emailApp;
  final String imgApp;

  //info Invoic
  final String usersFullName;

  final String InvoiceDate;
  final String invoiceID;

  final String invoiceTotal;
  final String invoicePaid;
  final String invoiceShipCo;

  //info product
  final String productID;
  final String productName;
  final String productQuantity;
  final String productImg;
  final String productPrice;
  final String productDiscount;
  final String productCoastShip;

  //table inv
  final List cols;

  final List cell;

  final List colsInv;

  final List cellInv;

  //btn
  final void Function()? newScann;
  final void Function()? newScanngalary;
  final void Function()? clearInv;

  TemplateInvoice(
      {Key? key,
      required this.newScanngalary,
      required this.nameApp,
      required this.addressApp,
      required this.taxID,
      required this.emailApp,
      required this.InvoiceDate,
      required this.invoiceID,
      required this.invoiceTotal,
      required this.invoicePaid,
      required this.productID,
      required this.productName,
      required this.productQuantity,
      required this.productPrice,
      required this.productDiscount,
      required this.productCoastShip,
      required this.cols,
      required this.cell,
      this.newScann,
      this.clearInv,
      required this.productImg,
      required this.imgApp,
      required this.usersFullName,
      required this.invoiceShipCo,
      required this.colsInv,
      required this.cellInv})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ReadCodeController readCodeController = Get.put(ReadCodeController());

    return Neumorphic(
        style: NeumorphicStyle(
          color: ColorApp.bacground,
        ),
        child: ListView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                margin: EdgeInsets.only(bottom: 100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Stack(
                          children: [
                            Image.asset(
                              imgApp,
                              height: 222,
                              width: 222,
                            ),
                            Positioned(
                              top: 60,
                              left: 52,
                              child: Transform.rotate(
                                angle: 0.79,
                                child: readCodeController.isThereInvoice ==
                                        false
                                    ? Image.asset(
                                        "assets/images/qr.png",
                                        color: ColorApp.darkBlack,
                                        width: 114,
                                      )
                                    : GenerateQr(
                                        h: 114,
                                        w: 114,
                                        //     value: "${productQuantity}\n${productName}\n${productImg}\n${productID}\n${productPrice}\n${productDiscount}\n${ invoiceTotal}\n${productCoastShip}"),
                                        value:
                                            "${productQuantity}\n${productName}\n${productImg}\n${productID}\n${productPrice}\n${productDiscount}\n${invoiceTotal}\n"
                                            "${productCoastShip}\n${invoiceShipCo}\n${usersFullName}\n${invoiceID}\n${invoicePaid}\n${InvoiceDate}"),
                              ),
                            ),
                          ],
                        ),
                        CachedNetworkImage(
                          imageUrl:
                              "${ImageAssetApp.ImageStorePro}/$productImg",
                          width: 100,
                          fit: BoxFit.contain,
                          placeholder: (context, url) => Image.asset(
                              "assets/images/product.png",
                              color: ColorApp.bacground),
                          // صورة افتراضية
                          errorWidget: (context, url, error) => Image.asset(
                              "assets/images/product.png",
                              color: ColorApp
                                  .bacground), // صورة افتراضية في حال حدوث خطأ
                        ),
                      ],
                    ),

                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            nameApp,
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                    fontSize: 20, color: ColorApp.darkRed),
                          ),
                          Text(
                            addressApp,
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                    fontSize: 10, color: ColorApp.lightBlack),
                          ),
                          Text(
                            "taxID: ${taxID}",
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                    fontSize: 10, color: ColorApp.lightBlack),
                          ),
                          Text(
                            "Email: ${emailApp}",
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                    fontSize: 10, color: ColorApp.lightBlack),
                          ),
                          Text(
                            "Users Name : $usersFullName",
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                    fontSize: 10, color: ColorApp.lightBlack),
                          ),
                          Text(
                            "Date now : ${DateTime.now().toString().substring(0, 16)}",
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                    fontSize: 10, color: ColorApp.lightBlack),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      children: [
                        Text( textDirection: TextDirection.ltr,
                          "Invoice : #ID_$invoiceID",
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(fontSize: 13, color: ColorApp.darkRed),
                        ),
                        Table(
                          border: TableBorder.all(
                              borderRadius: BorderRadius.circular(5)),
                          children: [
                            TableRow(
                                children: [
                                  TableCell(
                                      child: Center(
                                    child: Text(
                                      colsInv[3],
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
                                    child: Text(
                                      colsInv[2],
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
                                    child: Text(
                                      colsInv[0],
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
                                    child: Text(
                                      colsInv[1],
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
                                    child: Text(
                                      colsInv[4],
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
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(5)))),
                            TableRow(children: [
                              TableCell(
                                  child: Center(
                                      child: Text(
                                '${cellInv[3]}',
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                        color: ColorApp.darkBlack,
                                        fontSize: 10),
                              ))),
                              TableCell(
                                  child: Center(
                                      child: Text(
                                '${cellInv[2]} \$',
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                        color: ColorApp.darkBlack,
                                        fontSize: 10),
                              ))),
                              TableCell(
                                  child: Center(
                                      child: Text(
                                cellInv[0],
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                        color: ColorApp.darkBlack,
                                        fontSize: 10),
                              ))),
                              TableCell(
                                  child: Center(
                                      child: Text(
                                '${cellInv[1]} \$',
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                        color: ColorApp.darkBlack,
                                        fontSize: 10),
                              ))),
                              TableCell(
                                  child: Center(
                                      child: Text(
                                '${cellInv[4] == "1" ? "Paid" : "Not Pay"}',
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                        color: ColorApp.darkBlack,
                                        fontSize: 10),
                              ))),
                            ]),
                          ],
                        )
                      ],
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      children: [
                        Text( textDirection: TextDirection.ltr,
                          "Product : #ID_$productID",
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(fontSize: 13, color: ColorApp.darkRed),
                        ),
                        Table(
                          border: TableBorder.all(
                              borderRadius: BorderRadius.circular(5)),
                          children: [
                            TableRow(
                                children: [
                                  TableCell(
                                      child: Center(
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
                                ],
                                decoration: BoxDecoration(
                                    color: ColorApp.darkRed,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(5)))),
                            TableRow(children: [
                              TableCell(
                                  child: Center(
                                      child: Text(
                                cell[0],
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                        color: ColorApp.darkBlack,
                                        fontSize: 10),
                              ))),
                              TableCell(
                                  child: Center(
                                      child: Text(
                                '${cell[1]} \$',
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                        color: ColorApp.darkBlack,
                                        fontSize: 10),
                              ))),
                              TableCell(
                                  child: Center(
                                      child: Text(
                                '${cell[2]} ',
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                        color: ColorApp.darkBlack,
                                        fontSize: 10),
                              ))),
                              TableCell(
                                  child: Center(
                                      child: Text(
                                '${cell[3]} \$',
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                        color: ColorApp.darkBlack,
                                        fontSize: 10),
                              ))),
                              TableCell(
                                  child: Center(
                                      child: Text(
                                '${cell[4]} %',
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                        color: ColorApp.darkBlack,
                                        fontSize: 10),
                              ))),
                            ]),
                          ],
                        )
                      ],
                    ),
                    // Obx(() => Text(controller.getResult.value)),

                    const SizedBox(
                      height: 20,
                    ),
                  Row(mainAxisAlignment: MainAxisAlignment.center,children: [  Text( textDirection: TextDirection.ltr,
                    "Scan Invoice",
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(fontSize: 13, color: ColorApp.darkRed),
                  ),],),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        NeumorphicButton(
                          child: Text(
                            "Camera",
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                    color: ColorApp.lightBlack, fontSize: 12),
                          ),
                          onPressed: newScann,
                        ),
                        NeumorphicButton(
                          child: Text(
                            "Gallery",
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                    color: ColorApp.lightBlack, fontSize: 12),
                          ),
                          onPressed: newScanngalary,
                        ),
                        NeumorphicButton(
                          child: Text(
                            "Clear",
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                    color: ColorApp.lightBlack, fontSize: 12),
                          ),
                          onPressed: clearInv,
                        ),
                      ],
                    ),
                  ],
                ))
          ],
        ));
  }
}
