class InvoiceModel {
  int? invoiceId;
  int? invoiceUserId;
  int? invoiceProductID;
  String? invoiceProductName;
  int? invoiceProductQuantity;
  int? invoiceProductPrice;
  int? invoiceProductDiscount;
  int? invoicePriceShip;
  int? invoiceTotalPrice;
  String? invoiceShipCo;
  int? invoicePaid;
  String? invoiceDate;
  String? invoiceProductImg;

  InvoiceModel(
      {this.invoiceId,
        this.invoiceUserId,
        this.invoiceProductID,
        this.invoiceProductName,
        this.invoiceProductQuantity,
        this.invoiceProductPrice,
        this.invoiceProductDiscount,
        this.invoicePriceShip,
        this.invoiceTotalPrice,
        this.invoiceShipCo,
        this.invoicePaid,
        this.invoiceProductImg,
        this.invoiceDate});

  InvoiceModel.fromJson(Map<String, dynamic> json) {
    invoiceId = json['invoice_id'];
    invoiceProductImg = json['invoice_productImg'];
    invoiceUserId = json['invoice_userId'];
    invoiceProductID = json['invoice_productID'];
    invoiceProductName = json['invoice_productName'];
    invoiceProductQuantity = json['invoice_productQuantity'];
    invoiceProductPrice = json['invoice_productPrice'];
    invoiceProductDiscount = json['invoice_productDiscount'];
    invoicePriceShip = json['invoice_priceShip'];
    invoiceTotalPrice = json['invoice_totalPrice'];
    invoiceShipCo = json['invoice_shipCo'];
    invoicePaid = json['invoice_paid'];
    invoiceDate = json['invoice_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['invoice_id'] = this.invoiceId;
    data['invoice_productImg'] = this.invoiceProductImg;

    data['invoice_userId'] = this.invoiceUserId;
    data['invoice_productID'] = this.invoiceProductID;
    data['invoice_productName'] = this.invoiceProductName;
    data['invoice_productQuantity'] = this.invoiceProductQuantity;
    data['invoice_productPrice'] = this.invoiceProductPrice;
    data['invoice_productDiscount'] = this.invoiceProductDiscount;
    data['invoice_priceShip'] = this.invoicePriceShip;
    data['invoice_totalPrice'] = this.invoiceTotalPrice;
    data['invoice_shipCo'] = this.invoiceShipCo;
    data['invoice_paid'] = this.invoicePaid;
    data['invoice_date'] = this.invoiceDate;
    return data;
  }
}