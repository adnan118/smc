
import 'package:smc/DB/statusRequest.dart';

handlingData(response) {
  if (response is StatusRequest) {
    //left    issue
    return response;
  } else {
    return StatusRequest.success; //return map //right
  }
}
