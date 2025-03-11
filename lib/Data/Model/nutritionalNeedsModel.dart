class NutritionalNeedsModel {
  int? usersId;
  String? usersName;
  int? usersWeight;
  int? usersHeight;
  int? carbMinTotal;
  int? carbMaxTotal;
  int? proteinMinTotal;
  int? proteinMaxTotal;
  int? fatMinTotal;
  int? fatMaxTotal;

  NutritionalNeedsModel(
      {this.usersId,
        this.usersName,
        this.usersWeight,
        this.usersHeight,
        this.carbMinTotal,
        this.carbMaxTotal,
        this.proteinMinTotal,
        this.proteinMaxTotal,
        this.fatMinTotal,
        this.fatMaxTotal});

  NutritionalNeedsModel.fromJson(Map<String, dynamic> json) {
    usersId = json['users_id'];
    usersName = json['users_name'];
    usersWeight = json['users_weight'];
    usersHeight = json['users_height'];
    carbMinTotal = json['carb_min_total'];
    carbMaxTotal = json['carb_max_total'];
    proteinMinTotal = json['protein_min_total'];
    proteinMaxTotal = json['protein_max_total'];
    fatMinTotal = json['fat_min_total'];
    fatMaxTotal = json['fat_max_total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['users_id'] = this.usersId;
    data['users_name'] = this.usersName;
    data['users_weight'] = this.usersWeight;
    data['users_height'] = this.usersHeight;
    data['carb_min_total'] = this.carbMinTotal;
    data['carb_max_total'] = this.carbMaxTotal;
    data['protein_min_total'] = this.proteinMinTotal;
    data['protein_max_total'] = this.proteinMaxTotal;
    data['fat_min_total'] = this.fatMinTotal;
    data['fat_max_total'] = this.fatMaxTotal;
    return data;
  }
}
