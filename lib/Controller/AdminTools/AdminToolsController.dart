import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:smc/Core/Constant/color.dart';
import 'package:smc/Data/Model/CoachModel.dart';
import '../../Classes/HandlingDataController.dart';
import '../../Core/Services/services.dart';
import '../../DB/statusRequest.dart';
import '../../Data/DataSource/Remote/ADMINCOACHRemoteData.dart';
import '../../Data/DataSource/Remote/AnalyticsRemoteData.dart';
import '../../Data/DataSource/Remote/SocialRemoteData.dart';
import '../../Data/DataSource/Remote/storeRemoteData.dart';
import '../../Data/Model/invoiceModel.dart';
import '../../Data/Model/profileModel.dart';
import '../../Data/Model/reportModel.dart';
import '../../Data/Model/subscriptionUserModel.dart';
import '../../Screen/AdminTools/allInvoice.dart';
import '../../Screen/AdminTools/expSubscription.dart';
import '../../Screen/AdminTools/unPaidSubscription.dart';
import '../../Screen/AdminTools/viewTrainer.dart';
import '../Home/profileController.dart';
import '../Social/socialController.dart';

class AdminToolsController extends GetxController {
  ViewProfileController viewProfileController = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  Myservices myservices = Get.find();
  late TextEditingController SelectUser;
  List<ProfileModel> dataSelectUser = [];
  List<ProfileModel> dataAllusers = [];
  List<SubscriptionUserModel> dataExpSub = [];
  SubscriptionUserModel? subscriptionModel;
  ProfileModel? profileModelSelectUser;
  ProfileModel? profileModelAllTraineesr;
  InvoiceModel? invoiceModel;
  List<InvoiceModel> dataInvoice = [];
  List<InvoiceModel> dataInvoiceOne = [];
  SubscriptionUserModel? subscriptionModelunPaid;

  List<SubscriptionUserModel> datasubunPaid = [];
  List<SubscriptionUserModel> dataAllsubunPaid = [];

  // CoachModel? coachModel;
  // List<CoachModel> dataAskBeCoach = [];
  ProfileModel? profileModelAllAskBeCoach;
  List<ProfileModel> dataAllAskBeCoach = [];
  CoachModel? coachModel;
  List<CoachModel> dataCoach = [];

  ReportModel? reportModel;
  List<ReportModel> dataReport = [];
  int All1OrReq2 = 1;

  ADMINCOACHRemoteData admincoachRemoteData = ADMINCOACHRemoteData(Get.find());
  //SocialRemoteData socialRemoteData = SocialRemoteData(Get.find());
  late String user = "1";
  String sendToUser = "1";
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeySendnoti = GlobalKey<FormState>();
  late TextEditingController notificationBody;

//  SocialController socialController = Get.find();

  @override
  getData(SelectUser) {
    SelectUser.toString() == ""
        ? getDataAllusers()
        : getDataProfileSelectUser(SelectUser, true);
  }

  getRole(ProfileModel profileModel) {
    String users_role = "";
    if (profileModel!.usersRole == 0) {
      users_role = "admin";
    } else if (profileModel!.usersRole == 1) {
      users_role = "Coach";
    } else if (profileModel!.usersRole == 2) {
      users_role = "Trainee";
    }
    return users_role;
  }

  TMpressed(index) {
    if (index == 0) {
      Get.bottomSheet(
          ignoreSafeArea: false,
          isScrollControlled: true,
          //showAllTrainees()
          viewTrainer());
    } else if (index == 1) {
      Get.bottomSheet(
          ignoreSafeArea: false, isScrollControlled: true, ExpSubscription());
    } else if (index == 2) {
      Get.bottomSheet(
          ignoreSafeArea: false,
          isScrollControlled: true,
          UnpaidSubscription());
    } else if (index == 3) {
      Get.bottomSheet(
          ignoreSafeArea: false, isScrollControlled: true, InvoiceAllAdmin());
    }
  }

