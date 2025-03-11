import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/OnBoarding/onBoardingController.dart';
import '../../Core/Constant/color.dart';
import '../../Data/DataSource/Static/static.dart';

class CustomSliderBody extends GetView<OnBoardingControllerImp> {
  const CustomSliderBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
            physics: BouncingScrollPhysics(),
            controller: controller.pageController,
            onPageChanged: (val) {
              controller.onPageChanged(val);
              print(val);
            },
            itemCount: onBoardingModelList.length,
            itemBuilder: (context, i) => Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(onBoardingModelList[i].title!,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: ColorApp.darkBlack)),
                    Image.asset(
                      onBoardingModelList[i].image!,
                      width: 300,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      child: Text(onBoardingModelList[i].body!,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorApp.lightBlack)),
                    ),
                  ],
                )),

      ],
    );
  }
}
