class ReportModel {
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
  int? socialId;
  int? socialUserId;
  String? socialUrl;
  int? socialRate;
  String? socialDate;
  int? ratingReportId;
  int? ratingReportSocialId;
  int? ratingReportFromuser;
  String? ratingReportComments;
  String? ratingReportDate;

  ReportModel(
      {this.usersId,
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
        this.useresCoachMember,
        this.socialId,
        this.socialUserId,
        this.socialUrl,
        this.socialRate,
        this.socialDate,
        this.ratingReportId,
        this.ratingReportSocialId,
        this.ratingReportFromuser,
        this.ratingReportComments,
        this.ratingReportDate});

  ReportModel.fromJson(Map<String, dynamic> json) {
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
    socialId = json['social_id'];
    socialUserId = json['social_userId'];
    socialUrl = json['social_url'];
    socialRate = json['social_rate'];
    socialDate = json['social_date'];
    ratingReportId = json['ratingReport_id'];
    ratingReportSocialId = json['ratingReport_social_id'];
    ratingReportFromuser = json['ratingReport_fromuser'];
    ratingReportComments = json['ratingReport_comments'];
    ratingReportDate = json['ratingReport_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    data['social_id'] = this.socialId;
    data['social_userId'] = this.socialUserId;
    data['social_url'] = this.socialUrl;
    data['social_rate'] = this.socialRate;
    data['social_date'] = this.socialDate;
    data['ratingReport_id'] = this.ratingReportId;
    data['ratingReport_social_id'] = this.ratingReportSocialId;
    data['ratingReport_fromuser'] = this.ratingReportFromuser;
    data['ratingReport_comments'] = this.ratingReportComments;
    data['ratingReport_date'] = this.ratingReportDate;
    return data;
  }
}