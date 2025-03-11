import '../../../DB/CRUD.dart';
import '../../../LinksConnect/LinksAPI.dart';

class AnalyticsRemoteData {
  CRUD crud;

  AnalyticsRemoteData(this.crud);

  getAnalyticsWH(spotsWH_userId) async {
    var response = await crud.postData(LinksApp.linkAnalyticsViewWH,
        {"spotsWH_userId": spotsWH_userId.toString()});
    return response.fold((l) => l, (r) => r);
  }

  setAnalyticsWH(
      spotsWH_userId, spotsWH_numMonth, spotsWH_weight, spotsWH_height) async {
    var response = await crud.postData(LinksApp.linkAnalyticsInsertWH, {
      "spotsWH_userId": spotsWH_userId.toString(),
      "spotsWH_numMonth": spotsWH_numMonth.toString(),
      "spotsWH_weight": spotsWH_weight.toString(),
      "spotsWH_height": spotsWH_height.toString(),
    });
    return response.fold((l) => l, (r) => r);
  }

  getAnalyticsMode(user_id) async {
    var response = await crud.postData(
        LinksApp.linkAnalyticsViewMode, {"users_id": user_id.toString()});
    return response.fold((l) => l, (r) => r);
  }
}
