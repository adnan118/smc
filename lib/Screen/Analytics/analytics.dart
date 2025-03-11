import 'package:fancy_drawer/fancy_drawer.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;
import '../../Classes/handlingStatusRemotDataView.dart';
import '../../Controller/Analytics/analytics.dart';
import '../../Core/Constant/color.dart';
import '../../Widget/Analytics/btnEditWeightHeight.dart';

class Analytics extends StatefulWidget {
  const Analytics({Key? key}) : super(key: key);

  @override
  State<Analytics> createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics>
    with SingleTickerProviderStateMixin {
  late FancyDrawerController FDC_controller =
      FancyDrawerController(vsync: this, duration: Duration(milliseconds: 500))
        ..addListener(() {
          setState(() {});
        });

  @override
  void dispose() {
    FDC_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AnalyticsController analyticsController = Get.put(AnalyticsController());
    return FancyDrawerWrapper(
      backgroundColor: NeumorphicColors.background,
      controller: FDC_controller,
      drawerItems: <Widget>[
        //  DrawerX()
      ],
      child: Scaffold(
        body: GetBuilder<AnalyticsController>(
          builder: (analyticsController) => HandlingStatusRemotDataRequest(
            statusRequest: analyticsController.statusRequest,
            widget: analyticsController.data.isEmpty
                ? CircularProgressIndicator()
                : RefreshIndicator(
                    color: ColorApp.bgMain,
                    backgroundColor: ColorApp.darkRed,
                    onRefresh: () async {
                      await Future.delayed(Duration(seconds: 2));
                      Get.delete<AnalyticsController>();
                      Get.put(AnalyticsController());
                      Get.offNamed("/RootPage");


                    },
                    child: SingleChildScrollView(
                      child: Neumorphic(
                        child: Container(
                          padding: EdgeInsets.only(top: 20),
                          height: 650,
                          color: ColorApp.bgMain,
                          child: ListView(
                            physics: BouncingScrollPhysics(),
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: Column(
                                  children: [
                                    ListTile(
                                        title: Text(
                                          "Weightduringtheyear".tr,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall!
                                              .copyWith(
                                                  color: ColorApp.darkBlack),
                                        ),
                                        trailing: BtnEditWeightHeight()),
                                    AspectRatio(
                                      aspectRatio: 1.7,
                                      child: Neumorphic(
                                        style: NeumorphicStyle(
                                          depth: -5,
                                        ),
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: LineChart(
                                          LineChartData(
                                            lineTouchData: LineTouchData(
                                              touchTooltipData:
                                                  LineTouchTooltipData(
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
                                                  getTitlesWidget:
                                                      (value, meta) {
                                                    return Text(
                                                      value.toInt().toString(),
                                                      style: TextStyle(
                                                        color:
                                                            ColorApp.lightBlack,
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
                                                      i <
                                                          analyticsController
                                                              .month.length;
                                                      i++)
                                                    FlSpot(
                                                      analyticsController
                                                          .month[i]
                                                          .toDouble(),
                                                      analyticsController
                                                          .weight[i]
                                                          .toDouble(),
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
                                ),
                              ),






                              analyticsController.data.isEmpty||
                              analyticsController.totalHours.isEmpty||
                              analyticsController.totalSeconds.isEmpty||
                              analyticsController.totalMinutes.isEmpty

                ?   CircularProgressIndicator(color: ColorApp.darkRed,)
                                  :
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text(
                                        "Modeduringtheyear".tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall!
                                            .copyWith(
                                                color: ColorApp.darkBlack),
                                      ),
                                    ),
                                    Text(
                                      "${analyticsController.data[2].totalDuration} ${analyticsController.data[2].mode} hours", //Training
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(
                                              color: ColorApp.lightBlack,
                                              fontSize: 12),
                                    ),
                                    NeumorphicSlider(
                                      min: 0,
                                      max: 8785,
                                      value: analyticsController.totalHours[2]
                                              .toDouble() +
                                          analyticsController.totalMinutes[2]
                                                  .toDouble() /
                                              60,
                                      height: 20,
                                      onChanged: (x) {},
                                      style: SliderStyle(
                                        accent: ColorApp.middleRed,
                                        borderRadius: BorderRadius.circular(5),
                                        depth: 3,
                                        variant: ColorApp.lightRed,
                                      ),
                                      thumb: Container(
                                        child: Icon(Icons.directions_run),
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 0),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "${analyticsController.data[0].totalDuration}  ${analyticsController.data[0].mode} hours", //Break
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(
                                              color: ColorApp.lightBlack,
                                              fontSize: 12),
                                    ),
                                    NeumorphicSlider(
                                      min: 0,
                                      max: 8785,
                                      value: analyticsController.totalHours[0]
                                              .toDouble() +
                                          analyticsController.totalMinutes[0]
                                                  .toDouble() /
                                              60,
                                      height: 20,
                                      onChanged: (x) {},
                                      style: SliderStyle(
                                        accent: ColorApp.middleRed,
                                        borderRadius: BorderRadius.circular(5),
                                        depth: 3,
                                        variant: ColorApp.lightRed,
                                      ),
                                      thumb: Container(
                                        child:
                                            Icon(Icons.free_breakfast_outlined),
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 0),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "${analyticsController.data[1].totalDuration}  ${analyticsController.data[1].mode} hours", //Sleep
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(
                                              color: ColorApp.lightBlack,
                                              fontSize: 12),
                                    ),
                                    NeumorphicSlider(
                                      min: 0,
                                      max: 8785,
                                      value: analyticsController.totalHours[1]
                                              .toDouble() +
                                          analyticsController.totalMinutes[1]
                                                  .toDouble() /
                                              60,
                                      height: 20,
                                      onChanged: (x) {},
                                      style: SliderStyle(
                                        accent: ColorApp.middleRed,
                                        borderRadius: BorderRadius.circular(5),
                                        depth: 3,
                                        variant: ColorApp.lightRed,
                                      ),
                                      thumb: Container(
                                        child: Icon(Icons.snooze_rounded),
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 0),
                                      ),
                                    ),
                                  ],
                                ),
                              ),///////////////////////////////////////////
                            ],
                          ),
                        ),
                      ),
                    )),
          ),
        ),
      ),
    );
  }
}
