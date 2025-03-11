
import '../../../../DB/CRUD.dart';
import '../../../LinksConnect/LinksAPI.dart';

class  ResetPasswordRemoteData {
  CRUD crud;
  ResetPasswordRemoteData(this.crud);

  postData( email , password)async{
    var response = await crud.postData(LinksApp.linkResetPassword, {
      "users_email": email,
      "users_password": password,
    });
    return response.fold((l) => l, (r) => r);
  }
}