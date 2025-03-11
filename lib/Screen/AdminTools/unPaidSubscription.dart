import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';

import '../../Classes/handlingStatusRemotDataView.dart';
import '../../Controller/AdminTools/AdminToolsController.dart';
import '../../Controller/Home/basicScreenController.dart';
import '../../Controller/Home/profileController.dart';
import '../../Core/Constant/color.dart';
import '../../Core/Constant/imageasset.dart';
import '../../Core/Localization/translateDB.dart';
import '../../Core/Services/services.dart';
import '../../Widget/Home/avatarImage.dart';
import '../../Widget/Home/connectionData.dart';

class UnpaidSubscription extends StatelessWidget {
    UnpaidSubscription({Key? key}) : super(key: key);
  Myservices myservices = Get.find();
  @override
  Widget build(BuildContext context) {
  

    return Scaffold(
        backgroundColor: ColorApp.bgMain,
        appBar: AppBar(
          title: Text(
            "Unpaidsubscription".tr,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        body: GetBuilder<AdminToolsController>(
            builder: (controller) => HandlingStatusRemotDataView(
              statusRequest: controller.statusRequest,
              widget: RefreshIndicator(
                color: ColorApp.bgMain,
                backgroundColor: ColorApp.darkRed,
                onRefresh: () async {
                  await Future.delayed(Duration(seconds: 2));
                  Get.put(ViewProfileController());
                  Get.offAllNamed("/RootPage");
                },
                child:
                controller.dataAllsubunPaid.isEmpty?Center(
                  child: Text(
                    "nounpaidsub".tr,
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(
                        color: ColorApp.lightBlack,
                        fontSize: 15),
                  ),
                ):
SingleChildScrollView(child:
              Column(
                children: [


                  ListView.builder(
                    padding: EdgeInsets.all(10),
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: controller.dataAllsubunPaid.length,

                    itemBuilder:
                        (BuildContext context, int index) {

                      return  ExpSubOne(
                        name: controller.dataAllsubunPaid[index].usersFullName!,
                        img: controller.dataAllsubunPaid[index].usersImage!,
                        enddate: controller.dataAllsubunPaid[index].subEndDate!.substring(0,10),
                        startdate: controller.dataAllsubunPaid[index].subDate!.substring(0,10),
                        fee: controller.dataAllsubunPaid[index].subFee!.toString(),
                        subID: controller.dataAllsubunPaid[index].subId!.toString(),
                        index: index,
                        clickApprove: (){
                          controller.ApproveSubUpadte(controller.dataAllsubunPaid[index].subUserId!, controller.dataAllsubunPaid[index].subId!.toString(),controller.dataAllsubunPaid[index].subType!.toString());
                          },
                        onPressed: () async{
                      //  await  controller.getDataProfileSelectUser(                              controller.dataExpSub[index]!.usersId );
                      Get.snackbar("","",

                          snackPosition:SnackPosition.BOTTOM,
                        duration :   Duration(minutes: 1),
                          titleText:  Text(
                              "${controller.dataAllsubunPaid[index]!.usersFullName}",
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!.copyWith(color: ColorApp.darkBlack)

                          )  ,
                          messageText:
                        Neumorphic(
                          margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                          child: Column(
                            children: [

                              Row(
                                mainAxisAlignment:
                                myservices.sharedPref.getString("myLang") ==
                                    "ar"
                                    ? MainAxisAlignment.start
                                    : MainAxisAlignment.start,
                                ///////////////////////////////////////////////////////////////////////
                                children: [
                                  AvatarImag(
                                    color: ColorApp.darkRed,
                                    img:
                                    "${ImageAssetApp.ImageProfile}/${controller.dataAllsubunPaid[index]!.usersImage}",
                                    radius: 35.0,
                                    numCircle: 2,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "${controller.dataAllsubunPaid[index]!.usersFullName}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall!
                                            .copyWith(
                                            color: ColorApp.darkBlack,
                                            fontSize: 15),
                                      ),
                                      Text(
                                        "ID_${controller.dataAllsubunPaid[index]!.usersId} ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall!
                                            .copyWith(
                                            color: ColorApp.middleRed,
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: ConnectionData(
                                      image: "assets/images/iconmail.png",
                                      content:
                                      "${controller.dataAllsubunPaid[index]!.usersEmail}",
                                      mail1Phone2Link3Sms4: 1,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: ConnectionData(
                                      image: "assets/images/iconphone.png",
                                      content:
                                      "${controller.dataAllsubunPaid[index]!.usersPhone}",
                                      mail1Phone2Link3Sms4: 2,
                                    ),
                                  ),
                                ],
                              ),
                              ListTile(
                                title: Row(
                                  children: [
                                    Text(
                                      textAlign: myservices.sharedPref
                                          .getString("myLang") ==
                                          "ar"
                                          ? TextAlign.end
                                          : TextAlign.start,
                                      "Level".tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(
                                          color: ColorApp.lightBlack,
                                          fontSize: 12),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      textAlign: myservices.sharedPref
                                          .getString("myLang") ==
                                          "ar"
                                          ? TextAlign.end
                                          : TextAlign.start,
                                      " ${controller.dataAllsubunPaid[index]!.usersLevel} ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(
                                          color: ColorApp.lightBlack,
                                          fontSize: 12),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                leading: Image.asset(
                                  "assets/images/badge.png",
                                  height: 28,
                                  width: 28,
                                ),

                                minLeadingWidth: 15,
                              ),
                              ListTile(
                                title: Row(
                                  children: [
                                    Text(
                                      textAlign: myservices.sharedPref
                                          .getString("myLang") ==
                                          "ar"
                                          ? TextAlign.end
                                          : TextAlign.start,
                                      "Weight".tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(
                                          color: ColorApp.lightBlack,
                                          fontSize: 12),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      textAlign: myservices.sharedPref
                                          .getString("myLang") ==
                                          "ar"
                                          ? TextAlign.end
                                          : TextAlign.start,
                                      " ${controller.dataAllsubunPaid[index]!.usersWeight} kg",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(
                                          color: ColorApp.lightBlack,
                                          fontSize: 12),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    //////////////////
                                    Spacer(),
                                    Text(
                                      textAlign: myservices.sharedPref
                                          .getString("myLang") ==
                                          "ar"
                                          ? TextAlign.end
                                          : TextAlign.start,
                                      "Height".tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(
                                          color: ColorApp.lightBlack,
                                          fontSize: 12),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      textAlign: myservices.sharedPref
                                          .getString("myLang") ==
                                          "ar"
                                          ? TextAlign.end
                                          : TextAlign.start,
                                      " ${controller.dataAllsubunPaid[index]!.usersHeight} cm ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(
                                          color: ColorApp.lightBlack,
                                          fontSize: 12),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                leading: Image.asset(
                                  "assets/images/body.png",
                                  height: 40,
                                  width: 40,
                                ),
                                minLeadingWidth: 15,
                              ),
                            ],
                          ),
                        ),
                      );

                      },


                      );
                    },

                  ),

                ],
              )
              )


              ),
            )));
  }
}



class ExpSubOne extends StatelessWidget {
  final String name;
  final String img;
  final String enddate;
  final String startdate;
  final String fee;
  final String subID;
  final int index;
  final void Function()? onPressed;
  final void Function()? clickApprove;
  const ExpSubOne({Key? key, required this.name, required this.img, required this.enddate, required this.fee, required this.startdate, required this.subID,required this.onPressed, required this.index, required this.clickApprove,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Myservices myservices = Get.find();

    return
      Stack(
          children: [
            Text(
              "${index+1}  --------------------------------------------------------------------------------------------\n|\n|\n|\n|\n|\n|\n|",
              style: Theme.of(context)
                  .textTheme
                  .displaySmall!.copyWith(color: ColorApp.middleRed,fontSize: 10),

            ),
      Neumorphic(
margin: EdgeInsets.all(10),
      child:
      InkWell(
        onTap: onPressed,
        child:
      ListTile(
        leading:   Neumorphic(
            child: CachedNetworkImage(
              width: 50,
              imageUrl:
              "${ImageAssetApp.ImageProfile}/${img}",
              fit: BoxFit.cover,
              placeholder: (context,
                  url) =>
                  Image.asset(
                      "assets/images/my.png"),
              // صورة افتراضية
              errorWidget: (context, url,
                  error) =>
                  Image.asset(
                      "assets/images/my.png"), // صورة افتراضية في حال حدوث خطأ
            ),),
        title:   Text(
          "$name",
          style: Theme.of(context)
              .textTheme
              .displaySmall!.copyWith(color: ColorApp.darkBlack,fontSize: 15),
          textAlign: myservices.sharedPref
              .getString("myLang") ==
              "ar"
              ? TextAlign.end
              : TextAlign.start,
        ),
        subtitle: Column(children: [
          Text(
            "st:      $startdate",
            style: Theme.of(context)
                .textTheme
                .displaySmall!.copyWith(color: ColorApp.lightBlack,fontSize: 13),
            textAlign: myservices.sharedPref
                .getString("myLang") ==
                "ar"
                ? TextAlign.end
                : TextAlign.start,
          ),

          Text(
            "ex:      $enddate",
            style: Theme.of(context)
                .textTheme
                .displaySmall!.copyWith(color: ColorApp.lightBlack,fontSize: 13),
            textAlign: myservices.sharedPref
                .getString("myLang") ==
                "ar"
                ? TextAlign.end
                : TextAlign.start,
          ),
          Text(
            "sub ID:               $subID",
            style: Theme.of(context)
                .textTheme
                .displaySmall!.copyWith(color: ColorApp.lightBlack,fontSize: 13),

          ),
        Row(children: [
          Text(
            "\n fee :$fee SYP",
            style: Theme.of(context)
                .textTheme
                .displaySmall!.copyWith(color: ColorApp.lightBlack,fontSize: 13),
            textAlign: myservices.sharedPref
                .getString("myLang") ==
                "ar"
                ? TextAlign.end
                : TextAlign.start,
          ),
Spacer(),
Row(children: [
  Text(
    "Unpaid".tr,
    style: Theme.of(context)
        .textTheme
        .displaySmall!.copyWith(color: ColorApp.lightBlack,fontSize: 13),
    textAlign: myservices.sharedPref
        .getString("myLang") ==
        "ar"
        ? TextAlign.end
        : TextAlign.start,
  ),
  NeumorphicButton(
    style: NeumorphicStyle(
      boxShape: NeumorphicBoxShape.circle()
    ),
    child:Icon(Icons.disc_full_outlined,color: ColorApp.lightRed,),
    onPressed: clickApprove,
  )


],)
        ],)
        ],),


      ),
      ),
      style: NeumorphicStyle(depth: 2, shape: NeumorphicShape.concave),
      //onPressed: onPressed,
    ),

    ]
    )
    ;
  }
}