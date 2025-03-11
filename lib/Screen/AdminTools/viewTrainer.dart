import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;
import '../../Classes/handlingStatusRemotDataView.dart';
import '../../Controller/AdminTools/AdminToolsController.dart';
import '../../Controller/CoachTools/coachToolsController.dart';
import '../../Core/Constant/color.dart';
import '../../Core/Constant/imageasset.dart';
import '../../Core/Function/validinput.dart';
import '../../Core/Services/services.dart';
import '../../Data/Model/profileModel.dart';
import '../../Widget/Home/avatarImage.dart';
import '../../Widget/Home/connectionData.dart';

class viewTrainer extends StatelessWidget {
  const viewTrainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.bgMain,
      appBar: AppBar(
        title: Text(
          "Alltrainees".tr,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: GetBuilder<AdminToolsController>(
          builder: (controller) => HandlingStatusRemotDataView(
              statusRequest: controller.statusRequest,
              widget: Container(
                  child: InfoProfile(
                    ListProfileModel: controller.dataSelectUser,
                  )))),
    );
  }
}

class InfoProfile extends GetView<AdminToolsController> {
  final List<ProfileModel> ListProfileModel;

  InfoProfile({Key? key, required this.ListProfileModel}) : super(key: key);
  Myservices myservices = Get.find();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
          Neumorphic(
            child: Container(
              decoration: BoxDecoration(
                color: ColorApp.bgMain,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              padding: EdgeInsets.all(20),
              child: Form(
                key: controller.formKey,
                child: Row(
                  children: [
                    Expanded(
                        child: Neumorphic(
                          style: NeumorphicStyle(
                            depth: -5,
                            boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(10),
                            ),
                          ),
                          child: TextFormField(
                            cursorColor: ColorApp.middleRed,
                            style: Theme.of(context).textTheme.displaySmall,
                            validator: (val) {
                              return validinput(val!, 1, 1000, "");
                            },
                            controller: controller.SelectUser,
                            decoration: InputDecoration(
                              labelText: "user-ID",
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 10),
                              labelStyle: TextStyle(color: ColorApp.lightBlack),
                            ),
                            keyboardType: TextInputType.text,
                          ),
                        )),
                    SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        textStyle: Theme.of(context).textTheme.displaySmall,
                        primary: ColorApp.darkRed,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.all(11),
                      ),
                      onPressed: () {
                        controller.getData(controller.SelectUser.text);
                        //       controller.user = controller.SelectUser.text.toString();
                      },
                      child: Text("Search".tr),
                    ),
                  ],
                ),
              ),
            ),
          ),
          controller.dataSelectUser.isEmpty
              ? ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: controller.dataAllusers.length,
              itemBuilder: (context, index) {
                return NeumorphicButton(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Row(
                    mainAxisAlignment:
                    myservices.sharedPref.getString("myLang") == "ar"
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      AvatarImag(
                        color: ColorApp.lightBlack,
                        img:
                        "${ImageAssetApp.ImageProfile}/${controller.dataAllusers[index]!.usersImage}",
                        radius: 25.0,
                        numCircle: 1,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          Text(
                            "${controller.dataAllusers[index]!.usersFullName}",
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                color: ColorApp.darkBlack, fontSize: 14),
                          ),
                          Text(
                            "ID_${controller.dataAllusers[index]!.usersId} ",
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                color: ColorApp.lightBlack, fontSize: 13),
                          ),
                        ],
                      ),
                      Spacer(),

                    ],
                  ),
                  onPressed: () {
                    controller.getDataProfileSelectUser(
                        controller.dataAllusers[index]!.usersId,true );

                  },
                );
              })
              :



          ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: ListProfileModel.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    /////header

                    Neumorphic(
                      margin:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: Column(
                        children: [
                          NeumorphicButton(
                            style: NeumorphicStyle(
                                boxShape: NeumorphicBoxShape.circle()),
                            child: Icon(
                              Icons.outbond_outlined,
                              color: ColorApp.darkRed,
                            ),
                            onPressed: () {
                              controller.dataSelectUser.clear();
                              controller.getDataAllusers();
                            },
                          ),
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
                                "${ImageAssetApp.ImageProfile}/${controller.profileModelSelectUser!.usersImage}",
                                radius: 35.0,
                                numCircle: 2,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                children: [
                                  Text(
                                    "${controller.profileModelSelectUser!.usersFullName}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall!
                                        .copyWith(
                                        color: ColorApp.darkBlack,
                                        fontSize: 15),
                                  ),
                                  Text(
                                    "ID_${controller.profileModelSelectUser!.usersId} ",
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
                                  "${controller.profileModelSelectUser!.usersEmail}",
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
                                  "${controller.profileModelSelectUser!.usersPhone}",
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
                                  " ${controller.profileModelSelectUser!.usersLevel} ",
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
                            trailing: TextButton(
                              child: Text("changeLevel".tr),
                              onPressed: () {
                                controller.changelevelSelectUser();
                              },
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
                                  " ${controller.profileModelSelectUser!.usersWeight} kg",
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
                                  " ${controller.profileModelSelectUser!.usersHeight} cm ",
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

                    Text(
                      "TrackingWeight".tr,
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(color: ColorApp.darkBlack, fontSize: 14),
                    ),
                    AspectRatio(
                      aspectRatio: 1.7,
                      child: Neumorphic(
                        style: NeumorphicStyle(
                          depth: -5,
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        child: LineChart(
                          LineChartData(
                            lineTouchData: LineTouchData(
                              touchTooltipData: LineTouchTooltipData(
                                tooltipBgColor: Colors.white,
                              ),
                            ),
                            titlesData: FlTitlesData(
                              leftTitles: AxisTitles(
                                axisNameWidget: Text("Weight".tr),
                                axisNameSize: 20,
                              ),
                              bottomTitles: AxisTitles(
                                axisNameWidget: Text("Month".tr),
                                axisNameSize: 20,
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  interval: 1,
                                  getTitlesWidget: (value, meta) {
                                    return Text(
                                      value.toInt().toString(),
                                      style: TextStyle(
                                        color: ColorApp.lightBlack,
                                        fontSize: 12,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            lineBarsData: [
                              LineChartBarData(
                                gradient: LinearGradient(
                                  colors: [
                                    ColorApp.lightBlack,
                                    ColorApp.middleRed
                                  ],
                                  stops: [0.1, 0.5],
                                ),
                                shadow: ui.Shadow(
                                  color: Colors.grey,
                                  blurRadius: 1,
                                  offset: Offset(4, 4),
                                ),
                                color: ColorApp.lightRed,
                                spots: [
                                  for (int i = 0;
                                  i < controller.month.length;
                                  i++)
                                    FlSpot(
                                      controller.month[i].toDouble(),
                                      controller.weight[i].toDouble(),
                                    ),
                                ],
                                dashArray: [2, 6, 12, 16],
                                isCurved: true,
                                dotData: FlDotData(
                                  show: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                );
              })
        ]));
  }
}
