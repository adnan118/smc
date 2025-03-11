import 'package:fancy_drawer/fancy_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Controller/Social/socialController.dart';
import '../../Core/Constant/imageasset.dart';
import '../../Core/Function/validinput.dart';
import '../../Classes/handlingStatusRemotDataView.dart';
import '../../Core/Constant/color.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' show PreviewData;
import 'package:flutter_link_previewer/flutter_link_previewer.dart';

import '../../Core/Services/services.dart';
import '../../Widget/Home/avatarImage.dart';

class Posts extends StatefulWidget {
  const Posts({Key? key}) : super(key: key);

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> with SingleTickerProviderStateMixin {
  Map<String, PreviewData> datas = {};
  Myservices myservices = Get.find();
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
    SocialController socialController = Get.put(SocialController());

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return FancyDrawerWrapper(
      backgroundColor: NeumorphicColors.background,
      controller: FDC_controller,
      drawerItems: <Widget>[
        // DrawerX()
      ],
      child: RefreshIndicator(
        color: ColorApp.bgMain,
        backgroundColor: ColorApp.darkRed,
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 2));
          Get.delete<SocialController>();
          Get.put(SocialController());
          // Get.offNamed("/RootPage");
        },
        child: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: GetBuilder<SocialController>(
              builder: (socialController) => TextFileShare(
                    formKey: formKey,
                    shareUrl: socialController.shareUrl,
                    onPressed: () {
                      if (formKey.currentState?.validate() ?? false) {
                        socialController
                            .shareMySocial(socialController.shareUrl.text);
                      }
                    },
                  )),

