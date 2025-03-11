import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:smc/Widget/Store/templateInvoice.dart';

import '../../Controller/Store/readCodeController.dart';
import '../../Core/Constant/color.dart';

class ReadCodeInvoice extends StatelessWidget {
  ReadCodeInvoice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ReadCodeController readCodeController = Get.put(ReadCodeController());

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "ScanaInvoice".tr,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        body: Neumorphic(style: NeumorphicStyle(color:  ColorApp.bacground,),child: GetBuilder<ReadCodeController>(
      builder: (controller) => controller.isThereInvoice == false
          ? TemplateInvoice(
              nameApp: "SMC",
              addressApp: "Syria / Hama",
              taxID: "118259",
              emailApp: "offical.sysmangmentcenter@smc.com",
              imgApp: "assets/images/smartLogo - Desgn.png",
              usersFullName: "---",
              InvoiceDate: "Date ",
              productID: "0",
              productPrice: "0",
              invoiceTotal: "0",
              invoicePaid: "0",
              invoiceID: "0",
              invoiceShipCo: "none",
              productCoastShip: "0",
              productImg: "product.png",
              productName: "product",
              productQuantity: "0",
              productDiscount: "0",
           cols: ["Name", "Price", "Quantity", "Total", "Discount"],
              cell: ["---", "0", "0", "0", "0"],
        colsInv:  ["Date", "Total", "Coast Ship", "Ship Co", "Status"],
        cellInv: [
          "0000-00-00 00:00:00","0","0","none","not Paid"
        ],

              newScann: () {
                controller.scanQRCode();
              },
              newScanngalary: () {
                controller.scanBarcodeFromGallery();
              },
              clearInv: () {
                controller.clearIsThereInvoice();
              },
            )

          : TemplateInvoice(
              nameApp: "SMC",
              addressApp: "Syria / Hama",
              taxID: "118259",
              emailApp: "offical.sysmangmentcenter@smc.com",
              imgApp: "assets/images/smartLogo - Desgn.png",
              usersFullName: "${readCodeController.results[9]}",
              InvoiceDate: "${readCodeController.results[12]}",
              productID: "${readCodeController.results[3]}",
              productPrice: "${readCodeController.results[4]}",
              invoiceTotal: "${readCodeController.results[6]}",
              invoicePaid: "${readCodeController.results[11]}",
              invoiceID: "${readCodeController.results[10]}",
              productCoastShip: "${readCodeController.results[7]}",
              invoiceShipCo: "${readCodeController.results[8]}",
              productImg:"${readCodeController.results[2]}",
              productName:"${readCodeController.results[1]}",
              productQuantity:  "${readCodeController.results[0]}",
              productDiscount:"${readCodeController.results[5]}",

       // productID: "${readCodeController.results[3]}",
      //   productImg:"${readCodeController.results[2]}",

              cols: ["Name", "Price", "Quantity", "Total", "Discount"],
              cell: [
                "${readCodeController.results[1]}",
                "${readCodeController.results[4]}",
                "${readCodeController.results[0]}",
                "${readCodeController.results[6]}",
                "${readCodeController.results[5]}",
              ],
          colsInv:  ["Date", "Total", "Coast Ship", "Ship Co", "Status"],
          cellInv: [
            "${readCodeController.results[12]}",
            "${readCodeController.results[6]}",
            "${readCodeController.results[7]}",
            "${readCodeController.results[8]}",
            "${readCodeController.results[11]}",
          ],


              newScann: () {
                controller.scanQRCode();
              },
              newScanngalary: () {
                controller.scanBarcodeFromGallery();
              },
              clearInv: () {
                controller.clearIsThereInvoice();
              },
            ),
            ),
    ));
  }
}
