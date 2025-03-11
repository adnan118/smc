import 'dart:io';

import 'package:image_picker/image_picker.dart';

import '../../../../DB/CRUD.dart';
import '../../../LinksConnect/LinksAPI.dart';

class EditProfileRemoteData {
  CRUD crud;

  EditProfileRemoteData(this.crud);

  getDataEditProfileWithFile(usersId,users_fullName,users_email,users_phone,users_password,users_desc,users_image ,myfile) async {
    var response = await crud.postRequestWithFile(LinksApp.linkEditProfileData, {
      "users_id":usersId,
      "users_fullName":users_fullName,
      "users_email":users_email,
      "users_phone":users_phone,
      "users_password":users_password,
      "users_desc":users_desc,
      "users_image":users_image,
    },
        myfile
    );
    // return response.fold((l) => l, (r) => r);
  }

  getDataEditProfileWithoutFile(usersId,users_fullName,users_email,users_phone,users_password,users_desc,users_image) async {
    var response = await crud.postData(LinksApp.linkEditProfileData, {
      "users_id":usersId,
      "users_fullName":users_fullName,
      "users_email":users_email,
      "users_phone":users_phone,
      "users_password":users_password,
      "users_desc":users_desc,
      "users_image":users_image,
    });
    return response.fold((l) => l, (r) => r);
  }
}

