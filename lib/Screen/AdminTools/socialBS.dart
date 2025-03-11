import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';

import '../../Auth/Widget/customTextFormAuth.dart';
import '../../Classes/handlingStatusRemotDataView.dart';
import '../../Controller/Home/basicScreenController.dart';
import '../../Controller/Home/profileController.dart';
import '../../Core/Constant/color.dart';
import '../../Core/Constant/imageasset.dart';
import '../../Core/Function/validinput.dart';
import '../../Core/Localization/translateDB.dart';
import '../../Widget/Home/avatarImage.dart';
import '../../Widget/Home/connectionData.dart';

class SocialBS extends StatelessWidget {
  const SocialBS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BasicScreenController basicScreenController =      Get.put(BasicScreenController());

    return
      basicScreenController.dataBS.isEmpty?Center(
        child:TextButton (
          child:Icon(Icons.refresh,color: ColorApp.darkRed,),
          onPressed: (){
            basicScreenController.getSocialAllMy();
          },
        ),
      ):
      GetBuilder<BasicScreenController>(
        builder: (basicScreenController) => HandlingStatusRemotDataView(
      statusRequest: basicScreenController.statusRequest,
      widget:

      Container(
        margin: EdgeInsets.only(top: 120),
      height: 300,
      color: ColorApp.bgMain,
      child: Neumorphic(
        child: ListView.builder(
            physics:
            BouncingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection:
            Axis.vertical,
            itemCount: basicScreenController.dataBS.length,
            itemBuilder:
                (BuildContext context,
                int index) {
              return Stack(
                  children:[Neumorphic(
                    margin: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                  child:CardImg(
                    socialBSdate:  basicScreenController.dataBS[index].socialBSDate!,
                    socialBSimg: basicScreenController.dataBS[index].socialBSImg!,
                    socialBSurl: basicScreenController.dataBS[index].socialBSUrl!,
                    socialBSTitle:   "${translateDB(
                        basicScreenController.dataBS[index].socialBSTitleAr!,
                        basicScreenController.dataBS[index].socialBSTitle!
                    )}",
                  )
              ),
                    NeumorphicButton(
                      style: NeumorphicStyle(boxShape: NeumorphicBoxShape.circle(),color: ColorApp.middleRed),
                      child: Text("Edit", style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(
                          color: ColorApp.darkBlack, fontSize: 15),),
                      onPressed: (){
                        basicScreenController.socialBS_url= TextEditingController(text: basicScreenController.dataBS[index].socialBSUrl);
                        basicScreenController.socialBS_title = TextEditingController(text: basicScreenController.dataBS[index].socialBSTitle);
                        basicScreenController.socialBS_title_ar = TextEditingController(text: basicScreenController.dataBS[index].socialBSTitleAr);
                      //  basicScreenController.socialBS_img=basicScreenController.dataBS[index].socialBSImg!.toString() ;

                        Get.bottomSheet(
                            ignoreSafeArea: false,
                            isScrollControlled: false,
                            //showAllTrainees()
                            Neumorphic(

                             child: SingleChildScrollView(child:  Form(
                                  key: basicScreenController.myKeyEpAdmin,
                                  child:
                                  Column(mainAxisSize: MainAxisSize.max, children: [

                                    Stack(
                                      children: [

                                        AvatarImag(
                                          color: ColorApp.darkRed,
                                          img:
                                          "${ImageAssetApp.ImageSocial}/${basicScreenController.dataBS[index].socialBSImg}",
                                          radius: 60.0,
                                          numCircle: 0,
                                        ),

                                        Padding(
                                          padding: EdgeInsets.only(top: 60, left: 90),
                                          child: IconButton(
                                            splashRadius: 25,
                                            iconSize: 30,
                                            icon: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(20),
                                                  color: ColorApp.darkRed),
                                              child: Icon(
                                                Icons.download_for_offline_outlined,
                                                color: ColorApp.bgMain,
                                              ),
                                            ),
                                            onPressed: () {
                                              basicScreenController.chooesImg();

                                              basicScreenController.update();
                                            },
                                          ),
                                        ),
                                      ],
                                    ),





                                    Container(
                                      width: 222,
                                      child: CustomTextFormAuth(
                                        title: "${ basicScreenController.socialBS_title.text}".tr,
                                        hint:
                                        "${ basicScreenController.socialBS_title.text}",
                                        obscureText: false,
                                        icon: Icons.text_fields,
                                        myController: basicScreenController.socialBS_title!,
                                        keyboardTypex: TextInputType.text,
                                        valid: (val) {
                                          return validinput(val!, 3, 20, "");
                                        },
                                      ),
                                    ),
                                    Container(
                                      width: 222,
                                      child: CustomTextFormAuth(
                                        title: "${ basicScreenController.socialBS_title_ar.text}".tr,
                                        hint:
                                        "${ basicScreenController.socialBS_title_ar.text}",
                                        obscureText: false,
                                        icon: Icons.text_fields,
                                        myController: basicScreenController.socialBS_title_ar!,
                                        keyboardTypex: TextInputType.text,
                                        valid: (val) {
                                          return validinput(val!, 3, 20, "");
                                        },
                                      ),
                                    ),
                                    Container(
                                      width: 222,
                                      child: CustomTextFormAuth(
                                        title: "${ basicScreenController.socialBS_url.text}".tr,
                                        hint:
                                        "${ basicScreenController.socialBS_url.text}",
                                        obscureText: false,
                                        icon: Icons.link,
                                        myController: basicScreenController.socialBS_url!,
                                        keyboardTypex: TextInputType.text,
                                        valid: (val) {
                                          return validinput(val!, 3, 100, "");
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    NeumorphicButton(

                                      onPressed: () {

                                        basicScreenController
                                            .setSocialAllMy(basicScreenController.dataBS[index].socialBSId );
                                        basicScreenController.update();
                                        Get.back();
                                      },
                                      child: Image.asset(
                                        'assets/images/done.png',
                                        width: 25,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ]
                                  ),
                                )
                                )
                            )
                        );},
                    )
                  ]
              )
                  ;
            }),
      ),
      ),
      ),
    );
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
    BasicScreenController basicScreenController =      Get.put(BasicScreenController());

    return Column(children: [
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
                    radius: 25,
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
