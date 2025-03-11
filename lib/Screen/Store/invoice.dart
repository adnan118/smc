/*

import 'package:flutter/material.dart';

class TemplateInvoice extends StatelessWidget {


  //info product
  final String invoice_id;
  final String invoice_productID;
  final String invoice_productName;
  final String invoice_productQuantity;
  final String invoice_productPrice;
  final String invoice_productDiscount;
  final String invoice_priceShip;
  final String invoice_totalPrice;
  final String invoice_shipCo;
  final String invoice_paid;
  final String invoice_date;


  //table inv
  final List cols;

  final List cell;

  //btn
  final void Function()? newScann;
  final void Function()? newScanngalary;
  final void Function()? clearInv;

  const TemplateInvoice(
      {Key? key,

        required this.newScann,
        required this.clearInv,
        required this.cols,
        required this.cell,
        required this.ordersPrice,
        required this.ordersTotalprice,
        required this.ordersStause,
        required this.ordersDays, required this.newScanngalary})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
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
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 115),
                  child: CustTitle(
                    text: "Invoice",
                    sizeText: 25,
                    color: Colors.black,
                  ),
                ),

                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GenerateQr(
                          value:
                          "$guestID\n$startDate\n$endDate\n$ordersId\n$ordersPrice\n$ordersTotalprice\n$ordersStause\n$ordersDays",
                          h: 100,
                          w: 100,
                        ),
                        Image.asset(
                          "assets/MyLogo.jpg",
                          height: 70,
                          width: 70,
                        ),
                      ],
                    ),
                  ],
                ),

                Container(
                  margin: EdgeInsets.only(bottom: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Header1(text: nameHotel, color: Colors.black54),
                      Header2(text: addressHotel, color: Colors.black45),
                      Header2(text: taxID, color: Colors.black45),
                      Header2(text: email, color: Colors.blue.withOpacity(0.5)),
                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Header2(
                          text: "Users id : $guestID", color: Colors.black54),
                      Header2(
                          text: "orders Id:  $ordersId", color: Colors.black45),
                      Header2(
                          text: "Start Date:  $startDate",
                          color: Colors.black45),
                      Header2(
                          text: "End Date:  $endDate", color: Colors.black45),
                      const SizedBox(
                        width: 75,
                      ),
                      Header2(
                          text: "booking Status: $ordersStause",
                          color: Colors.black45),
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
                    Table(
                      //      border: TableBorder.all(),
                      children: [
                        TableRow(
                            children: [
                              TableCell(
                                  child: Center(
                                    child: CustTitle(
                                      text: cols[0],
                                      color: Colors.white,
                                      sizeText: 16,
                                    ),
                                  )),
                              TableCell(
                                  child: Center(
                                    child: CustTitle(
                                      text: cols[1],
                                      color: Colors.white,
                                      sizeText: 16,
                                    ),
                                  )),
                              TableCell(
                                  child: Center(
                                    child: CustTitle(
                                      text: cols[2],
                                      color: Colors.white,
                                      sizeText: 16,
                                    ),
                                  )),
                              TableCell(
                                  child: Center(
                                    child: CustTitle(
                                      text: cols[3],
                                      color: Colors.white,
                                      sizeText: 16,
                                    ),
                                  )),
                            ],
                            decoration: BoxDecoration(
                                color: Colors.grey.shade700,
                                borderRadius: BorderRadius.circular(5))),
                        TableRow(children: [
                          TableCell(child: Center(child: Text(cell[0]))),
                          TableCell(
                              child: Center(child: Text('${cell[1]} \$'))),
                          TableCell(child: Center(child: Text('${cell[2]} '))),
                          TableCell(
                              child: Center(child: Text('${cell[3]} \$'))),
                        ]),
                      ],
                    )
                  ],
                ),
                // Obx(() => Text(controller.getResult.value)),

                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BtnWithBorder(
                        text: " Scann New Invoice  ",
                        fontSize: 12,
                        color: ColorApp.primaryColor,
                        left: 10,
                        top: 20,
                        onPressed: newScann),

                    BtnWithBorder(
                        text: "Scann Galary Invoice",
                        fontSize: 12,
                        color: ColorApp.yellowDeep,
                        left: 10,
                        top: 20,
                        onPressed: newScanngalary),
                  ],
                ),
                Center(
                  child:   BtnWithBorder(
                      text: "Clear Invoice",
                      fontSize: 12,
                      color: Colors.black45,
                      left: 0,
                      top: 20,
                      onPressed: clearInv),
                )


              ],
            ))
      ],
    );
  }
}

*/