class CoachModel {
  int? coachId;
  String? coachName;
  String? coachPhone;
  String? coachEmail;
  String? coachPassword;
  String? coachImage;
  int? couponCount;
  int? coach_refUserid;

  CoachModel(
      {this.coachId,
        this.coachName,
        this.coachPhone,
        this.coachEmail,
        this.coachPassword,
        this.coachImage,
        this.coach_refUserid,
        this.couponCount});

  CoachModel.fromJson(Map<String, dynamic> json) {
    coachId = json['coach_id'];
    coachName = json['coach_name'];
    coachPhone = json['coach_phone'];
    coachEmail = json['coach_email'];
    coachPassword = json['coach_password'];
    coachImage = json['coach_image'];
    couponCount = json['coupon_count'];
    coach_refUserid = json['coach_refUserid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coach_id'] = this.coachId;
    data['coach_name'] = this.coachName;
    data['coach_phone'] = this.coachPhone;
    data['coach_email'] = this.coachEmail;
    data['coach_password'] = this.coachPassword;
    data['coach_image'] = this.coachImage;
    data['coupon_count'] = this.couponCount;
    data['coach_refUserid'] = this.coach_refUserid;
    return data;
  }
}