          body: GetBuilder<SocialController>(
            builder: (socialController) => HandlingStatusRemotDataRequest(
              statusRequest: socialController.statusRequest,
              widget: socialController.data.isEmpty
                  ?

              Column(crossAxisAlignment: CrossAxisAlignment.end,children: [

                  MyFilter(
                  onSelected: (value) async {
            if (value == "Me".tr) {
            socialController.getSocialAllMy();
            } else {
            socialController.getSocialAll();
            }
            },
            ),
                Center(
                  child:  Text(
                    "Empty",
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(
                        color: ColorApp
                            .darkBlack,
                        fontSize: 10),
                  ),
                ),
                  ]
              )
                  : SingleChildScrollView(

                      child: Neumorphic(
                        child:Column(crossAxisAlignment: CrossAxisAlignment.end,children: [
                          MyFilter(
                            onSelected: (value) async {
                              if (value == "Me".tr) {
                                socialController.getSocialAllMy();
                              } else {

                                socialController.getSocialAll();
                              }
                            },
                          ),
                          Container(
                          padding: EdgeInsets.only(top:   200,bottom: 180),
                          height: 750,
                          color: ColorApp.bgMain,
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: socialController.urls.length,
                            itemBuilder: (context, index) => Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                key: ValueKey(socialController.urls[index]),
                                margin: const EdgeInsets.all(16),
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  color: Color(0xfff7f7f8),
                                ),
                                child: NeumorphicButton(
                                  onPressed: () {},
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
                                                  "${ImageAssetApp.ImageProfile}/${socialController.data[index].usersImage}",
                                              radius: 25,
                                              numCircle: 0,
                                            ),
                                            Container(
                                              margin: EdgeInsets.all(10),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "@${socialController.data[index]!.usersName!}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displaySmall!
                                                        .copyWith(
                                                            color: ColorApp
                                                                .darkBlack,
                                                            fontSize: 10),
                                                  ),
                                                  Text(
                                                    socialController
                                                        .data[index]!
                                                        .socialDate!
                                                        .substring(0, 10),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displaySmall!
                                                        .copyWith(
                                                            color: ColorApp
                                                                .lightBlack,
                                                            fontSize: 8),
                                                  )
                                                ],
                                              ),
                                            ),
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
                                            setState(() {
                                              datas = {
                                                ...datas,
                                                socialController.urls[index]:
                                                    data,
                                              };
                                            });
                                          },

                                          previewData: datas[
                                              socialController.urls[index]],
                                          text: socialController.urls[index],
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
                                          IconButton(
                                            onPressed: () async {
                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              bool isLiked = prefs.getBool(
                                                      'like_${index}') ??
                                                  false;
                                              setState(() {
                                                isLiked = !isLiked;
                                                prefs.setBool(
                                                    'like_${index}', isLiked);
                                                socialController
                                                    .updateSocialRate(
                                                        index, isLiked);
                                              });
                                            },
                                            icon: NeumorphicIcon(
                                              socialController
                                                      .isLikedList[index]
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,size: 30,
                                              style: NeumorphicStyle(
                                                color: socialController
                                                        .isLikedList[index]
                                                    ? ColorApp.lightRed
                                                    : ColorApp.lightBlack,depth: 2
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "${
                                                socialController.formatSocialRate( socialController.data[index].socialRate!)
                                            } ",
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
 IconButton(
                                                  onPressed: () async {
                                                    setState(() {
                                                      socialController
                                                          .deleteMySocial(
                                                          index);
                                                    });


                                                  },
                                                  icon: NeumorphicIcon(
                                                    Icons.backspace_outlined,
                                                    style: NeumorphicStyle(
                                                      color:
                                                          ColorApp.lightBlack,
                                                    ),
                                                  ),
                                                ),
                                               NeumorphicButton(
                                            style: NeumorphicStyle(boxShape: NeumorphicBoxShape.circle()),
                                              onPressed: () {
                                                showRatingReport(context,socialController.data[index]!
                                                    .socialId);
                                              },
                                              child:  Text(
                                                 "Report".tr,
                                                style:Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 10,color: ColorApp.lightBlack ,),
                                              ))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),

                        ),

                        ]
                        ),
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class TextFileShare extends StatelessWidget {
  final Key formKey;
  final TextEditingController shareUrl;

  final void Function()? onPressed;

  TextFileShare(
      {Key? key,
      required this.formKey,
      required this.shareUrl,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      child: Container(
        decoration: BoxDecoration(
          color: ColorApp.bgMain,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: EdgeInsets.all(20),
        child: Form(
          key: formKey,
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
                    return validinput(val!, 1, 1000, "url");
                  },
                  controller: shareUrl,
                  decoration: InputDecoration(
                    labelText: "ShareURL".tr,
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
                onPressed: onPressed,
                child: Text("Share".tr),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyFilter extends StatelessWidget {
  final void Function(String)? onSelected;

  const MyFilter({Key? key, required this.onSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        tooltip: "filter",
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
        position: PopupMenuPosition.under,
        child: Image.asset(
          'assets/images/filter.png',
          width: 30,
        ),
        color: ColorApp.bgMain,
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              value: "All",
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'All'.tr,
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(color: ColorApp.darkBlack, fontSize: 12),
                  ),
                  Image.asset(
                    'assets/images/all.png',
                    width: 30,
                  ),
                ],
              ),
            ),
            PopupMenuItem(
              value: "Me",
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Me'.tr,
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(color: ColorApp.darkBlack, fontSize: 12),
                  ),
                  Image.asset(
                    'assets/images/my.png',
                    width: 30,
                  ),
                ],
              ),
            ),
          ];
        },
        onSelected: onSelected);
  }
}




void showRatingReport(BuildContext context, socialId) {

  showDialog(
    context: context,
    barrierDismissible: true, // set to false if you want to force a rating
    builder: (context) => RatingDialog(
      initialRating: 1.0,
      // your app's name?
      title: Text(
        'SMC Report'.tr,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.displaySmall!.copyWith(
          fontSize: 18,
          color: ColorApp.darkBlack,
        ),
      ),
      // encourage your user to leave a high rating?
      message: Text("ratingReportBody".tr,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
            fontSize: 13,
            color: ColorApp.lightBlack,
          )),
      // your app's logo?
      // image: const FlutterLogo(size: 100),
      starColor: Colors.transparent,

      starSize: 0,
      submitButtonText: 'Submit'.tr,
      submitButtonTextStyle: Theme.of(context).textTheme.displaySmall!,
      commentHint: 'commentReport'.tr,
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) {
        print(' comment: ${response.comment}');
        SocialController socialController = Get.find();
        socialController.submitRatingfromcontroller(
            socialId, response.comment);
      },
    ),
  );
}
