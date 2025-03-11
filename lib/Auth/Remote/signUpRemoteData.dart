import '../../../../DB/CRUD.dart';
import '../../LinksConnect/LinksAPI.dart';

class SignUpRemoteData {
  CRUD crud;

  SignUpRemoteData(this.crud);

  postData(username , email , phone , password,fullname)async{
    var response = await crud.postData(LinksApp.linkSignUp, {
      "users_name": username,

      "users_email": email,
      "users_phone": phone,
      "users_password": password,
      "users_fullName": fullname,
    });
    return response.fold((l) => l, (r) => r);
  }
}
