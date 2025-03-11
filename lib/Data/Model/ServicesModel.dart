class ServicesModel {
  int? servicesId;
  String? servicesName;
  String? servicesNameAr;
  int? servicesPrice;
  int? servicesDecount;

  ServicesModel(
      {this.servicesId,
        this.servicesName,
        this.servicesNameAr,
        this.servicesPrice,
        this.servicesDecount});

  ServicesModel.fromJson(Map<String, dynamic> json) {
    servicesId = json['services_id'];
    servicesName = json['services_name'];
    servicesNameAr = json['services_name_ar'];
    servicesPrice = json['services_price'];
    servicesDecount = json['services_decount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['services_id'] = this.servicesId;
    data['services_name'] = this.servicesName;
    data['services_name_ar'] = this.servicesNameAr;
    data['services_price'] = this.servicesPrice;
    data['services_decount'] = this.servicesDecount;
    return data;
  }
}