import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_link_previewer/flutter_link_previewer.dart';
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
import '../../Data/Model/reportModel.dart';
import '../../Widget/Home/avatarImage.dart';
import '../../Widget/Home/connectionData.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' show PreviewData;

class InfoReports extends StatelessWidget {
  InfoReports({Key? key}) : super(key: key);
  Myservices myservices = Get.find();
  @override
  Widget build(BuildContext context) {


    return  GetBuilder<AdminToolsController>(
        builder: (controller) => HandlingStatusRemotDataView(
          statusRequest: controller.statusRequest,
          widget:   controller.dataReport.isEmpty?Center(
            child:TextButton (
              child:Icon(Icons.refresh,color: ColorApp.darkRed,),
              onPressed: (){
                controller.getAllReports();
              },
            ),
          ):RefreshIndicator(
              color: ColorApp.bgMain,
              backgroundColor: ColorApp.darkRed,
              onRefresh: () async {
                await Future.delayed(Duration(seconds: 2));
                Get.put(ViewProfileController());
                Get.offAllNamed("/RootPage");
              },
              child:
              controller.dataReport.isEmpty?Center(
                child:TextButton (
                  child:Icon(Icons.refresh,color: ColorApp.darkRed,),
                  onPressed: (){
                    controller.getAllReports();
                  },
                ),
              ):
              SingleChildScrollView(child:
              Column(
                children: [

                  ListView.builder(

                       padding: EdgeInsets.only(top:   100),
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: controller.dataReport.length,

                    itemBuilder:
                        (BuildContext context, int index) {

                      return  AllReports(
                        reportModel: controller.dataReport[index],
                        onCancel:(){
                          controller.cancelReport(controller.dataReport[index]!.ratingReportId);
                        } ,onDelete: (){
                        controller. deletPostAndReport(
                            controller.dataReport[index]!.ratingReportFromuser,
                            controller.dataReport[index]!.socialId,
                            controller.dataReport[index]!.ratingReportId
                        ) ;

                      },
                        index: index,
onDetail: (){
                          Get.defaultDialog(
                          title: "Reportingdetails".tr,

                          content: Column(
                            children: [
                              Row(children: [
                                Text(
                                  "Reportfrom".tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(
                                      color: ColorApp.darkBlack,
                                      fontSize: 14),
                                ),
                                Text(
                                  " : ID_${controller.dataReport[index]!.ratingReportFromuser}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(
                                      color: ColorApp.lightBlack,
                                      fontSize: 12),
                                ),
                              ],),
                              Row(children: [
                                Text(
                                  "about".tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(
                                      color: ColorApp.darkBlack,
                                      fontSize: 14),
                                ),
                                Text(
                                  " : ${controller.dataReport[index]!.usersFullName}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(
                                      color: ColorApp.lightBlack,
                                      fontSize: 12),
                                ),
                              ],),
                              SizedBox(height: 20,),
                              Row(children: [
                                Text(
                                  "comments".tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(
                                      color: ColorApp.darkBlack,
                                      fontSize: 14),
                                ),
                                Text(
                                  " : ${controller.dataReport[index]!.ratingReportComments}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(
                                      color: ColorApp.lightBlack,
                                      fontSize: 12),
                                ),
                              ],),

                              Row(children: [
                                Text(
                                  "date".tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(
                                      color: ColorApp.darkBlack,
                                      fontSize: 14),
                                ),
                                Text(
                                  " : ${controller.dataReport[index]!.ratingReportDate}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(
                                      color: ColorApp.lightBlack,
                                      fontSize: 12),
                                ),
                              ],),
                            ],
                          ));
},
                        onPressed: () async{

                         Get.snackbar("","",

                            snackPosition:SnackPosition.BOTTOM,
                            duration :   Duration(minutes: 1),
                            titleText:  Text(
                                "${controller.dataReport[index]!.usersFullName}",
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
                                        "${ImageAssetApp.ImageProfile}/${controller.dataReport[index]!.usersImage}",
                                        radius: 35.0,
                                        numCircle: 2,
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            "${controller.dataReport[index]!.usersName}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall!
                                                .copyWith(
                                                color: ColorApp.darkBlack,
                                                fontSize: 15),
                                          ),
                                          Text(
                                            "ID_${controller.dataReport[index]!.usersId} ",
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
                                          "${controller.dataReport[index]!.usersEmail}",
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
                                          "${controller.dataReport[index]!.usersPhone}",
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
                                          " ${controller.dataReport[index]!.usersLevel} ",
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

                                ],
                              ),
                            ),
                          );

                        },


                      );
                    },

                  ),
                  ////////////////////////////////////////////////////////////////////////







                ],
              )
              )


          ),
        )

    );
  }
}





