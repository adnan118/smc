class TypeSubscriptionModel {
  int? typeSubId;
  String? typeSubName;
  String? typeSubNameAr;
  int? typeSubPrice;
  int? typeSubDiscount;

  TypeSubscriptionModel(
      {this.typeSubId,
        this.typeSubName,
        this.typeSubNameAr,
        this.typeSubPrice,
        this.typeSubDiscount});

  TypeSubscriptionModel.fromJson(Map<String, dynamic> json) {
    typeSubId = json['typeSub_id'];
    typeSubName = json['typeSub_name'];
    typeSubNameAr = json['typeSub_name_ar'];
    typeSubPrice = json['typeSub_price'];
    typeSubDiscount = json['typeSub_discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['typeSub_id'] = this.typeSubId;
    data['typeSub_name'] = this.typeSubName;
    data['typeSub_name_ar'] = this.typeSubNameAr;
    data['typeSub_price'] = this.typeSubPrice;
    data['typeSub_discount'] = this.typeSubDiscount;
    return data;
  }
}