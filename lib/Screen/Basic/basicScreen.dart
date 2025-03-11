import 'package:cached_network_image/cached_network_image.dart';
import 'package:fancy_drawer/fancy_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../../Classes/handlingStatusRemotDataView.dart';
import '../../Controller/DayOfLevel/levelsController.dart';
import '../../Controller/Home/basicScreenController.dart';
import '../../Controller/Home/profileController.dart';
import '../../Controller/Home/statusController.dart';
import '../../Controller/Social/socialController.dart';
import '../../Controller/Store/storeController.dart';
import '../../Controller/Subscription/subscriptionController.dart';
import '../../Core/Constant/color.dart';
import '../../Core/Constant/imageasset.dart';
import '../../Core/Localization/translateDB.dart';
import '../../Widget/Basic/cardTopInfoUser.dart';
import '../../Widget/Home/avatarImage.dart';
import '../../Widget/Home/circlePercent.dart';
import '../../Widget/Home/connectionData.dart';
import '../../Widget/Home/indicatorPercent.dart';

class BasicScreen extends StatefulWidget {
  const BasicScreen({Key? key}) : super(key: key);

  @override
  State<BasicScreen> createState() => _BasicScreenState();
}

class _BasicScreenState extends State<BasicScreen>
    with SingleTickerProviderStateMixin {
  BasicScreenController basicScreenController =      Get.put(BasicScreenController());
  ViewProfileController viewProfileController =      Get.put(ViewProfileController());
  SubscriptionController subscriptionController =      Get.put(SubscriptionController());
  late FancyDrawerController FDC_controller;

  @override
  void initState() {
    super.initState();
    subscriptionController.getSubscriptionActive();
    basicScreenController.getSocialAllMy();
    FDC_controller = FancyDrawerController(
        vsync: this, duration: Duration(milliseconds: 500))
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    FDC_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StatusController statusController =
        Get.put(StatusController()); // Initialize StatusController
    // AnalyticsController analyticsController = Get.put(AnalyticsController());

    return Scaffold(
        backgroundColor: ColorApp.bgMain,
        body: GetBuilder<BasicScreenController>(
            builder: (basicScreenController) => HandlingStatusRemotDataView(
                  statusRequest: basicScreenController.statusRequest,
                  widget: RefreshIndicator(
                    color: ColorApp.bgMain,
                    backgroundColor: ColorApp.darkRed,
                    onRefresh: () async {
                      await Future.delayed(Duration(seconds: 2));
                      Get.delete<BasicScreenController>();
                      Get.put(SubscriptionController());
                      Get.put(ViewProfileController());
                      Get.offAllNamed("/RootPage");
                    },
                    child: viewProfileController.data.isEmpty&&subscriptionController.dataSubscription.isEmpty?Center(
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: ColorApp.darkRed,
                          ),
                          Text(
                            "gettingyouprofile".tr,
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!.copyWith(color: ColorApp.darkBlack)

                          ),
                        ],
                      ),
                    ):CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          backgroundColor: ColorApp.darkRed,
                          pinned: true,
                          expandedHeight: 150,
                          flexibleSpace: FlexibleSpaceBar(
                            title: Text(


                              "${statusController.titleMode}",
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(
                                      color: ColorApp.bacground, fontSize: 15),
                            ),
                            background: Container(
                              child: CardTopInfoUser(),
                            ),
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    child: Column(
                                      children: [
                                        ListTile(
                                          title: Text(
                                            "VitalityActivity".tr,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall!
                                                .copyWith(
                                                    color: ColorApp.darkBlack,
                                                    fontSize: 12),
                                          ),
                                        ),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            IndicatorPercent(
                                                title: "${basicScreenController.perWater*10} L",
                                                percent: basicScreenController
                                                    .perWater),
                                            CirclePercent(
                                                percent: basicScreenController
                                                    .perCaloriy,
                                                iconX: Icons
                                                    .local_fire_department_outlined,
                                                hightDeg: ColorApp.darkRed,
                                                lowDeg: ColorApp.darkRed,
                                                header: "1 KM  ~ 100 Calories",
                                                footer: "2000 Calories"),
                                            CirclePercent(
                                                percent: basicScreenController
                                                    .perStep,
                                                iconX: Icons.directions_run,
                                                hightDeg: ColorApp.darkRed,
                                                lowDeg: ColorApp.darkRed,
                                                header: "1 KM  ~ 1500 Steps",
                                                footer: "1500 Steps"),
                                          ],
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                        ),
                                      ],
                                    ),
                                  ),

                                  //         Levels(index:index),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    child: Column(
                                      children: [
                                        ListTile(
                                          title: Text(
                                            "societySMC".tr,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall!
                                                .copyWith(
                                                    color: ColorApp.darkBlack,
                                                    fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          height: 300,
                                          color: ColorApp.bgMain,
                                          child: Neumorphic(
                                            child: ListView.builder(
                                                physics:
                                                    BouncingScrollPhysics(),
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: basicScreenController.dataBS.length+1,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return index != basicScreenController.dataBS.length
                                                      ? Neumorphic(
                                                          child:CardImg(
                                                            socialBSdate:  basicScreenController.dataBS[index].socialBSDate!,
                                                            socialBSimg: basicScreenController.dataBS[index].socialBSImg!,
                                                            socialBSurl: basicScreenController.dataBS[index].socialBSUrl!,
                                                            socialBSTitle:   "${translateDB(
                                                                basicScreenController.dataBS[index].socialBSTitleAr!,
                                                                basicScreenController.dataBS[index].socialBSTitle!
                                                            )}",
                                                          )
                                                  )
                                                      : Center(
                                                          child: Container(
                                                              width: 120,
                                                              height: 300,
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          15,
                                                                      vertical:
                                                                          120),
                                                              child:
                                                                  MaterialButton(
                                                                color: ColorApp
                                                                    .lightBlack
                                                                    .withOpacity(
                                                                        0.1),
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50.0),
                                                                ),
                                                                child: Row(
                                                                  children: [
                                                                    Text(
                                                                      "More".tr,
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .displaySmall!
                                                                          .copyWith(
                                                                              color: ColorApp.bacground,
                                                                              fontSize: 12),
                                                                    ),
                                                                    Icon(
                                                                        Icons
                                                                            .add,
                                                                        color: Colors
                                                                            .white),
                                                                  ],
                                                                ),
                                                                onPressed:
                                                                    () {
                                                                  Get.toNamed("/Social");
                                                                    },
                                                              )));
                                                }),
                                          ),
                                        ),
                                        //    SlidingCardView(),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                            childCount: basicScreenController.x,
                          ),
                        ),
                      ],
                    ),
                  ),
                )));
  }
}