  getDataAllusers() async {
    dataAllusers.clear();
    //loading
    statusRequest = StatusRequest.loading;
    SelectUser = TextEditingController(text: "");

    update();
    var response = await admincoachRemoteData.Allusers();
    print("$response *****");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        if (dataAllusers == null) {
          Get.defaultDialog(
            title: "Loading".tr,
            middleText: "Please Waiting",
            content: CircularProgressIndicator(
              color: ColorApp.darkRed,
            ),
            onCancel: () {},
          );
        } else {
          List<dynamic> responseData = response['data'];

          for (var userData in responseData) {
            ProfileModel profile = ProfileModel.fromJson(userData);
            dataAllusers.add(profile);
            sendToUser = dataAllusers[0].usersId!.toString();
          }
          //     getRole( profile);
        }
      } else {
        Text("noData");
        statusRequest = StatusRequest.failuer;
      }
    }
    update();
  }

  getDataExpSub() async {
    dataExpSub.clear();
    //loading
    statusRequest = StatusRequest.loading;

    update();
    var response = await admincoachRemoteData.getExpSub();
    print("$response *****");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        if (dataExpSub == null) {
          Get.defaultDialog(
            title: "Loading".tr,
            middleText: "Please Waiting",
            content: CircularProgressIndicator(
              color: ColorApp.darkRed,
            ),
            onCancel: () {},
          );
        } else {
          List<dynamic> responseData = response['data'];

          for (var userData in responseData) {
            SubscriptionUserModel subscriptionUserModell =
                SubscriptionUserModel.fromJson(userData);
            dataExpSub.add(subscriptionUserModell);
          }
        }
      } else {
        Text("noData");
        statusRequest = StatusRequest.failuer;
      }
    }
    update();
  }

  double total = 0;
  StoreRemoteData storeRemoteData = StoreRemoteData(Get.find());

  getTotal(pice, price, ship, discount) {
    return total = (pice * price + ship * pice) -
        ((pice * price + ship * pice) * (discount / 100));
  }

  getTotalDiscount(pice, price, ship, discount) {
    var totalBeforeDiscount = pice * price + ship * pice;
    var totalDiscount = totalBeforeDiscount * (discount / 100);

    return totalDiscount;
  }

  getDataAllUsersInvoice() async {
    dataInvoice.clear();
    //loading
    statusRequest = StatusRequest.loading;

    update();
    var response = await admincoachRemoteData.getAllUsersInvoice();
    print("$response *****");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        if (dataInvoice == null) {
          Get.defaultDialog(
            title: "Loading".tr,
            middleText: "Please Waiting",
            content: CircularProgressIndicator(
              color: ColorApp.darkRed,
            ),
            onCancel: () {},
          );
        } else {
          List<dynamic> responseData = response['data'];

          for (var userData in responseData) {
            invoiceModel = InvoiceModel.fromJson(userData);
            dataInvoice.add(invoiceModel!);
          }
        }
      } else {
        Text("noData");
        statusRequest = StatusRequest.failuer;
      }
    }
    update();
  }

  InvoiceOne(index) async {
    dataInvoiceOne.clear();
    statusRequest = StatusRequest.loading;
    update();

    dataInvoiceOne.add(dataInvoice[index]);
    getDataProfileSelectUser(dataInvoiceOne[0].invoiceUserId, false);
    var response = await dataInvoiceOne[0];
    statusRequest = handlingData(response);
    update();
  }

  InvoiceUpadte(invoice_id, product_id,product_quantity) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await storeRemoteData.updateInvoiceAccept(
        myservices.sharedPref.getInt("users_id").toString()!,
        invoice_id,
        product_id,
        product_quantity,
    );
    print("$response *****");
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        dataInvoice.clear();
        getDataAllUsersInvoice();
        Get.offNamed("/InvoiceAllAdmin");
      } else {
        statusRequest = StatusRequest.failuer;
      }
    }
    update();
  }

  @override
  getDataProfileSelectUser(SelectUserx, withAnalys) async {
    dataSelectUser.clear();
    //loading
    statusRequest = StatusRequest.loading;
    update();

    SelectUser = TextEditingController(text: SelectUserx.toString());

    var response =
        await admincoachRemoteData.getDataProfileSelectUser(SelectUser.text);
    print("$response *****00000");
    print("${SelectUser.text} *****0000001");
    print("${SelectUserx} *****0000002");
    if (response == StatusRequest.serverfailuer) {
      getDataAllusers();
      Get.defaultDialog(
        title: "errortitleresendcode".tr,
        middleText: "tryagain".tr,
      );
    }
    //
    else {
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          if (dataSelectUser == null) {
            Get.defaultDialog(
              title: "Loading".tr,
              middleText: "Please Waiting",
              content: CircularProgressIndicator(
                color: ColorApp.darkRed,
              ),
              onCancel: () {},
            );
          } else {
            profileModelSelectUser = ProfileModel.fromJson(response["data"]);
            dataSelectUser.add(profileModelSelectUser!);
            withAnalys == true ? getAWH(SelectUser.text) : null;
          }
        } else {
          getDataAllusers();
          Get.defaultDialog(
            title: "errortitleresendcode".tr,
            middleText: "noUser".tr,
          );
        }
      }
    }

    update();
  }

  ApproveSubUpadte(sub_userId, sub_id, sub_type) async {
    Get.defaultDialog(
        title: "AlertPay".tr,
        content: Center(
          child: Text(
            "bodyAlertpay".tr,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: "Exo",
              fontSize: 13,
              color: ColorApp.lightBlack,
              height: 1.5,
            ),
          ),
        ),
        actions: [
          ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(ColorApp.darkRed),
              ),
              onPressed: () async {
                datasubunPaid.clear();
                statusRequest = StatusRequest.loading;
                update();
                var response = await admincoachRemoteData.ApproveSub(
                  sub_userId.toString()!,
                  sub_id,
                  sub_type.toString(),
                );
                print("$response *****");
                statusRequest = handlingData(response);

                if (StatusRequest.success == statusRequest) {
                  if (response['status'] == "success") {
                    getAllSubunpaid();
                    Get.back();
                    // Get.offNamed("/InvoiceAllAdmin");
                  } else {
                    statusRequest = StatusRequest.failuer;
                  }
                }
              },
              child: Text(
                "btnConfirmpay".tr,
                style: TextStyle(fontSize: 12),
              )),
          SizedBox(
            width: 30,
          ),
          ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(ColorApp.lightBlack),
              ),
              onPressed: () async {
                Get.back();
              },
              child: Text(
                "btnCancelpay".tr,
                style: TextStyle(fontSize: 12),
              )),
        ]);
    update();
  }

  getAllSubunpaid() async {
    dataAllsubunPaid.clear();
    statusRequest = StatusRequest.loading;
    update();
    var response = await admincoachRemoteData.AllSubunpaid();
    print("$response *****");
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List<dynamic> responseData = response['data'];

        for (var userData in responseData) {
          subscriptionModelunPaid = SubscriptionUserModel.fromJson(userData);
          dataAllsubunPaid.add(subscriptionModelunPaid!);
        }

        // Get.offNamed("/InvoiceAllAdmin");
      } else {
        statusRequest = StatusRequest.failuer;
      }
    }
    update();
  }

  getAllUsersAskBeCoach() async {
    dataAllAskBeCoach.clear();
    statusRequest = StatusRequest.loading;
    update();
    var response = await admincoachRemoteData.UserAskBeCoach();
    print("$response *****");
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List<dynamic> responseData = response['data'];

        for (var userData in responseData) {
          profileModelAllTraineesr = ProfileModel.fromJson(userData);
          dataAllAskBeCoach.add(profileModelAllTraineesr!);
        }

        // Get.offNamed("/InvoiceAllAdmin");
      } else {
        statusRequest = StatusRequest.failuer;
      }
    }
    update();
  }

  getAllCoach() async {
    dataCoach.clear();
    statusRequest = StatusRequest.loading;
    update();
    var response = await admincoachRemoteData.Allcoaches();
    print("$response *****");
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List<dynamic> responseData = response['data'];

        for (var userData in responseData) {
          coachModel = CoachModel.fromJson(userData);
          dataCoach.add(coachModel!);
        }

        // Get.offNamed("/InvoiceAllAdmin");
      } else {
        statusRequest = StatusRequest.failuer;
      }
    }
    update();
  }

  deleteCoach(coachId,userId) async {
    Get.defaultDialog(
      title: "Alert".tr,
      middleText: "Areyousurefromdelete".tr,
      titleStyle: TextStyle(fontSize: 22),
      actions: [
        ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(ColorApp.darkRed),
            ),
            onPressed: () async {
              Get.back();
              statusRequest = StatusRequest.loading;
              update();

              var response = await admincoachRemoteData.deletecoach(
                coachId.toString()!,
                userId.toString()!,
              );
              print("$response *****");
              statusRequest = handlingData(response);

              if (StatusRequest.success == statusRequest) {
                if (response['status'] == "success") {
                  getAllCoach();
                }
              }
            },
            child: Text(
              "btnConfirm".tr,
              style: TextStyle(fontSize: 12),
            )),
        SizedBox(
          width: 30,
        ),
        ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(ColorApp.lightRed),
            ),
            onPressed: () {
              Get.back();
            },
            child: Text(
              "btnCancel".tr,
              style: TextStyle(fontSize: 12),
            )),
      ],
    );

    update();
  }

  approveCoach(
      user_id ,
      user_name ,
  user_phone ,
  user_email ,
  user_password ,
  user_image ,
      ) async {
    Get.defaultDialog(
      title: "Alert".tr,
      middleText: "youaproveusertoCoach".tr,
      titleStyle: TextStyle(fontSize: 22),
      actions: [
        ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
              MaterialStateProperty.all<Color>(ColorApp.darkRed),
            ),
            onPressed: () async {
              Get.back();
              statusRequest = StatusRequest.loading;
              update();

              var response = await admincoachRemoteData.approveToBeCoach(

                    user_id.toString(),
                user_name.toString(),
                user_phone.toString(),
                user_email.toString(),
                user_password.toString(),
                user_image.toString(),
                5.toString(),
              );
              print("$response *****");
              statusRequest = handlingData(response);

              if (StatusRequest.success == statusRequest) {
                if (response['status'] == "success") {
                  getAllUsersAskBeCoach();   getAllCoach();

                }
              }
            },
            child: Text(
              "btnConfirm".tr,
              style: TextStyle(fontSize: 12),
            )),
        SizedBox(
          width: 30,
        ),
        ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
              MaterialStateProperty.all<Color>(ColorApp.lightBlack),
            ),
            onPressed: () {
              Get.back();
            },
            child: Text(
              "btnCancel".tr,
              style: TextStyle(fontSize: 12),
            )),
      ],
    );
    getAllUsersAskBeCoach();    update();
  }



  deleteToBeCoach(
      user_id ,

      ) async {
    Get.defaultDialog(
      title: "Alert".tr,
      middleText: "youdeleteusertoCoach".tr,
      titleStyle: TextStyle(fontSize: 22),
      actions: [
        ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
              MaterialStateProperty.all<Color>(ColorApp.darkRed),
            ),
            onPressed: () async {
              Get.back();
              statusRequest = StatusRequest.loading;
              update();

              var response = await admincoachRemoteData.deleteToBeCoach(

                user_id.toString(),

              );
              print("$response *****");
              statusRequest = handlingData(response);

              if (StatusRequest.success == statusRequest) {
                if (response['status'] == "success") {
                  getAllUsersAskBeCoach();   getAllCoach();

                }
              }
            },
            child: Text(
              "btnConfirm".tr,
              style: TextStyle(fontSize: 12),
            )),
        SizedBox(
          width: 30,
        ),
        ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
              MaterialStateProperty.all<Color>(ColorApp.lightBlack),
            ),
            onPressed: () {
              Get.back();
            },
            child: Text(
              "btnCancel".tr,
              style: TextStyle(fontSize: 12),
            )),
      ],
    );
    getAllUsersAskBeCoach();    update();
  }


  getAllReports() async {
    dataReport.clear();
    statusRequest = StatusRequest.loading;
    update();
    var response = await admincoachRemoteData.AllRatingReport();
    print("$response *****");
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List<dynamic> responseData = response['data'];

        for (var userData in responseData) {
          reportModel = ReportModel.fromJson(userData);
          dataReport.add(reportModel!);
        }

        // Get.offNamed("/InvoiceAllAdmin");
      } else {
        statusRequest = StatusRequest.failuer;
      }
    }
    update();
  }
  cancelReport(ratingReport_id) async {
    Get.defaultDialog(
      title: "Alert".tr,
      middleText: "Ignorereport".tr,
      titleStyle: TextStyle(fontSize: 22),
      actions: [
        ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
              MaterialStateProperty.all<Color>(ColorApp.darkRed),
            ),
            onPressed: () async {
              Get.back();
              statusRequest = StatusRequest.loading;
              update();

              var response = await admincoachRemoteData.CancelReport(
                ratingReport_id.toString()!,

              );
              print("$response *****");
              statusRequest = handlingData(response);

              if (StatusRequest.success == statusRequest) {
                if (response['status'] == "success") {
                  getAllReports();
                }
              }
            },
            child: Text(
              "btnConfirm".tr,
              style: TextStyle(fontSize: 12),
            )),
        SizedBox(
          width: 30,
        ),
        ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
              MaterialStateProperty.all<Color>(ColorApp.lightRed),
            ),
            onPressed: () {
              Get.back();
            },
            child: Text(
              "btnCancel".tr,
              style: TextStyle(fontSize: 12),
            )),
      ],
    );
    getAllReports();

    update();
  }



  deletPostAndReport(
  fromusers_id,
   social_id,
   ratingReport_id
      ) async {
    Get.defaultDialog(
      title: "Alert".tr,
      middleText: "Areyousurefromdelete".tr,
      titleStyle: TextStyle(fontSize: 22),
      actions: [
        ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
              MaterialStateProperty.all<Color>(ColorApp.darkRed),
            ),
            onPressed: () async {
              Get.back();
              statusRequest = StatusRequest.loading;
              update();

              var response = await admincoachRemoteData.DeletPostAndReport(
                fromusers_id.toString()!,
                social_id.toString()!,
                ratingReport_id.toString()!,

              );
              print("$response *****");
              statusRequest = handlingData(response);

              if (StatusRequest.success == statusRequest) {
                if (response['status'] == "success") {
                  getAllReports();
                }
              }
            },
            child: Text(
              "btnConfirm".tr,
              style: TextStyle(fontSize: 12),
            )),
        SizedBox(
          width: 30,
        ),
        ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
              MaterialStateProperty.all<Color>(ColorApp.lightRed),
            ),
            onPressed: () {
              Get.back();
            },
            child: Text(
              "btnCancel".tr,
              style: TextStyle(fontSize: 12),
            )),
      ],
    );
    getAllReports();
    update();
  }



  changelevelSelectUser() async {
    Get.defaultDialog(
        title: "changeLevel".tr,
        content: Center(
          child: Text(
            "AlertchangeLevelBody".tr,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: "Exo",
              fontSize: 13,
              color: ColorApp.lightBlack,
              height: 1.5,
            ),
          ),
        ),
        actions: [
          ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(ColorApp.darkRed),
              ),
              onPressed: () async {
                if (dataSelectUser[0].usersLevel == 4) {
                  Get.defaultDialog(
                    title: "Alert".tr,
                    content: Center(
                      child: Text(
                        "AlertLevelBodyUp".tr,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: "Exo",
                          fontSize: 13,
                          color: ColorApp.lightBlack,
                          height: 1.5,
                        ),
                      ),
                    ),
                  );
                } else {
                  statusRequest = StatusRequest.loading;
                  update();

                  var response =
                      await admincoachRemoteData.changelevelSelectUser(
                          "${dataSelectUser[0].usersId}",
                          "${dataSelectUser[0].usersLevel! + 1}");

                  print("$response *****");
                  //
                  statusRequest = handlingData(response);
                  if (StatusRequest.success == statusRequest) {
                    if (response['status'] == "success") {
                      getDataProfileSelectUser(SelectUser.text, true);
                    } else {
                      statusRequest = StatusRequest.failuer;
                    }
                  }
                  Get.back();
                }
              },
              child: Text(
                "Levelup".tr,
                style: TextStyle(fontSize: 12),
              )),
          SizedBox(
            width: 30,
          ),
          ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(ColorApp.lightBlack),
              ),
              onPressed: () async {
                if (dataSelectUser[0].usersLevel == 1) {
                  Get.defaultDialog(
                    title: "Alert".tr,
                    content: Center(
                      child: Text(
                        "AlertLevelBodyDown".tr,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: "Exo",
                          fontSize: 13,
                          color: ColorApp.lightBlack,
                          height: 1.5,
                        ),
                      ),
                    ),
                  );
                } else {
                  statusRequest = StatusRequest.loading;
                  update();

                  var response =
                      await admincoachRemoteData.changelevelSelectUser(
                          "${dataSelectUser[0].usersId}",
                          "${dataSelectUser[0].usersLevel! - 1}");

                  print("$response *****");
                  //
                  statusRequest = handlingData(response);
                  if (StatusRequest.success == statusRequest) {
                    if (response['status'] == "success") {
                      getDataProfileSelectUser(SelectUser.text, true);
                    } else {
                      statusRequest = StatusRequest.failuer;
                    }
                  }
                  Get.back();
                }
              },
              child: Text(
                "Leveldown".tr,
                style: TextStyle(fontSize: 12),
              )),
        ]);

    update();
  }




