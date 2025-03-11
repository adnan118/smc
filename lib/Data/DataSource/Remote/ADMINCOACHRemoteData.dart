import '../../../DB/CRUD.dart';
import '../../../LinksConnect/LinksAPI.dart';

class ADMINCOACHRemoteData {
  CRUD crud;

  ADMINCOACHRemoteData(this.crud);

  deleteToBeCoach(
      user_id,

      ) async {
    var response = await crud.postData(LinksApp.linkDeleteToBeCoach, {
      "users_id": user_id.toString(),

    });
    return response.fold((l) => l, (r) => r);
  }

  approveToBeCoach(
    user_id,
    coach_name,
    coach_phone,
    coach_email,
    coach_password,
    coach_image,
    coupon_count,
  ) async {
    var response = await crud.postData(LinksApp.linkApproveToBeCoach, {
      "users_id": user_id.toString(),
      "coach_name": coach_name,
      "coach_phone": coach_phone,
      "coach_email": coach_email,
      "coach_password": coach_password,
      "coach_image": coach_image,
      "coupon_count": coupon_count,
    });
    return response.fold((l) => l, (r) => r);
  }

  UserAskBeCoach() async {
    var response = await crud.postData(LinksApp.linkUserAskBeCoach, {});
    return response.fold((l) => l, (r) => r);
  }

  Allcoaches() async {
    var response = await crud.postData(LinksApp.linkGetcoaches, {});
    return response.fold((l) => l, (r) => r);
  }

  deletecoach(coach_id, users_id) async {
    var response = await crud.postData(LinksApp.linkDeletecoach, {
      "coach_id": coach_id.toString(),
      "users_id": users_id.toString(),
    });
    return response.fold((l) => l, (r) => r);
  }

  Allusers() async {
    var response = await crud.postData(LinksApp.linkAllusers, {});
    return response.fold((l) => l, (r) => r);
  }

  getDataProfileSelectUser(usersId) async {
    var response = await crud
        .postData(LinksApp.linkSearchUser, {"users_id": usersId.toString()});
    return response.fold((l) => l, (r) => r);
  }

  changelevelSelectUser(usersId, users_level) async {
    var response = await crud.postData(LinksApp.linkChangelevel, {
      "users_id": usersId,
      "users_level": users_level,
    });
    return response.fold((l) => l, (r) => r);
  }

  insertNotification(notification_userID, notification_title, notification_body,
      notification_namePage) async {
    var response = await crud.postData(LinksApp.linkNotificationInsert, {
      "notification_userID": notification_userID,
      "notification_title": notification_title,
      "notification_body": notification_body,
      "notification_namePage": notification_namePage,
    });
    return response.fold((l) => l, (r) => r);
  }

  getAllUsersInvoice() async {
    var response = await crud.postData(LinksApp.linkAllUsersInvoice, {});
    return response.fold((l) => l, (r) => r);
  }

  getExpSub() async {
    var response = await crud.postData(LinksApp.linkExpSub, {});
    return response.fold((l) => l, (r) => r);
  }

  getUnpaidSub() async {
    var response = await crud.postData(LinksApp.linkUnpaidSub, {});
    return response.fold((l) => l, (r) => r);
  }

  paiedInvoice(usersId, invoice_id, product_id, product_quantity) async {
    var response = await crud.postData(LinksApp.linkInvoiceUpadte, {
      "invoice_userId": usersId,
      "invoice_id": invoice_id,
      "product_id": product_id,
      "product_quantity": product_quantity,
    });
    return response.fold((l) => l, (r) => r);
  }

  ApproveSub(sub_userId, sub_id, sub_type) async {
    var response = await crud.postData(LinksApp.linkApproveSub,
        {"sub_userId": sub_userId, "sub_id": sub_id, "sub_type": sub_type});
    return response.fold((l) => l, (r) => r);
  }

  AllSubunpaid() async {
    var response = await crud.postData(LinksApp.linkAllSubunpaid, {});
    return response.fold((l) => l, (r) => r);
  }

  AllRatingReport() async {
    var response = await crud.postData(LinksApp.linkAllRatingReport, {});
    return response.fold((l) => l, (r) => r);
  }

  DeletPostAndReport(fromusers_id, social_id, ratingReport_id) async {
    var response = await crud.postData(LinksApp.linkDeletPostAndReport, {
      "users_id": fromusers_id,
      "social_id": social_id,
      "ratingReport_id": ratingReport_id
    });
    return response.fold((l) => l, (r) => r);
  }

  CancelReport(ratingReport_id) async {
    var response = await crud.postData(LinksApp.linkDeleteReport, {
      "ratingReport_id": ratingReport_id,
    });
    return response.fold((l) => l, (r) => r);
  }

}
