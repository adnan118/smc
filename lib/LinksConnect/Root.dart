import 'package:get/get.dart';

import '../Auth/Screen/fpPages/ForgetPassword.dart';
import '../Auth/Screen/fpPages/GetVerflyCodeFP.dart';
import '../Auth/Screen/fpPages/ResetPassword.dart';
import '../Auth/Screen/fpPages/SuccsessReset.dart';
import '../Auth/Screen/getVerflyCodeSignUp.dart';
import '../Auth/Screen/login.dart';
import '../Auth/Screen/signUp.dart';
import '../Auth/Screen/succsessSignUp.dart';
import '../Core/Localization/languageItems/language.dart';
import '../Core/MiddleWare/mymiddleware.dart';
import '../Screen/AdminTools/allInvoice.dart';
import '../Screen/AdminTools/mainToolAdmin.dart';
import '../Screen/AdminTools/storeManage.dart';
import '../Screen/Analytics/analytics.dart';
import '../Screen/B_DayOfLevel/b_dayOfLevel.dart';
import '../Screen/B_DayOfLevel/b_dayOffOfLevel.dart';
import '../Screen/B_DayOfLevel/levels.dart';
import '../Screen/Basic/basicScreen.dart';
import '../Screen/Basic/social.dart';
import '../Screen/Basic/sports.dart';
import '../Screen/CoachTools/CoachTools.dart';
import '../Screen/Notifications/notifications.dart';
import '../Screen/OnBoarding/onboarding.dart';
import '../Screen/Profile/drawerXProfile.dart';
import '../Screen/Profile/drawerXProfileEdit.dart';
import '../Screen/Store/invoiceAll.dart';
import '../Screen/Store/store.dart';
import '../Screen/Subscription/Subscription.dart';
import '../Screen/aboutUs/aboutUs.dart';
import '../Screen/rootPage.dart';
import '../Widget/Store/ReadQr.dart';

List<GetPage<dynamic>>? routes = [

  GetPage(name: "/", page: ()=> Language(),

   middlewares: [  Mymiddleware() ]
  ),

  GetPage(name: "/", page: () => (Language())),
  GetPage(name: "/Language", page: () => Language()),
  GetPage(name: "/OnBoarding", page: () => OnBoarding()),
  GetPage(name: "/BasicScreen", page: () => BasicScreen()),
  GetPage(
      name: "/ViewAndRenewsubscription",
      page: () => Subscription()),
  GetPage(name: "/B_dayOfLevel", page: () => B_dayOfLevel()),
  GetPage(name: "/B_dayOffOfLevel", page: () => B_dayOffOfLevel()),
  GetPage(name: "/Levels", page: () => Levels()),
  GetPage(name: "/Analytics", page: () => Analytics()),
  GetPage(name: "/Store", page: () => Store()),
  GetPage(name: "/Sports", page: () => Sports()),
  GetPage(name: "/Social", page: () => Social()),
  GetPage(name: "/RootPage", page: () => RootPage()),

  //Auth

  GetPage(name: "/Login", page: () => Login()),
  GetPage(name: "/SignUp", page: () => SignUp()),
  GetPage(name: "/GetVerflyCodeSignUp", page: () => GetVerflyCodeSignUp()),
  GetPage(name: "/SuccsessSignUp", page: () => SuccsessSignUp()),
  GetPage(name: "/Language", page: () => Language()),

  //profile
  GetPage(name: "/DrawerXProfileEdit", page: () => DrawerXProfileEdit()),
  GetPage(name: "/DrawerXProfile", page: () => DrawerXProfile()),
  GetPage(name: "/AboutUs", page: () => AboutUs()),
  //FP
  GetPage(name: "/GetVerflyCodeFP", page: () => GetVerflyCodeFP()),
  GetPage(name: "/ForgetPassword", page: () => ForgetPassword()),
  GetPage(name: "/SuccsessReset", page: () => SuccsessReset()),
  GetPage(name: "/ResetPassword", page: () => ResetPassword()),
  //Store
  GetPage(name: "/Store", page: () => Store()),
  GetPage(name: "/InvoiceAll", page: () => InvoiceAll()),
  GetPage(name: "/ReadCodeInvoice", page: () => ReadCodeInvoice()),
  GetPage(name: "/Notifications", page: () => Notifications()),

  //CoachTools
  GetPage(name: "/CoachTools", page: () => CoachTools()),
  //admin tools
  GetPage(name: "/MainToolAdmin", page: () => MainToolAdmin()),
  GetPage(name: "/InvoiceAllAdmin", page: () => InvoiceAllAdmin()),
  GetPage(name: "/StoreManage", page: () => StoreManage()),

];
