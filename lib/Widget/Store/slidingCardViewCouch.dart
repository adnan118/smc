
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import '../../Controller/Home/basicScreenController.dart';
import '../../Core/Constant/color.dart';

class SlidingCardViewCouch extends StatelessWidget {
  const SlidingCardViewCouch({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    late PageController pageController;
    BasicScreenController basicScreenController =
    Get.put(BasicScreenController());
    List title = [
      "Alex",
      "Elias",
      "Amanta",
      "Dany",
    ];
    List imagX = [
      "assets/images/avatar5.jpg",
      "assets/images/avatar5.jpg",
      "assets/images/avatar5.jpg",
      "assets/images/avatar5.jpg",
    ];
    return Container(
        width: 100,
        height: 150,
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: ListView.separated(
          separatorBuilder:(context, index) {
            return SizedBox(width: 15,);
          },
            clipBehavior: Clip.none,
scrollDirection:Axis.horizontal ,
            itemCount: title.length,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ClipRect(

                    child: PhysicalModel(
                      elevation: 0,
                      clipBehavior: Clip.hardEdge,
                      shape: BoxShape.circle,
                      child: Image.asset(
                        imagX[index],
                        width: 90,
                      ),
                      shadowColor: ColorApp.lightBlack,
                      color: ColorApp.green,
                    ),
                  ),

                  Center(child: Text(
                    "${title[index]}",       style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(color: ColorApp.lightBlack, fontSize: 14),
                  ),)
                ],
              );
            }));
  }
}


