import 'package:flutter/material.dart';

import '../../Core/Constant/color.dart';

class InfoSport extends StatelessWidget {
  const InfoSport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
          color: ColorApp.bgMain,
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                "assets/images/zumba.png",
                width: 130,
                color: ColorApp.darkBlack,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Sport-ID : ",
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(
                            color: ColorApp.lightBlack, fontSize: 12),
                      ),
                      Text(
                        "123456",
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(color: ColorApp.blue, fontSize: 11),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Sport-Name : ",
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(
                            color: ColorApp.lightBlack, fontSize: 12),
                      ),
                      Text(
                        "Zumba",
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(color: ColorApp.blue, fontSize: 11),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Period on : ",
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(
                            color: ColorApp.lightBlack, fontSize: 12),
                      ),
                      Text(
                        "13:30 - 16:00 ",
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(color: ColorApp.blue, fontSize: 11),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Fee : ",
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(
                            color: ColorApp.lightBlack, fontSize: 12),
                      ),
                      Text(
                        "15 \$ per month",
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(color: ColorApp.blue, fontSize: 11),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),

        ],
      ),
    );
  }
}
