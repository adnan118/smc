import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smc/Data/Model/invoiceModel.dart';
import '../../Classes/HandlingDataController.dart';
import '../../Core/Constant/color.dart';
import '../../Core/Localization/translateDB.dart';
import '../../Core/Services/services.dart';
import '../../DB/statusRequest.dart';
import '../../Data/DataSource/Remote/SocialRemoteData.dart';
import '../../Data/DataSource/Remote/storeRemoteData.dart';
import '../../Data/Model/categoryModel.dart';
import '../../Data/Model/modeModel.dart';
import '../../Data/Model/productModel.dart';
import '../../Data/Model/socialModel.dart';
import '../../Data/Model/storeModel.dart';
import '../Home/profileController.dart';

class StoreController extends GetxController  {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  StoreRemoteData storeRemoteData = StoreRemoteData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  Myservices myservices = Get.find();




  CategoryModel? categoryModel;
  ProductModel? productModel;
  StoreModel? storeModel;
  List<StoreModel> dataStore = [];
  List<StoreModel> dataStoreView = [];
  List<CategoryModel> dataCategories = [];

  int selectedProductID = 0;
  int selectedProductActive = 0;
  int selectedProductQUNTY = 0;
  int selectedProductPRICE = 0;
  int selectedProductDISCOUNT= 0;
  String selectedProductIMG = "";
  String selectedProductINAME = "";
  String selectedProductINAMEar = "";
  int selectedProductCat = 0;


  //////////////
  late TextEditingController ProName = TextEditingController();
  late TextEditingController ProNameAr = TextEditingController();
  late TextEditingController ProQua = TextEditingController();
  late TextEditingController ProPrice = TextEditingController();
  late TextEditingController ProDiscount = TextEditingController();
  late TextEditingController ProAvailable = TextEditingController();
  ///////////////////
  late TextEditingController ProNameAdd = TextEditingController();
  late TextEditingController ProNameArAdd = TextEditingController();
  late TextEditingController ProQuaAdd = TextEditingController();
  late TextEditingController ProPriceAdd = TextEditingController();
  late TextEditingController ProDiscountAdd = TextEditingController();
  late TextEditingController ProAvailableAdd = TextEditingController();
  late TextEditingController ProCategoryAdd = TextEditingController();
  String addProductIMG = "product.png";

  var pice = 0;

  var price = 0;

  var ship = 0; //"BOPIS" يعني "Buy Online, Pick Up In Store"
  double total = 0;

  String wayShip = "BOPIS";

  Color wayShipColor = Colors.transparent;



  getTotal(pice, price, ship, discount) {
    return total = (pice * price + ship * pice) -
        ((pice * price + ship * pice) * (discount / 100));
  }

