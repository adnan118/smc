
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class GenerateQr extends StatelessWidget {
  final String value;
  final int h;
  final int w;

  const GenerateQr({Key? key, required this.value, required this.h, required this.w}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: h+0,
      width: w+1,
      child: SfBarcodeGenerator(
        value: value,
        symbology: QRCode(),
        showValue: false,
      ),
    );
  }
}
