import '../../../DB/CRUD.dart';
import '../../../LinksConnect/LinksAPI.dart';

class SocialRemoteData {
  CRUD crud;

  SocialRemoteData(this.crud);

  getSocialAllMy(users_id) async {
    var response = await crud.postData(LinksApp.linkSocialAllMy,
        {
          "users_id": users_id.toString(),
        });
    return response.fold((l) => l, (r) => r);
  }
  getSocialAll() async {
    var response = await crud.postData(LinksApp.linkSocialAll,
        {});
    return response.fold((l) => l, (r) => r);
  }
  getSocialAllBS() async {
    var response = await crud.postData(LinksApp.linkSocialAllBS,
        {});
    return response.fold((l) => l, (r) => r);
  }
  setSocialAllBS(socialBS_id,socialBS_img, socialBS_url,socialBS_date,socialBS_title,socialBS_title_ar) async {
    var response = await crud.postData(LinksApp.linkSocialAllBSUpdate, {
      "socialBS_id": socialBS_id,
      "socialBS_img": socialBS_img,
      "socialBS_url": socialBS_url,
      "socialBS_date": socialBS_date,
      "socialBS_title": socialBS_title,
      "socialBS_title_ar": socialBS_title_ar,
    });
    return response.fold((l) => l, (r) => r);
  }

  setSocialAllBSWithFile(socialBS_id, socialBS_img, socialBS_url, socialBS_date, socialBS_title, socialBS_title_ar, myfile) async {
    var response = await crud.postRequestWithFile(LinksApp.linkSocialAllBSUpdate, {
      "socialBS_id": socialBS_id,
      "socialBS_img": socialBS_img,
      "socialBS_url": socialBS_url,
      "socialBS_date": socialBS_date,
      "socialBS_title": socialBS_title,
      "socialBS_title_ar": socialBS_title_ar,
    }, myfile);

    // Assuming response is a Map, not using fold
    return response.fold((l) => l, (r) => r);
  }
  setSocialAllReaction(
      social_id, social_rate) async {
    var response = await crud.postData(LinksApp.linkSocialAllReaction, {
      "social_id": social_id.toString(),
      "social_rate": social_rate.toString(),

    });
    return response.fold((l) => l, (r) => r);
  }

  deleteSocial(
      users_id, social_id) async {
    var response = await crud.postData(LinksApp.linkSocialDelet, {
      "users_id": users_id.toString(),
      "social_id": social_id.toString(),

    });
    return response.fold((l) => l, (r) => r);
  }

  shareMySocial(
      users_id, social_url) async {
    var response = await crud.postData(LinksApp.linkSocialInsert, {
      "users_id": users_id.toString(),
      "social_url": social_url.toString(),

    });
    return response.fold((l) => l, (r) => r);
  }


  RatingratingReport(ratingReport_fromuser,ratingReport_social_id,ratingReport_comments)async{
    var response = await crud.postData(LinksApp.linkRatingReport, {
      "ratingReport_fromuser" :ratingReport_fromuser,
      "ratingReport_social_id":ratingReport_social_id,
      "ratingReport_comments" :ratingReport_comments,

    });
    return response.fold((l) => l, (r) => r);
  }


}