  Store(categories_id ) async {
    dataStore.clear();
    statusRequest = StatusRequest.loading;
    var response = await storeRemoteData.getStore(categories_id);
    //print("$response *****");
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        var dataList = response["data"] as List;
        dataStore = dataList.map((item) => StoreModel.fromJson(item)).toList();
      } else {
        statusRequest = StatusRequest.failuer;
      }
    }
    update();
  }

  StoreAll( ) async {
    dataStore.clear();
    statusRequest = StatusRequest.loading;
    var response = await storeRemoteData.getStoreAll();
    print("$response *****");
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        var dataList = response["data"] as List;
        dataStore = dataList.map((item) => StoreModel.fromJson(item)).toList();
      } else {
        statusRequest = StatusRequest.failuer;
      }
    }
    update();
  }
  getCategories() async {
    dataCategories.clear();
    statusRequest = StatusRequest.loading;
    var response = await storeRemoteData.getAllCategory();
    print("$response *****");
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        var dataList = response["data"] as List;
        dataCategories =
            dataList.map((item) => CategoryModel.fromJson(item)).toList();
      } else {
        statusRequest = StatusRequest.failuer;
      }
    }
    update();
  }

  convertCategory(selectCat) {
    var category = dataCategories.firstWhere((cat) => cat.categoriesId == selectCat);
    return translateDB(
      category.categoriesNameAr,
      category.categoriesName,
    );
  }





  insertInvoice() async {
     statusRequest = StatusRequest.loading;
    update();

    var response = await storeRemoteData.insertInvoic(
        myservices.sharedPref.getInt("users_id").toString()!,
        selectedProductID,
        selectedProductINAME,
        pice,
        selectedProductPRICE,
        selectedProductDISCOUNT,
        ship,
        total,
        wayShip,
        selectedProductIMG
    );
    print("$response *****");

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        Get.defaultDialog(
          title: "Success",
          content: Text("your order is Pending...",
            style:  TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: "Exo",
              fontSize: 12,
              color: ColorApp.lightBlack,
              height: 1.5,
            ),),
          confirm: NeumorphicButton(
            style: NeumorphicStyle(depth: 1),
            child: Text("View Invoice",
              style:  TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: "Exo",
                fontSize: 13,
                color: ColorApp.darkRed,
                height: 1.5,
              ),),
            onPressed: (){

              Get.toNamed("/InvoiceAll");
            },
          ),


        );
        update();
      } else {
        statusRequest = StatusRequest.failuer;
      }
    }

    update();
  }

  int CurrentPageCategories = 1;
  changCategories(int pageCat) {
    CurrentPageCategories = pageCat;
    CurrentPageCategories ==0?  StoreAll():  Store(pageCat);
    update();
  }

  goToInvoiceAll(){
    Get.toNamed("/InvoiceAll");
  }




  //////admin

  GlobalKey<FormState> myKeyEpAdmin = GlobalKey<FormState>();

  XFile? xfile;
  File? myfile;
  chooesImg() async {
    update();
    // Pick an image from the gallery
    xfile = await ImagePicker().pickImage(source: ImageSource.gallery);

    // Check if xfile is null before proceeding
    if (xfile != null) {
      myfile = File(xfile!.path); // No need for null check here since xfile is not null
      print(myfile);
      update();
    } else {
      print("No image selected."); // Handle the case where no image was selected
    }

    update();
  }


  @override
  updateProAdmin() async {
    var formdata = myKeyEpAdmin.currentState;

    if (formdata!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response;
      if (myfile == null) {
        var response = await storeRemoteData.StoreUpdate(
            selectedProductID.toString(),
            ProName.text,
            ProNameAr.text,
            ProQua.text,
            ProPrice.text,
            ProDiscount.text,
            selectedProductCat.toString(),
            ProAvailable.text,
            selectedProductIMG.toString()
        );

        print("$response ****uuuuu*");
        statusRequest = StatusRequest.none;
        // Check response type and handle accordingly
        if (response is Map) {
          statusRequest = handlingData(response);
        } else {
          statusRequest = StatusRequest.failuer;
        }
        update();
      } else {
        response = await storeRemoteData.StoreUpdateWithFile(
          selectedProductID.toString(),
          ProName.text,
          ProNameAr.text,
          ProQua.text,
          ProPrice.text,
          ProDiscount.text,
          selectedProductCat.toString(),
          ProAvailable.text,
          selectedProductIMG.toString(),

          myfile,
        );
        // Check response type and handle accordingly
        if (response is Map) {
          statusRequest = handlingData(response);
        } else {
          statusRequest = StatusRequest.failuer;
        }
        update();
        print("$response ***vvv**");
      }



      xfile = null;
      StoreView();
      update();
    }
  }


  @override
  addProAdmin() async {
    var formdata = myKeyEpAdmin.currentState;

    if (formdata!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response;
      if (myfile == null) {
        var response = await storeRemoteData.StoreAdd(

            ProNameAdd.text,
            ProNameArAdd.text,
            ProQuaAdd.text,
            ProPriceAdd.text,
            ProDiscountAdd.text,
          ProCategoryAdd.text,
            ProAvailableAdd.text,
            addProductIMG.toString(),
        );

        print("$response ****uuuuu*");
        statusRequest = StatusRequest.none;
        update();
      } else {
        response = await storeRemoteData.StoreAddWithFile(
          ProNameAdd.text,
          ProNameArAdd.text,
          ProQuaAdd.text,
          ProPriceAdd.text,
          ProDiscountAdd.text,
          ProCategoryAdd.text,
          ProAvailableAdd.text,
          addProductIMG.toString(),

          myfile,
        );
        update();
        print("$response ***vvv**");
      }


      // Check response type and handle accordingly
      if (response is Map) {
        statusRequest = handlingData(response);
      } else {
        statusRequest = StatusRequest.failuer;
      }
      xfile = null;
      StoreView();
      update();
    }
  }



  StoreDelete(product_id) async {
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
              Get.back();    dataStoreView.clear();

              statusRequest = StatusRequest.loading;
              update();

              var response = await storeRemoteData.StoreDelete(product_id);

              print("$response *****");
              StoreView( );
              Get.offAllNamed("/StoreManage");
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
      ],   );

    update();
  }





  StoreView( ) async {
    dataStoreView.clear();
    statusRequest = StatusRequest.loading;
    var response = await storeRemoteData.StoreView();
    print("$response *****");
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        var dataList = response["data"] as List;
        dataStoreView = dataList.map((item) => StoreModel.fromJson(item)).toList();
      } else {
        statusRequest = StatusRequest.failuer;
      }
    }
    update();
  }
  @override
  void onInit() async {
    TextEditingController ProAvailableAdd = TextEditingController(text: "0");
    await getCategories();
    await StoreAll();
    await  StoreView();
    super.onInit();
  }
}
