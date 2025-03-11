
import 'dart:io';

import 'package:image_picker/image_picker.dart';

import '../../../DB/CRUD.dart';
import '../../../LinksConnect/LinksAPI.dart';

class CoachRemoteData {
  CRUD crud;

  CoachRemoteData(this.crud);
  getDataAllTrainees(usersId) async {
    var response = await crud.postData(LinksApp.linkAllTrainees, {
      "users_id":usersId
    });
    return response.fold((l) => l, (r) => r);
  }
  getDataProfileSelectUser(usersId) async {
    var response = await crud.postData(LinksApp.linkSearchUser, {
      "users_id":usersId.toString()
    });
    return response.fold((l) => l, (r) => r);
  }
  changelevelSelectUser(usersId,users_level) async {
    var response = await crud.postData(LinksApp.linkChangelevel, {
      "users_id":usersId,
      "users_level":users_level,
    });
    return response.fold((l) => l, (r) => r);
  }
  deleteSelectUserfromcoach(usersId,users_coachID) async {
    var response = await crud.postData(LinksApp.linkDeleteUserFromCoach, {
      "users_id":usersId,
      "users_coachID":users_coachID,
    });
    return response.fold((l) => l, (r) => r);
  }
  insertNotification(notification_userID, notification_title, notification_body,notification_namePage) async {
    var response = await crud.postData(LinksApp.linkNotificationInsert, {
      "notification_userID":notification_userID,
      "notification_title":notification_title,
      "notification_body":notification_body,
      "notification_namePage":notification_namePage,

    });
    return response.fold((l) => l, (r) => r);
  }
}

