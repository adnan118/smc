

import '../../../../DB/CRUD.dart';
import '../../../LinksConnect/LinksAPI.dart';

class NotificationRemoteData {
  CRUD crud;

  NotificationRemoteData(this.crud);



  insertNotification(notification_userID, notification_title, notification_body,notification_namePage) async {
    var response = await crud.postData(LinksApp.linkNotificationInsert, {
      "notification_userID":notification_userID,
      "notification_title":notification_title,
      "notification_body":notification_body,
      "notification_namePage":notification_namePage,

    });
    return response.fold((l) => l, (r) => r);
  }

  viewNotification(notification_userID) async {
    var response = await crud.postData(LinksApp.linkNotificationView, {
      "notification_userID":notification_userID.toString(),
    });
    return response.fold((l) => l, (r) => r);
  }


}

