import 'package:get/get.dart';
import '../../Classes/HandlingDataController.dart';
import '../../Core/Services/services.dart';
import '../../DB/statusRequest.dart';
import '../../Data/DataSource/Remote/notificationRemoteData.dart';
import '../../Data/Model/notificationsModel.dart';

class NotificationController extends GetxController {
  NotificationRemoteData notificationRemoteData =
      NotificationRemoteData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  Myservices myservices = Get.find();

  List<NotificationsModel> dataNotifications = [];


  getAllNotifications() async {
    dataNotifications.clear();
    statusRequest = StatusRequest.loading;
    var response = await notificationRemoteData.viewNotification(
      myservices.sharedPref.getInt("users_id").toString()!,

    );
    print("$response *****");
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        var dataList = response["data"] as List;
        dataNotifications =
            dataList.map((item) => NotificationsModel.fromJson(item)).toList();
      } else {
        statusRequest = StatusRequest.failuer;
      }
    }
    update();
  }

  @override
  void onInit() async {
    await getAllNotifications();
    super.onInit();
  }
}
