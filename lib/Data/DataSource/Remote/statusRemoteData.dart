

import '../../../DB/CRUD.dart';
import '../../../LinksConnect/LinksAPI.dart';

class StatusRemoteData {
  CRUD crud;

  StatusRemoteData(this.crud);

  setStatus(String userId, String mode,  start_time ,end_time,is_current ) async {
    var response = await crud.postData(LinksApp.linkStatusUser, {

      'users_id': userId,
      'mode': mode,
      'start_time': start_time,
      'end_time': end_time,
      'is_current': is_current,
    });
    return response.fold((l) => l, (r) => r);
  }
}
