import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import '../../Controller/Home/basicScreenController.dart';
import '../../Core/Constant/color.dart';
import 'dart:math' as math;

class SlidingCardView extends StatefulWidget {
  const SlidingCardView({Key? key}) : super(key: key);

  @override
  State<SlidingCardView> createState() => _SlidingCardViewState();
}

class _SlidingCardViewState extends State<SlidingCardView> {
  late PageController pageController;
  BasicScreenController basicScreenController =
      Get.put(BasicScreenController());
  List title = [
    "Body Building",
    "Yoga",
    "Zumba",
  ];
  List imagX = [
    "assets/images/ex.png",
    "assets/images/yoga.png",
    "assets/images/zumba.png",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController(viewportFraction: 0.8);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 150,
      color: ColorApp.darkRed,
      child: PageView.builder(
          clipBehavior: Clip.none,
          controller: pageController,
          itemCount: title.length,
          itemBuilder: (context, index) {
            return AnimatedBuilder(
                animation: pageController,
                builder: (context, child) {
                  double pageOffset = 0;
                  if (pageController.position.haveDimensions) {
                    pageOffset = pageController.page! - index;
                  }
                  double gauss =
                      math.exp(-(math.pow(pageOffset.abs() - 0.5, 2) / 0.08));
                  return Transform.translate(
                      offset: Offset(-32 * gauss * pageOffset.sign, 0),
                      child: Neumorphic(
                        margin: EdgeInsets.only(
                            top: 10, bottom: 10, left: 0, right: 50),
                        child: Column(
                          children: [
                            ClipRect(
                              child: Container(
                                padding: EdgeInsets.all(5),
                                child: Image.asset(
                                  imagX[index],
                                  width: 40,
                                  color: basicScreenController.selectCourse ==
                                          false
                                      ? ColorApp.lightBlack
                                      : ColorApp.darkRed,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                                child: Card(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  NeumorphicCheckbox(
                                    style: NeumorphicCheckboxStyle(
                                        selectedColor: ColorApp.middleRed),
                                    value: basicScreenController.selectCourse,
                                    onChanged: (v) {
                                      print("object    $v");
                                      basicScreenController.selectCourse =
                                          basicScreenController.selectCourse ==
                                                  false
                                              ? true
                                              : false;

                                      setState(() {});
                                    },
                                  ),
                                  Text(
                                    "${title[index]}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall,
                                  )
                                ],
                              ),
                            ))
                          ],
                        ),
                      ));
                });
          }),
    );
  }
}
