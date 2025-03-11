
import 'dart:io';

import 'package:image_picker/image_picker.dart';

import '../../../DB/CRUD.dart';
import '../../../LinksConnect/LinksAPI.dart';

class NutritionalNeedRemoteData {
  CRUD crud;

  NutritionalNeedRemoteData(this.crud);

  getDataNutritionalNeed(usersId) async {
    var response = await crud.postData(LinksApp.linkNutritionalNeed, {
      "users_id":usersId
    });
    return response.fold((l) => l, (r) => r);
  }
}

