import '../../../../DB/CRUD.dart';
import '../../LinksConnect/LinksAPI.dart';

class VfcSignUpRemoteData {
  CRUD crud;

  VfcSignUpRemoteData(this.crud);

  postData(email, vfc) async {
    var response = await crud.postData(LinksApp.linkVfcSign, {
      "users_email": email,
      "users_verflyCode": vfc,
    });
    return response.fold((l) => l, (r) => r);
  }


  resendData(email) async {
    var response = await crud.postData(LinksApp.linkResendVfcSign, {
      "users_email": email,
    });
    return response.fold((l) => l, (r) => r);
  }

}
