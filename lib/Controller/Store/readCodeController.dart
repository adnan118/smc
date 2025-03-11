import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_code_dart_scan/qr_code_dart_scan.dart';
import '../../Core/Services/services.dart';
import '../../DB/statusRequest.dart';

class ReadCodeController extends GetxController {
  var results = <String>[]; // تعريف الـ Set
  List data = [];
  bool isThereInvoice = false;
  late StatusRequest statusRequest;

  Myservices myservices = Get.find();

  Future<void> scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#A2141A',
        'Cancel',
        false,
        ScanMode.QR,
      );
      results.clear();
      var after = qrCode.split("\n");
      results.addAll(after);

      printResults();
      if (results.length != 13) {
        isThereInvoice = false;
      } else {
        isThereInvoice = true;
      }
      update();
    } on PlatformException {
      results.add('Failed to scan QR Code.');
    }
  }

  void printResults() {
    print("QRCode_Result:--");
    for (int i = 0; i < results.length; i++) {
      print("$i: ${results[i]}");
    }
  }

  Future<void> scanBarcodeFromGallery() async {
    String qrCode = 'Unknown';
    final ImagePicker picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      final decoder = QRCodeDartScanDecoder(
        formats: [
          BarcodeFormat.QR_CODE,
        ],
      );

      Result? qrCode = await decoder.decodeFile(XFile(pickedImage.path));

      if (qrCode != null) {
        results.clear();
        var after = qrCode!.toString().split("\n");
        results.addAll(after);
        printResults();
        update();
        if (results.length != 13) {

          isThereInvoice = false;
          results.addAll(
              ["1", "2", " 3 ", " 4 ", "5", "6", "7", "8","9","10","11","12"]);
        } else {

          isThereInvoice = true;
        }
      } else {

        results.addAll(
            ["1", "2", " 3 ", " 4 ", "5", "6", "7", "8","9","10","11","12"]);
      }

      update();
    } else {
      results.add('No image selected');
    }
  }

  void clearIsThereInvoice() {
    results.clear();
    isThereInvoice = false;
    update();
  }


  @override
  void onInit() {
    results = <String>[]; // Reset results list

    super.onInit();
  }
}
