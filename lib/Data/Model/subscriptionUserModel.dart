class SubscriptionUserModel {
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
  int? usersId;
  String? usersFullName;
  String? usersName;
  String? usersEmail;
  String? usersPhone;
  String? usersPassword;
  int? usersVerflyCode;
  int? usersApprove;
  String? usersCreateTime;
  String? usersImage;
  int? usersRole;
  int? usersCoachID;
  int? usersLevel;
  int? usersDaylevel;
  int? usersWeight;
  int? usersHeight;
  int? useresCoachMember;

  SubscriptionUserModel(
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
        this.subApprove,
        this.usersId,
        this.usersFullName,
        this.usersName,
        this.usersEmail,
        this.usersPhone,
        this.usersPassword,
        this.usersVerflyCode,
        this.usersApprove,
        this.usersCreateTime,
        this.usersImage,
        this.usersRole,
        this.usersCoachID,
        this.usersLevel,
        this.usersDaylevel,
        this.usersWeight,
        this.usersHeight,
        this.useresCoachMember});

  SubscriptionUserModel.fromJson(Map<String, dynamic> json) {
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
    usersId = json['users_id'];
    usersFullName = json['users_fullName'];
    usersName = json['users_name'];
    usersEmail = json['users_email'];
    usersPhone = json['users_phone'];
    usersPassword = json['users_password'];
    usersVerflyCode = json['users_verflyCode'];
    usersApprove = json['users_approve'];
    usersCreateTime = json['users_createTime'];
    usersImage = json['users_image'];
    usersRole = json['users_role'];
    usersCoachID = json['users_coachID'];
    usersLevel = json['users_level'];
    usersDaylevel = json['users_daylevel'];
    usersWeight = json['users_weight'];
    usersHeight = json['users_height'];
    useresCoachMember = json['useres_CoachMember'];
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
    data['users_id'] = this.usersId;
    data['users_fullName'] = this.usersFullName;
    data['users_name'] = this.usersName;
    data['users_email'] = this.usersEmail;
    data['users_phone'] = this.usersPhone;
    data['users_password'] = this.usersPassword;
    data['users_verflyCode'] = this.usersVerflyCode;
    data['users_approve'] = this.usersApprove;
    data['users_createTime'] = this.usersCreateTime;
    data['users_image'] = this.usersImage;
    data['users_role'] = this.usersRole;
    data['users_coachID'] = this.usersCoachID;
    data['users_level'] = this.usersLevel;
    data['users_daylevel'] = this.usersDaylevel;
    data['users_weight'] = this.usersWeight;
    data['users_height'] = this.usersHeight;
    data['useres_CoachMember'] = this.useresCoachMember;
    return data;
  }
}