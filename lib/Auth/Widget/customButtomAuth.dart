import 'package:flutter/material.dart';

import '../../Core/Constant/color.dart';

class CustomButtomAuth extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final Color colorBg;
  final Color colorText;
  final double elevation;
  const CustomButtomAuth({Key? key, required this.text, required this.onPressed, required this.colorBg, required this.colorText, required this.elevation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:5),
      child: MaterialButton(
          elevation: elevation,
          color: colorBg,
          textColor: colorText,
          padding: EdgeInsets.symmetric(horizontal: 70,vertical: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          onPressed:onPressed,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("$text",style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorApp.bacground),),

            ],)
      ),
    );
  }
}
