
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Classes/HandlingDataController.dart';
import '../../Core/Constant/color.dart';
import '../../Core/Services/services.dart';
import '../../DB/statusRequest.dart';
import '../../Data/DataSource/Remote/subscriptionRemoteData.dart';
import '../../Data/Model/CoachModel.dart';
import '../../Data/Model/CoursesModel.dart';
import '../../Data/Model/ServicesModel.dart';
import '../../Data/Model/SubscriptionModel.dart';
import '../../Data/Model/TypeSubscriptionModel.dart';
import 'package:intl/intl.dart';

class SubscriptionController extends GetxController {
  SubscriptionRemoteData subscriptionRemoteData =
      SubscriptionRemoteData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  Myservices myservices = Get.find();

  CoachModel? coachModel;
  CoursesModel? coursesModel;
  ServicesModel? servicesModel;
  SubscriptionModel? subscriptionModel;
  TypeSubscriptionModel? typeSubscriptionModel;

  List<CoachModel> dataCoach = [];
  List<CoursesModel> dataCourses = [];
  List<ServicesModel> dataServices = [];
  List<SubscriptionModel> dataSubscription = [];
  List<TypeSubscriptionModel> dataTypeSubscription = [];

  int TypeSub = 0; // القيمة الافتراضية فارغة في البداية
  int Services = 2;
  int Couch = 0;
  int Courses = 0;

  int differenceInDays = 1;
  int daysInMonth = 1;

  rf() {
    update();
  }

  daysSub() {
// تاريخ اليوم
    DateTime today = DateTime.now();

// تاريخ من الاستجابة
    String? subEndDate = dataSubscription[0].subEndDate; // 2024-06-06 11:37:33
    DateTime parsedResponseDate =
        DateFormat("yyyy-MM-dd HH:mm:ss").parse(subEndDate!);

    Duration difference = parsedResponseDate.difference(today);
    differenceInDays =
        difference.inSeconds ~/ 86400; // تحويل الفارق الزمني إلى عدد الأيام

    daysInMonth = DateTime(today.year, today.month + 1, 0).day;

    print(daysInMonth);
    print(differenceInDays);
    return differenceInDays =
        differenceInDays < 0 ? differenceInDays = 0 : differenceInDays+1;
  }

