
import 'package:firebase_messaging/firebase_messaging.dart';
 import 'package:get/get.dart';
 import '../../Controller/Home/profileController.dart';
import '../../Controller/Store/InvoicController.dart';
import '../Services/services.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
Myservices myservices =Get.find();


requestPermissionNotifiction()async{
  NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
}
//MyNotification_Controller myNotification_Controller = Get.put(MyNotification_Controller());
GCMnotifiction(){

//يتم استدعائها في كونترولر لوكالLocalController
  FirebaseMessaging.onMessage.listen((remoteMsg) {
     print("*********title GCMnotifiction ${remoteMsg.notification!.title}*********");
    print("*********body GCMnotifiction ${remoteMsg.notification!.body}*********");
     FlutterRingtonePlayer.playNotification();
    Get.snackbar(remoteMsg.notification!.title!, remoteMsg.notification!.body!);
    /* myNotification_Controller.not.g

    add(
        ListTile(
          title: Text("${remoteMsg.notification!.title}",style: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: "Genos",
            fontSize: 20,
            color: ColorApp.primaryColor,
            height: 1.5,
          ),),
          subtitle: Text("${remoteMsg.notification!.body}",style: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: "Genos",
            fontSize: 20,
            color: ColorApp.blacklight,
            height: 1.5,
          ),),
        )
    )*/
    ;


  refreshAllINVOICENotifiction(remoteMsg.data);
  });
}

refreshAllINVOICENotifiction(data){
  print("pageid             pagename           refreshAllINVOICENotifiction          ");
  print(data["pageid"]);
  print(data["pagename"]);
  print("currentRoute     ");
  print(Get.currentRoute);

  if(Get.currentRoute == "/InvoiceAll" && data["pagename"] =="InvoiceRefresh"){
    print("refresh page  InvoiceAll    ");
    InvoicController invoicController = Get.put(InvoicController());
    invoicController.refAllInvoice();
  }
  if(Get.currentRoute == "/DrawerXProfile" && data["pagename"] =="refProfile"){
    print("refresh page  refProfile    ");
    ViewProfileController viewProfileController = Get.put(ViewProfileController());
    viewProfileController.getDataProfile();
  }
  if(Get.currentRoute == "/RootPage" && data["pagename"] =="approveCoach"){
    print("refresh page  approveCoach    ");
    ViewProfileController viewProfileController = Get.put(ViewProfileController());
    viewProfileController.getDataProfile();
    Get.offAllNamed("/RootPage");
  }
}
