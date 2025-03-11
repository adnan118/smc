import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:smc/Classes/handlingStatusRemotDataView.dart';
import 'package:smc/Screen/AdminTools/posts.dart';
import '../../Controller/AdminTools/AdminToolsController.dart';
import '../../Core/Constant/color.dart';
import 'infoReports.dart';
import 'socialBS.dart';

class SocietySMC extends StatefulWidget {
  const SocietySMC({Key? key}) : super(key: key);

  @override
  _SocietySMCState createState() => _SocietySMCState();
}

class _SocietySMCState extends State<SocietySMC> with TickerProviderStateMixin {
  AdminToolsController adminToolsController = Get.put(AdminToolsController());

  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
  }


  @override
  Widget build(BuildContext context) {
    return   GetBuilder<AdminToolsController>(
      builder: (controller) => HandlingStatusRemotDataView(
        statusRequest: controller.statusRequest,
        widget: Scaffold(      backgroundColor: ColorApp.bgMain,
          floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
          floatingActionButton: Material(
            color: ColorApp.middleRed,
            borderRadius: BorderRadius.circular(10),
            child:
            TabBar(unselectedLabelColor: ColorApp.darkRed,indicatorColor: ColorApp.darkRed,indicatorWeight: 3,indicatorPadding: EdgeInsets.symmetric(horizontal: 20),

              controller: _tabController,
              tabs:   <Widget>[

                Tab(icon: Image.asset(
                  "assets/images/Society.png",width: 30,
                  color: ColorApp.bacground,
                ), child:
                Text( "posts".tr,),
                ),
                Tab(icon: Image.asset(
                  "assets/images/reports.png",width: 30
                  ,
                  color: ColorApp.bacground,
                ), child:
                Text( "Report".tr,),
                ),
                Tab(icon: Image.asset(
                  "assets/images/staticPost.png",width: 30,
                  color: ColorApp.bacground,
                ), child:
                Text( "Pinnedposts".tr,)
                ),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children:   <Widget>[
              Posts(),
              InfoReports(),
              SocialBS(),
            ],
          ),
        ),
      ),

    );
  }
}