/////////////////////////////////////////store
  getAllProduct() async {
    dataReport.clear();
    statusRequest = StatusRequest.loading;
    update();
    var response = await admincoachRemoteData.AllRatingReport();
    print("$response *****");
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List<dynamic> responseData = response['data'];

        for (var userData in responseData) {
          reportModel = ReportModel.fromJson(userData);
          dataReport.add(reportModel!);
        }

        // Get.offNamed("/InvoiceAllAdmin");
      } else {
        statusRequest = StatusRequest.failuer;
      }
    }
    update();
  }

  final ListTitleTM = [
    "Alltrainees".tr,
    "Expiredsubscriptions".tr,
    "Unpaidsubscription".tr,
    "Storeinvoices".tr,
  ];
  final ListIconTM = [
    "assets/images/all.png",
    "assets/images/expired.png",
    "assets/images/Unpaid.png",
    "assets/images/invoice.png",
  ];
  String formatSocialRate(int rate) {
    if (rate >= 1000) {
      return '${(rate / 1000).toStringAsFixed(1)}k';
    }
    return rate.toString();
  }
  /////analytics
  List<int> month = [];
  List<int> height = [];
  List<int> weight = [];
  AnalyticsRemoteData analyticsRemoteData = AnalyticsRemoteData(Get.find());

  getAWH(user) async {
    statusRequest = StatusRequest.loading;
    month.clear();
    height.clear();
    weight.clear();
    update();
    var response = await analyticsRemoteData.getAnalyticsWH(user.toString()!);

    print("$response *****");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List<dynamic> data = response['data'];
        data.forEach((item) {
          int numMonth = item['spotsWH_numMonth'];
          int heightValue = item['spotsWH_height'];
          int weightValue = item['spotsWH_weight'];

          month.add(numMonth);
          height.add(heightValue);
          weight.add(weightValue);
        });

        print(month);
        print(height);
        print(weight);
      }
    } else {
      statusRequest = StatusRequest.failuer;
    }

    update();
  }

  @override
  void onInit() {
    print("getAllSubunpaid5555555555555555555555");
    getAllSubunpaid();
    print("getAllSubunpaid5555555555555555555555");

    SelectUser = TextEditingController(text: "");
    getDataAllusers();
    getDataExpSub();
    getDataAllUsersInvoice();

    getAllUsersAskBeCoach();
    getAllCoach();
    getAllReports();
    notificationBody = TextEditingController();

    super.onInit();
  }
}
