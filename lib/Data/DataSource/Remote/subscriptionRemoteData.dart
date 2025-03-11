import '../../../DB/CRUD.dart';
import '../../../LinksConnect/LinksAPI.dart';

class SubscriptionRemoteData {
  CRUD crud;

  SubscriptionRemoteData(this.crud);

  getSubTypeSub() async {
    var response = await crud.postData(LinksApp.linkSubTypeSub, {});
    return response.fold((l) => l, (r) => r);
  }

  //*******************

  getSubCoach() async {
    var response = await crud.postData(LinksApp.linkSubCoach, {});
    return response.fold((l) => l, (r) => r);
  }

//*******************

  getSubCourses() async {
    var response = await crud.postData(LinksApp.linkSubCourses, {});
    return response.fold((l) => l, (r) => r);
  }

//*******************

  getSubServices() async {
    var response = await crud.postData(LinksApp.linkSubServices, {});
    return response.fold((l) => l, (r) => r);
  }

//*******************

  getSubscription(subUserId) async {
    var response = await crud.postData(LinksApp.linkSubscriptionOneUser,  {"sub_userId": subUserId});
    return response.fold((l) => l, (r) => r);
  }
//*******************
  getSubscriptionActive(subUserId) async {
    var response = await crud
        .postData(LinksApp.linkSubscriptionOneUserActive, {"sub_userId": subUserId});

    return response.fold((l) => l, (r) => r);
  }

//*******************

  setSubscription(
    sub_userId,
    sub_type,
    sub_course,
    sub_couch,
    sub_fee,
    sub_services,
    sub_date,
    sub_endDate,
    sub_approve,
  ) async {
    var response = await crud.postData(LinksApp.linkSubscriptionInsert, {
      "sub_userId": sub_userId,
      "sub_type": sub_type,
      "sub_course": sub_course,
      "sub_couch": sub_couch,
      "sub_fee": sub_fee,
      "sub_services": sub_services,
      "sub_date": sub_date,
      "sub_endDate": sub_endDate,
      "sub_approve": sub_approve,
    });
    return response.fold((l) => l, (r) => r);
  }
}
