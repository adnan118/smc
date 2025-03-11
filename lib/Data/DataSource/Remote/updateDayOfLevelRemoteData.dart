

import '../../../../DB/CRUD.dart';
import '../../../LinksConnect/LinksAPI.dart';

class UpdateDayOfLevelRemoteData {
  CRUD crud;

  UpdateDayOfLevelRemoteData(this.crud);



  updateDayOfLevel(usersId, usersDaylevel) async {
    var response = await crud.postData(LinksApp.linkEditDayOfLevel, {
      "users_id":usersId,
      "users_daylevel":usersDaylevel.toString(),

    });
    return response.fold((l) => l, (r) => r);
  }
}

