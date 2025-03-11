class SocialBSModel {
  int? socialBSId;
  String? socialBSImg;
  String? socialBSUrl;
  String? socialBSDate;
  String? socialBSTitle;
  String? socialBSTitleAr;

  SocialBSModel(
      {this.socialBSId,
        this.socialBSImg,
        this.socialBSUrl,
        this.socialBSDate,
        this.socialBSTitle,
        this.socialBSTitleAr});

  SocialBSModel.fromJson(Map<String, dynamic> json) {
    socialBSId = json['socialBS_id'];
    socialBSImg = json['socialBS_img'];
    socialBSUrl = json['socialBS_url'];
    socialBSDate = json['socialBS_date'];
    socialBSTitle = json['socialBS_title'];
    socialBSTitleAr = json['socialBS_title_ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['socialBS_id'] = this.socialBSId;
    data['socialBS_img'] = this.socialBSImg;
    data['socialBS_url'] = this.socialBSUrl;
    data['socialBS_date'] = this.socialBSDate;
    data['socialBS_title'] = this.socialBSTitle;
    data['socialBS_title_ar'] = this.socialBSTitleAr;
    return data;
  }
}