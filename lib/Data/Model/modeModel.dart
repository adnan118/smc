class ModeModel {
  int? userId;
  String? mode;
  String? totalDuration;

  ModeModel({this.userId, this.mode, this.totalDuration});

  ModeModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    mode = json['mode'];
    totalDuration = json['total_duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['mode'] = this.mode;
    data['total_duration'] = this.totalDuration;
    return data;
  }
}