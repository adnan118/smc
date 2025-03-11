class NotificationsModel {
  int? notificationId;
  int? notificationUserID;
  String? notificationTitle;
  String? notificationBody;
  String? notificationDate;
  String? notificationNamePage;

  NotificationsModel(
      {this.notificationId,
        this.notificationUserID,
        this.notificationTitle,
        this.notificationBody,
        this.notificationDate,
        this.notificationNamePage});

  NotificationsModel.fromJson(Map<String, dynamic> json) {
    notificationId = json['notification_id'];
    notificationUserID = json['notification_userID'];
    notificationTitle = json['notification_title'];
    notificationBody = json['notification_body'];
    notificationDate = json['notification_date'];
    notificationNamePage = json['notification_namePage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notification_id'] = this.notificationId;
    data['notification_userID'] = this.notificationUserID;
    data['notification_title'] = this.notificationTitle;
    data['notification_body'] = this.notificationBody;
    data['notification_date'] = this.notificationDate;
    data['notification_namePage'] = this.notificationNamePage;
    return data;
  }
}