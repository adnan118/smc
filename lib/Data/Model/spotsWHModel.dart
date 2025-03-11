class SpotsWHModel {
  int? spotsWHUserId;
  int? spotsWHNumMonth;
  int? spotsWHWeight;
  int? spotsWHHeight;

  SpotsWHModel(
      {this.spotsWHUserId,
        this.spotsWHNumMonth,
        this.spotsWHWeight,
        this.spotsWHHeight});

  SpotsWHModel.fromJson(Map<String, dynamic> json) {
    spotsWHUserId = json['spotsWH_userId'];
    spotsWHNumMonth = json['spotsWH_numMonth'];
    spotsWHWeight = json['spotsWH_weight'];
    spotsWHHeight = json['spotsWH_height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['spotsWH_userId'] = this.spotsWHUserId;
    data['spotsWH_numMonth'] = this.spotsWHNumMonth;
    data['spotsWH_weight'] = this.spotsWHWeight;
    data['spotsWH_height'] = this.spotsWHHeight;
    return data;
  }
}