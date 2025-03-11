import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import '../../Classes/handlingStatusRemotDataView.dart';
import '../../Controller/AdminTools/AdminToolsController.dart';
import '../../Controller/Home/profileController.dart';
import '../../Core/Constant/color.dart';

class MainToolAdmin extends StatelessWidget {
  const MainToolAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ViewProfileController viewProfileController=Get.put(ViewProfileController());
    AdminToolsController adminToolsController=Get.put(AdminToolsController());
    return Scaffold(
        backgroundColor: ColorApp.bgMain,
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
                child: viewProfileController.data.isEmpty ?Center(
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
                ):

              Stack(fit: StackFit.expand,
                children: [


                  GridView.builder(
                    padding: EdgeInsets.all(10),
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: controller.ListTitleTM.length,
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 160,
                      crossAxisSpacing: 50,
                    ),
                    itemBuilder:
                        (BuildContext context, int index) {

                      return  TaskManager(
                        title: controller.ListTitleTM[index],
                        icon: controller.ListIconTM[index],
                        onPressed: (){
                         controller.TMpressed(index);
                        },
                      );
                    },

                  ),
              Positioned(child:     Image.asset( "assets/images/TM.png",width: 170,),top: 140,left: 90,),



            /*
              Positioned(child:       NeumorphicButton(
                style: NeumorphicStyle(depth: -25),
                child:
                Container(
                  height: 250,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(10),
                  ),
                  child:
                  GridView.builder(
                    padding: EdgeInsets.all(10),
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: controller.ListTitleTM.length,
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 160,
                      crossAxisSpacing: 50,
                    ),
                    itemBuilder:
                        (BuildContext context, int index) {

                      return  TaskManager(
                        title: controller.ListTitleTM[index],
                        icon: controller.ListIconTM[index],
                        onPressed: (){
                          controller.TMpressed(index);
                        },
                      );
                    },

                  ),




                ),
                onPressed: (){},
              ),top:500,left: 20,),*/

                ],
              )


              ),
            )));
  }
}

class TaskManager extends StatelessWidget {
  final String title;
  final String icon;
  final void Function()? onPressed;
  const TaskManager({Key? key, required this.title, required this.icon,required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(

      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
          Image.asset(icon,width: 50,),
          SizedBox(height: 15,),
          Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .displaySmall!.copyWith(color: ColorApp.lightBlack,fontSize: 13),
            textAlign: TextAlign.center,
          ),

        ],),
      ),
      style: NeumorphicStyle(depth: 2,boxShape: NeumorphicBoxShape.circle(),shape: NeumorphicShape.convex),
      onPressed: onPressed,
    );
  }
}
