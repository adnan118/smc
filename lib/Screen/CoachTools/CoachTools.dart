import 'package:flutter/material.dart';
import 'package:fancy_drawer/fancy_drawer.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:smc/Classes/handlingStatusRemotDataView.dart';
import 'package:smc/Screen/CoachTools/sendNotification.dart';
import 'package:smc/Screen/CoachTools/viewTrainer.dart';
import '../../Controller/CoachTools/coachToolsController.dart';
import '../../Core/Constant/color.dart';
import '../../Widget/Basic/drawerX.dart';

class CoachTools extends StatefulWidget {
  const CoachTools({Key? key}) : super(key: key);

  @override
  _CoachToolsState createState() => _CoachToolsState();
}

class _CoachToolsState extends State<CoachTools> with TickerProviderStateMixin {
  CoachToolsController basicScreenController = Get.put(CoachToolsController());
  late FancyDrawerController FDCController;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    FDCController = FancyDrawerController(vsync: this, duration: const Duration(milliseconds: 500))
      ..addListener(() {
        setState(() {});
      });
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    FDCController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(
          "CoachTools".tr,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: FancyDrawerWrapper(
        backgroundColor: NeumorphicColors.background,
        controller: FDCController,
        drawerItems: <Widget>[DrawerX()],
        child: GetBuilder<CoachToolsController>(
          builder: (controller) => HandlingStatusRemotDataView(
            statusRequest: controller.statusRequest,
            widget: Scaffold(      backgroundColor: ColorApp.bgMain,
              bottomNavigationBar: Material(
                color: ColorApp.middleRed,
                borderRadius: BorderRadius.circular(10),
                child: TabBar(unselectedLabelColor: ColorApp.darkRed,indicatorColor: ColorApp.darkRed,indicatorWeight: 2,indicatorPadding: EdgeInsets.symmetric(horizontal: 20),

                  controller: _tabController,
                  tabs: const <Widget>[
                    Tab(icon: Icon(Icons.people_alt),
                    ),
                    Tab(icon: Icon(Icons.send_sharp)),
                  ],
                ),
              ),
              body: TabBarView(
                controller: _tabController,
                children:   <Widget>[
                    viewTrainer(),
                  SendNotification(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