class AllReports extends StatelessWidget {

  final void Function()? onCancel;
  final void Function()? onDelete;
  final void Function()? onDetail;
  ReportModel? reportModel;

  final int index;
  final void Function()? onPressed;
    AllReports({Key? key,required this.reportModel,  required this.onPressed, required this.index,   this.onCancel, this.onDelete,required this.onDetail  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Myservices myservices = Get.find();
    Map<String, PreviewData> datas = {};
    return
      Container(
      //  padding: EdgeInsets.only(top: 0, bottom: 155),
        height: 210,
        color: ColorApp.bgMain,
        child:  Align(
          alignment: Alignment.centerLeft,
          child: Container(
            key: ValueKey(reportModel!.socialUrl),
            margin: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              color: Color(0xfff7f7f8),
            ),
            child: NeumorphicButton(
              onPressed:onPressed,
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      print("profile");
                    },
                    child: Row(
                      children: [
                        AvatarImag(
                          color: ColorApp.darkRed,
                          img:
                          "${ImageAssetApp.ImageProfile}/${reportModel!.usersImage}",
                          radius: 25,
                          numCircle: 0,
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Text(
                                "@${reportModel!.usersName!}",
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                    color: ColorApp
                                        .darkBlack,
                                    fontSize: 10),
                              ),
                              Text(
                                reportModel!.socialDate!
                                    .substring(0, 10),
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                    color: ColorApp
                                        .lightBlack,
                                    fontSize: 8),
                              ),

                            ],
                          ),
                        ),
                        Spacer(),
                        NeumorphicButton(

                            onPressed: onDetail,
                            child:  Text(
                              "Reportingdetails".tr,
                              style:Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 10,color: ColorApp.lightBlack ,),
                            ))
                      ],
                    ),
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    child: LinkPreview(
                      metadataTextStyle: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(
                          color: ColorApp.lightBlack,
                          fontSize: 10),
                      metadataTitleStyle: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(
                          color: ColorApp.darkRed,
                          fontSize: 11),
                      enableAnimation: true,
                      onPreviewDataFetched: (data) {
                        datas = {
                          ...datas,
                          reportModel!. socialUrl!:
                          data,
                        };
                      },

                      previewData: datas[
                      reportModel!.socialUrl],
                      text:reportModel!.socialUrl!,
                      //
                      textStyle: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(
                          color: ColorApp.darkRed,
                          fontSize: 11),
                      width:
                      MediaQuery.of(context).size.width,
                    ),
                  ),
                  Row(
                    children: [

                      Text(
                        "${ reportModel!.socialRate} ",
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(
                            color: ColorApp.middleRed),
                      ),
                      Text(
                        "Like".tr,
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(
                            color: ColorApp.lightBlack),
                      ),
                      Spacer(),

                      NeumorphicButton(
                          style: NeumorphicStyle(boxShape: NeumorphicBoxShape.circle()),
                          onPressed: onDelete,
                          child:  Text(
                            "Delete".tr,
                            style:Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 10,color: ColorApp.lightBlack ,),
                          )),
                      NeumorphicButton(
                          style: NeumorphicStyle(boxShape: NeumorphicBoxShape.circle()),
                          onPressed: onCancel,
                          child:  Text(
                            "btnCancel".tr,
                            style:Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 10,color: ColorApp.lightBlack ,),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),

      )
    ;
  }
}