
import 'package:get/get.dart';
import '../DB/CRUD.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CRUD());
  }
}
