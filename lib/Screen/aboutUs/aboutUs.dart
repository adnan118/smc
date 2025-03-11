import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';

import '../../Classes/handlingStatusRemotDataView.dart';
import '../../Controller/DayOfLevel/dayOfLevelController.dart';
import '../../Core/Constant/color.dart';
import '../../Widget/DayOfLevel/cardInfo.dart';
import '../../Widget/General/myStepper.dart';

class AboutUs extends StatelessWidget {
  AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Scaffold(
                backgroundColor: ColorApp.bgMain,
                appBar: AppBar(title: Text("aboutUsTitle".tr)),
                body:
                Neumorphic(
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        child:
                        ListView(
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [

                                Neumorphic(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 15,
                                  ),
                                  child: Container(
                                    height: 200,
                                    child:   Column(mainAxisAlignment: MainAxisAlignment.start,children: [
                                        Image.asset(
                                          "assets/images/smartLogobg.png",fit: BoxFit.cover,width: 160,
                                        ),
                                        Text(
                                          "SmartManagementCenter".tr,
                                          style: Theme.of(context).textTheme.displaySmall,
                                        ),
                                      ],)

                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),


                            ListTile(
                              title: Text("Heightlight".tr  ,style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorApp.darkBlack,fontSize: 16)),
                              leading: Image.asset("assets/images/about-us.png",
                                  width: 40),
                              subtitle: Text( "aboutUs".tr

 ,style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorApp.lightBlack,fontSize: 10)),
                            ),

                            SizedBox(
                              height: 50,
                            ),

Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
  InkWell(
    child:    CardInfo(
      percent: 1,
      img: "assets/images/twitte.png",
      color: Colors.cyan.withOpacity(0.5),
      header: "twitte ",
      footer: "@smc_offical ",
    ),onTap: (){},
  ),
  InkWell(
    child:    CardInfo(
      percent: 1,
      img: "assets/images/facebook.png",
      color: Colors.lightBlue.withOpacity(0.3),
      header: "facebook ",
      footer: "smc offical ",
    ),onTap: (){},
  ),
  InkWell(
    child:    CardInfo(
      percent: 1,
      img: "assets/images/instagram.png",
      color: ColorApp.middleRed.withOpacity(0.5),
      header: "Instagram ",
      footer: "@smc_offical ",
    ),onTap: (){},
  ),
],)
                          ],
                        )
                    )));
  }
}
