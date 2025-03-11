import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smc/Core/Constant/color.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Core/Services/services.dart';

class ConnectionData extends StatelessWidget {
  final String content;
  final String image;
  final int mail1Phone2Link3Sms4;
  const ConnectionData(
      {Key? key,
        required this.content,
        required this.image,
        required this.mail1Phone2Link3Sms4})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Myservices myservices = Get.find();
    return Column(
      children: [
        Row(

          children: [
            Expanded(
              child: ListTile(

                title: Text(textAlign:myservices.sharedPref.getString("myLang") == "ar"?TextAlign.end:TextAlign.start,
                  content,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorApp.lightBlack, fontSize: 12),overflow: TextOverflow.ellipsis,
                ),
                leading: Image.asset(
                  image,
                  height: 28,
                  width: 28,
                ),

                minLeadingWidth: 15,
                onTap: () async {
                  if (mail1Phone2Link3Sms4 == 1) {
                    await launchUrl(Uri.parse("mailto:$content"));
                  } else if (mail1Phone2Link3Sms4 == 2) {
                    await launchUrl(Uri.parse("tel:$content"));
                  } else if (mail1Phone2Link3Sms4 == 3) {
                    await launchUrl(Uri.parse("https:$content"));
                  } else if (mail1Phone2Link3Sms4 == 4) {
                    await launchUrl(Uri.parse("sms:$content"));
                  }
                },
              ),
            )
          ],
        ),
      ],
    );
  }
}
