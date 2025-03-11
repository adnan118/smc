class SubscriptionModel {
  int? subId;
  int? subInvoice;
  int? subType;
  int? subUserId;
  int? subCourse;
  int? subCouch;
  int? subFee;
  int? subServices;
  String? subDate;
  String? subEndDate;
  int? subApprove;

  SubscriptionModel(
      {this.subId,
        this.subInvoice,
        this.subType,
        this.subUserId,
        this.subCourse,
        this.subCouch,
        this.subFee,
        this.subServices,
        this.subDate,
        this.subEndDate,
        this.subApprove});

  SubscriptionModel.fromJson(Map<String, dynamic> json) {
    subId = json['sub_id'];
    subInvoice = json['sub_invoice'];
    subType = json['sub_type'];
    subUserId = json['sub_userId'];
    subCourse = json['sub_course'];
    subCouch = json['sub_couch'];
    subFee = json['sub_fee'];
    subServices = json['sub_services'];
    subDate = json['sub_date'];
    subEndDate = json['sub_endDate'];
    subApprove = json['sub_approve'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sub_id'] = this.subId;
    data['sub_invoice'] = this.subInvoice;
    data['sub_type'] = this.subType;
    data['sub_userId'] = this.subUserId;
    data['sub_course'] = this.subCourse;
    data['sub_couch'] = this.subCouch;
    data['sub_fee'] = this.subFee;
    data['sub_services'] = this.subServices;
    data['sub_date'] = this.subDate;
    data['sub_endDate'] = this.subEndDate;
    data['sub_approve'] = this.subApprove;
    return data;
  }
}