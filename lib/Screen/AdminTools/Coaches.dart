import 'package:flutter/material.dart';
import 'package:fancy_drawer/fancy_drawer.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:smc/Classes/handlingStatusRemotDataView.dart';
import '../../Controller/AdminTools/AdminToolsController.dart';
import '../../Core/Constant/color.dart';
import '../../Widget/Basic/drawerX.dart';
import 'allCoaches.dart';
import 'askBeCoach.dart';

class Coaches extends StatefulWidget {
  const Coaches({Key? key}) : super(key: key);

  @override
  _CoachesState createState() => _CoachesState();
}

class _CoachesState extends State<Coaches> with TickerProviderStateMixin {
  AdminToolsController adminToolsController = Get.put(AdminToolsController());

  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
  }


  @override
  Widget build(BuildContext context) {
    return   GetBuilder<AdminToolsController>(
        builder: (controller) => HandlingStatusRemotDataView(
          statusRequest: controller.statusRequest,
          widget: Scaffold(      backgroundColor: ColorApp.bgMain,
            bottomNavigationBar: Material(
              color: ColorApp.middleRed,
              borderRadius: BorderRadius.circular(10),
              child:
              TabBar(unselectedLabelColor: ColorApp.darkRed,indicatorColor: ColorApp.darkRed,indicatorWeight: 2,indicatorPadding: EdgeInsets.symmetric(horizontal: 20),

                controller: _tabController,
                tabs:   <Widget>[

                  Tab(icon: Image.asset(
                    "assets/images/coach.png",width: 30,
                     color: ColorApp.bacground,
                  ), child:
                  Text( "Coaches".tr,)
                  ),
                  Tab(icon: Image.asset(
                    "assets/images/reqCoach.png",width: 30
                    ,
                    color: ColorApp.bacground,
                  ), child:
                  Text( "reqCoach".tr,)
                  ),
                ],
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              children:   <Widget>[
                AllCoach(),
                Expanded(child: AskBeCoach()),
              ],
            ),
          ),
        ),

    );
  }
}
