import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Binding/initBinding.dart';
import 'Core/Localization/changelocal.dart';
import 'Core/Localization/languageItems/translation.dart';
import 'Core/Services/services.dart';
import 'LinksConnect/Root.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    LocalController controller = Get.put(LocalController());
    Firebase.initializeApp();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SMC',
      locale: controller.Language,
      translations: MyTranslation(),
      theme: controller.themApp,
      initialBinding: InitBinding(),
      // home: InvoiceAll(),
  getPages: routes,
    );
  }
}