  getCourses() async {
    dataCourses.clear();
    statusRequest = StatusRequest.loading;
    var response = await subscriptionRemoteData.getSubCourses();
    print("$response *****");
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        var dataList = response["data"] as List;
        dataCourses =
            dataList.map((item) => CoursesModel.fromJson(item)).toList();

        if (dataCourses.isNotEmpty) {
          Courses = dataCourses.first.coursesId!;
        }
      } else {
        statusRequest = StatusRequest.failuer;
      }
    }

    update();
  }

  getTypeSubscription() async {
    dataTypeSubscription.clear();
    statusRequest = StatusRequest.loading;
    var response = await subscriptionRemoteData.getSubTypeSub();
    print("$response *****");
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        var dataList = response["data"] as List;
        dataTypeSubscription = dataList
            .map((item) => TypeSubscriptionModel.fromJson(item))
            .toList();

        if (dataTypeSubscription.isNotEmpty) {
          TypeSub = dataTypeSubscription.first.typeSubId!;
        }
      } else {
        statusRequest = StatusRequest.failuer;
      }
    }

    update();
  }

  getCoach() async {
    dataCoach.clear();
    statusRequest = StatusRequest.loading;
    var response = await subscriptionRemoteData.getSubCoach();
    print("$response *****");
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        var dataList = response["data"] as List;
        dataCoach = dataList.map((item) => CoachModel.fromJson(item)).toList();

        if (dataCoach.isNotEmpty) {
          Couch = dataCoach.first.coachId!;
        }
      } else {
        statusRequest = StatusRequest.failuer;
      }
    }

    update();
  }

  getServices() async {
    dataServices.clear();
    statusRequest = StatusRequest.loading;
    var response = await subscriptionRemoteData.getSubServices();
    print("$response *****");
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        var dataList = response["data"] as List;
        dataServices =
            dataList.map((item) => ServicesModel.fromJson(item)).toList();

        if (dataServices.isNotEmpty) {
          Services = dataServices.first.servicesId!;
        }
      } else {
        statusRequest = StatusRequest.failuer;
      }
    }

    update();
  }

  getSubscription() async {
    dataSubscription.clear();
    statusRequest = StatusRequest.loading;
    var response = await subscriptionRemoteData.getSubscription(
      myservices.sharedPref.getInt("users_id").toString()!,
    );
    print("$response *****");
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        var dataList = response["data"] as List;
        dataSubscription =
            dataList.map((item) => SubscriptionModel.fromJson(item)).toList();
        daysSub();
      } else {
        statusRequest = StatusRequest.failuer;
      }
    }

    update();
  }

  @override
  inserNewSub() async {
    update();
    DateTime today = DateTime.now();
    DateTime endOfMonth = DateTime(today.year, today.month + 1, 0);
    int lastDayinMonth = endOfMonth.day;
    statusRequest = StatusRequest.loading;
    update();
    var response = await subscriptionRemoteData.setSubscription(
      myservices.sharedPref.getInt("users_id").toString()!,
      TypeSub.toString(),
      Courses.toString(),
      Couch.toString(),
      totalPrice.toString(),
      Services.toString(),
      today.toString(),
      today.toString(),
      0.toString(),
    );
    print("$response *****");
    //
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        await getSubscriptionActive();
        await getSubscription();
        await getTypeSubscription();
        await getCoach();
        await getServices();
        await getCourses();
        await daysSub();

        SubscriptionController subscriptionController =
            Get.put(SubscriptionController());
        Get.toNamed("/ViewAndRenewsubscription");
        Get.back();
        Get.back();

        update();
      } else {
        statusRequest = StatusRequest.failuer;
      }
    }

    update();
    print("Data valid");
  }

  convertServices(subservice) {
    return dataServices
        .firstWhere((service) => service.servicesId == subservice)
        .servicesName;
  }

  convertCouch(subcouch) {
    return dataCoach.firstWhere((couch) => couch.coachId == subcouch).coachName;
  }
  convertCouchPhone(subcouch) {
    return dataCoach.firstWhere((couch) => couch.coachId == subcouch).coachPhone;
  }
  convertCourses(subcourses) {
    return dataCourses
        .firstWhere((course) => course.coursesId == subcourses)
        .coursesName;
  }

  convertType(subType) {
    return dataTypeSubscription
        .firstWhere((dts) => dts.typeSubId == subType)
        .typeSubName;
  }

  var totalPrice = 0;

  //(dataCoach[Couch].couponCount)
  CaculetPrice() {
    totalPrice = (dataTypeSubscription[TypeSub - 1].typeSubPrice! -
            (dataTypeSubscription[TypeSub - 1].typeSubPrice! *
                (dataTypeSubscription[TypeSub - 1].typeSubDiscount! * 0.01)) +
            dataServices[Services - 1].servicesPrice! -
            (dataServices[Services - 1].servicesPrice! *
                (dataServices[Services - 1].servicesDecount! * 0.01)) +
            dataCourses[Courses - 1].coursesPrice! -
            (dataCourses[Courses - 1].coursesPrice! *
                (dataCourses[Courses - 1].coursesDiscount! * 0.01)))
        .toInt();
    print(totalPrice);
  }

  bool isActive = false;
  String page = "notActive";

  getSubscriptionActive() async {
    page = "notActive";
    statusRequest = StatusRequest.loading;
    var response = await subscriptionRemoteData.getSubscriptionActive(
      myservices.sharedPref.getInt("users_id").toString()!,
    );
    print("$response *****");        update();
    statusRequest = handlingData(response);
    update();
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        isActive = response['active'] == 1;
        int subCourse = response['sub_course'];

        if (isActive) {
          page = "Active";
          //       الاشتراك فعال

          print("Subscription is active"); update();
        } else {
          // ا  الاشتراك غير فعال
          page = "notActive";
          print("Subscription is not active"); update();
        }

        print("Sub course: $subCourse");
        update();
      } else {

        statusRequest = StatusRequest.failuer;
      }
      update();
    } else {
      page = "notActive";
      print("Failed to fetch subscription");
      update();
    }

    update(); // تحديث واجهة المستخدم بعد جلب البيانات
  }

  SubmitSubscription(context) {
    var typeSubPrice = dataTypeSubscription[TypeSub - 1].typeSubPrice! -
        (dataTypeSubscription[TypeSub - 1].typeSubPrice! *
            (dataTypeSubscription[TypeSub - 1].typeSubDiscount! * 0.01));

    var servicesPricex=  dataServices[Services - 1].servicesPrice! -
        (dataServices[Services - 1].servicesPrice! *
            (dataServices[Services - 1].servicesDecount! * 0.01)) ;


    var coursesPricex=dataCourses[Courses - 1].coursesPrice! -
        (dataCourses[Courses - 1].coursesPrice! *
            (dataCourses[Courses - 1].coursesDiscount! * 0.01)) ;



    if (totalPrice == 0 || TypeSub == 0 || Couch == 0 || Courses == 0) {
      Get.defaultDialog(
        title: "Alet".tr,
        middleText: "Check from your Selections".tr,
        titleStyle: Theme.of(context).textTheme.displaySmall,
        middleTextStyle: Theme.of(context).textTheme.displaySmall!.copyWith(
              color: ColorApp.lightBlack,
              fontSize: 11,
            ),
      );
    } else {
      Get.defaultDialog(
        title: "Confirm".tr,
        content: Text(
            "Courses  ${coursesPricex}\nTypeSub  ${typeSubPrice}\nCouch ${dataCoach[Couch-1].coachName}\nServices ${servicesPricex}\nTotal Price ${totalPrice}"),




        middleText: "Are you sure Confirm the Subscribe".tr,
        titleStyle: Theme.of(context).textTheme.displaySmall,
        middleTextStyle: Theme.of(context).textTheme.displaySmall!.copyWith(
              color: ColorApp.lightBlack,
              fontSize: 11,
            ),
        actions: [
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(ColorApp.darkRed),
            ),
            onPressed: () {
              CaculetPrice();
              update();
              inserNewSub();
              getSubscriptionActive();
              Get.back();
              Get.delete<SubscriptionController>();
              Get.put(SubscriptionController());

              Get.toNamed("/ViewAndRenewsubscription");
            },
            child: Text(
              "btnConfirm".tr,
              style: TextStyle(fontSize: 12),
            ),
          ),
          SizedBox(width: 30),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(ColorApp.middleRed),
            ),
            onPressed: () {
              Get.back();
            },
            child: Text(
              "btnCancel".tr,
              style: TextStyle(fontSize: 12),
            ),
          ),
        ],
      );
    }
    ;
  }
   @override
  void onInit() async {
       getSubscription();
    await getSubscriptionActive();

    await getTypeSubscription();
    await getCoach();
    await getServices();
    await getCourses();
    await daysSub();
    await CaculetPrice();
    super.onInit();
  }
}
