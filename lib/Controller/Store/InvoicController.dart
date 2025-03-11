
import 'package:get/get.dart';
import 'package:smc/Data/Model/invoiceModel.dart';
import '../../Classes/HandlingDataController.dart';
import '../../Core/Services/services.dart';
import '../../DB/statusRequest.dart';
import '../../Data/DataSource/Remote/storeRemoteData.dart';
import '../Home/profileController.dart';

class InvoicController extends GetxController {
  StoreRemoteData storeRemoteData = StoreRemoteData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  Myservices myservices = Get.find();
  ViewProfileController viewProfileController = Get.find();
  InvoiceModel? invoiceModel;
  List<InvoiceModel> dataInvoice = [];
  List<InvoiceModel> dataInvoiceOne = [];
  List columnTable = [
    "invoiceID",
    "productID",
    "Name",
    "Quantity",
    "Price",
    "Discount",
    "Ship",
    "Total",
    "ShipCo",
    "Paid",
    "Date",
  ];
  double total = 0;

  getTotal(pice, price, ship, discount) {
    return total = (pice * price + ship * pice) -
        ((pice * price + ship * pice) * (discount / 100));
  }

  getTotalDiscount(pice, price, ship, discount) {
    var totalBeforeDiscount = pice * price + ship * pice;
    var totalDiscount = totalBeforeDiscount * (discount / 100);

    return totalDiscount;
  }

  InvoiceAll() async {
    dataInvoice.clear();
    statusRequest = StatusRequest.loading;
    update();
    var response = await storeRemoteData.getInvoiceAll(
      myservices.sharedPref.getInt("users_id").toString()!,
    );
    print("$response *****");
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        var dataList = response["data"] as List;
        dataInvoice =
            dataList.map((item) => InvoiceModel.fromJson(item)).toList();
      } else {
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
    var response = await dataInvoiceOne[0];
    statusRequest = handlingData(response);
    print(dataInvoiceOne[0].invoiceProductImg);
    update();
  }

  InvoiceUpadte(invoice_id, product_id,product_quantity) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await storeRemoteData.updateInvoiceAccept(
        myservices.sharedPref.getInt("users_id").toString()!,
        invoice_id,
        product_id,
        product_quantity
    );
    print("$response *****");
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        dataInvoice.clear();
        InvoiceAll();
        Get.offNamed("/InvoiceAll");
      } else {
        statusRequest = StatusRequest.failuer;
      }
    }
    update();
  }

  refAllInvoice(){
    InvoiceAll();
  }
  @override
  void onInit() async {
    await InvoiceAll();
    super.onInit();
  }
}