class CardImg extends StatelessWidget {
  final String socialBSimg;
  final String socialBSdate;
  final String socialBSurl;
  final String socialBSTitle;
  const CardImg({Key? key, required this.socialBSimg, required this.socialBSdate, required this.socialBSurl, required this.socialBSTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ViewProfileController viewProfileController =
        Get.put(ViewProfileController());
    return Stack(children: [
      Neumorphic(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          width: 300,
          height: 300,
          padding: EdgeInsets.all(5),
          child: Column(
            children: [
              Row(
                children: [
                  AvatarImag(
                    color: ColorApp.darkRed,
                    img:
                        "${ImageAssetApp.ImageSocial}/smartLogo.png",
                    radius: 15,
                    numCircle: 0,
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(
                          "@smc",
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                  color: ColorApp.darkBlack, fontSize: 10),
                        ),
                        Text(
                          "${socialBSdate.substring(0,10)}",
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                  color: ColorApp.lightBlack, fontSize: 8),
                        )
                      ],
                    ),
                  ),
                  Spacer(),
                  Text(
                    "${socialBSTitle}",
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(color: ColorApp.darkBlack, fontSize: 10),
                  )
                ],
              ),
              Neumorphic(
                child:

                CachedNetworkImage(
                  imageUrl:     "${ImageAssetApp.ImageSocial}/${socialBSimg}",
                  fit: BoxFit.cover,
                  height: 170,
                  placeholder: (context, url) =>Center(child: CircularProgressIndicator(color: ColorApp.darkRed),), // صورة افتراضية
                  errorWidget: (context, url, error) => Image.asset("assets/images/product.png"), // صورة افتراضية في حال حدوث خطأ

                )
                /*
                Image.network(
                  "${ImageAssetApp.ImageSocial}/${socialBSimg}",
                  height: 170,
                ),
                */


              ),
              Row(
                children: [
                  Expanded(
                    child: ConnectionData(
                      image: "assets/images/shortcut.png",
                      content:
                          "${socialBSurl}",
                      mail1Phone2Link3Sms4: 3,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
