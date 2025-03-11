class ProfileModel {
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
  int? coachId;
  String? coachName;
  String? coachPhone;
  String? coachEmail;
  String? coachPassword;
  String? coachImage;
  int? useresCoachMember;

  ProfileModel(
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
        this.coachId,
        this.coachName,
        this.coachPhone,
        this.coachEmail,
        this.coachPassword,
        this.coachImage,
        this.useresCoachMember

      });

  ProfileModel.fromJson(Map<String, dynamic> json) {
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
    coachId = json['coach_id'];
    coachName = json['coach_name'];
    coachPhone = json['coach_phone'];
    coachEmail = json['coach_email'];
    coachPassword = json['coach_password'];
    coachImage = json['coach_image'];
    useresCoachMember = json['useres_CoachMember'];
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
    data['coach_id'] = this.coachId;
    data['coach_name'] = this.coachName;
    data['coach_phone'] = this.coachPhone;
    data['coach_email'] = this.coachEmail;
    data['coach_password'] = this.coachPassword;
    data['coach_image'] = this.coachImage;
    data['useres_CoachMember'] = this.useresCoachMember;
    return data;
  }
}