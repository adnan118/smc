import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../../Core/Constant/color.dart';

class MyStepper extends StatefulWidget {
  final String img1;
  final String title1;
  final String content1;

  final String img2;
  final String title2;
  final String content2;

  final String img3;
  final String title3;
  final String content3;
  final StepperType stepperTypex;

  const MyStepper({
    Key? key,
    required this.img1,
    required this.title1,
    required this.content1,
    required this.img2,
    required this.title2,
    required this.content2,
    required this.img3,
    required this.title3,
    required this.content3,
    required this.stepperTypex,
  }) : super(key: key);

  @override
  State<MyStepper> createState() => _MyStepperState();
}

class _MyStepperState extends State<MyStepper> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        colorScheme:
            Theme.of(context).colorScheme.copyWith(primary: ColorApp.darkRed),
      ),
      child: Stepper(
        elevation: 0,
        physics: NeverScrollableScrollPhysics(),
        steps: [
          ///////
          Step(
            state: _currentStep <= 0 ? StepState.indexed : StepState.complete,
            isActive: _currentStep == 0,
            title: Neumorphic(
              child: Image.asset(
                widget.img1,
                width: 50,
                color: _currentStep != 0 ? Colors.grey : null,
              ),
            ),
            content: Neumorphic(
                child: ListTile(
              title: Text(
                widget.title1,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: ColorApp.darkBlack, fontSize: 12),
              ),
              subtitle: Text(
                widget.content1,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: ColorApp.lightBlack, fontSize: 11),
              ),
            )),
          ),
          /////
          Step(
            state: _currentStep <= 1 ? StepState.indexed : StepState.complete,
            isActive: _currentStep == 1,
            title: Neumorphic(
              child: Image.asset(
                widget.img2,
                width: 50,
                color: _currentStep != 1 ? Colors.grey : null,
              ),
            ),
            content: Neumorphic(
                child: ListTile(
              title: Text(
                widget.title2,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: ColorApp.darkBlack, fontSize: 12),
              ),
              subtitle: Text(
                widget.content2,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: ColorApp.lightBlack, fontSize: 11),
              ),
            )),
          ),
          Step(
              state: _currentStep <= 2 ? StepState.indexed : StepState.complete,
              isActive: _currentStep == 2,
              title: Neumorphic(
                child: Image.asset(
                  widget.img3,
                  width: 50,
                  color: _currentStep != 2 ? Colors.grey : null,
                ),
              ),
              content: Neumorphic(
                child: ListTile(
                  title: Text(
                    widget.title3,
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(color: ColorApp.darkBlack, fontSize: 12),
                  ),
                  subtitle: Text(
                    widget.content3,
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(color: ColorApp.lightBlack, fontSize: 11),
                  ),
                ),
              )),
        ],
        onStepTapped: (int newIndex) {
          setState(() {
            _currentStep = newIndex;
          });
        },
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep != 2) {
            setState(() {
              _currentStep += 1;
            });
          }
        },
        onStepCancel: () {
          if (_currentStep != 0) {
            setState(() {
              _currentStep -= 1;
            });
          }
        },
        type: widget.stepperTypex,
      ),
    );
  }
}
