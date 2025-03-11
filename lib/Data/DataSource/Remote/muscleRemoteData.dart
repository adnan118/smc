

import '../../../DB/CRUD.dart';
import '../../../LinksConnect/LinksAPI.dart';

class MuscleRemoteData {
  CRUD crud;

  MuscleRemoteData(this.crud);

  getExMuscle(muscleId) async {
    var response = await crud.postData(LinksApp.linkExMuscle, {
      "muscle_id":muscleId.toString()
    });
    return response.fold((l) => l, (r) => r);
  }
}
