
import 'dart:io';

import 'package:image_picker/image_picker.dart';

import '../../../DB/CRUD.dart';
import '../../../LinksConnect/LinksAPI.dart';

class ViewProfileRemoteData {
  CRUD crud;

  ViewProfileRemoteData(this.crud);

  getDataProfile(usersId) async {
    var response = await crud.postData(LinksApp.linkProfileData, {
      "users_id":usersId
    });
    return response.fold((l) => l, (r) => r);
  }

  //********************************** edit

  getDataEditProfileWithFile(usersId, users_fullName, users_email, users_phone, users_password, users_name, users_image, myfile) async {
    var response = await crud.postRequestWithFile(LinksApp.linkEditProfileData, {
      "users_id": usersId,
      "users_fullName": users_fullName,
      "users_name": users_name,
      "users_email": users_email,
      "users_phone": users_phone,
      "users_password": users_password,
      "users_image": users_image,
    }, myfile);

    // Assuming response is a Map, not using fold
    return response; // Return the response directly
  }

  getDataEditProfileWithoutFile(usersId,users_fullName,users_email,users_phone,users_password,users_name,users_image) async {
    var response = await crud.postData(LinksApp.linkEditProfileData, {
      "users_id":usersId,
      "users_fullName":users_fullName,
      "users_name":users_name,
      "users_email":users_email,
      "users_phone":users_phone,
      "users_password":users_password,
      "users_image":users_image,
    });
    return response.fold((l) => l, (r) => r);
  }


  updateCoachMemberShip(usersId) async {
    var response = await crud.postData(LinksApp.linkProfileCoachMemberShip, {
      "users_id":usersId,
    });
    return response.fold((l) => l, (r) => r);
  }
}

