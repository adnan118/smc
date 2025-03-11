import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Core/Services/services.dart';
import '../../DB/handlingData.dart';
import '../../DB/statusRequest.dart';
import '../../Data/DataSource/Remote/statusRemoteData.dart';

class StatusController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  Myservices myservices = Get.find();
  String imgMode = 'assets/lottie/Break.json';
  String titleMode = 'UnKnown';
  int visiableBlur = 0;
  bool clickToStart = false;
  bool counterStart = false;

  StatusRemoteData statusRemoteData = StatusRemoteData(Get.find());
  var timeTraining = Duration.zero;
  var timeSleep = Duration.zero;
  var timeBreak = Duration.zero;

  DateTime? startTime;
  DateTime? endTime;
  String? currentMode;
  Timer? _timer;

  @override
  void onInit() {
    _loadLastState();
    super.onInit();
  }

  @override
  void onClose() {
    _saveCurrentState();
    _timer?.cancel();
    super.onClose();
  }

  void startTiming(String mode) {
    if (currentMode != null && currentMode != mode) {
      var duration = DateTime.now().difference(startTime!);
      if (currentMode == "Training") {
        timeTraining += duration;
      } else if (currentMode == "Sleep") {
        timeSleep += duration;
      } else if (currentMode == "Break") {
        timeBreak += duration;
      }
    }

    startTime = DateTime.now();
    currentMode = mode;
    _saveCurrentState(); // Save the current state
    _startTimer();
  }

  void stopTiming() {
    if (currentMode != null) {
      var duration = DateTime.now().difference(startTime!);
      if (currentMode == "Training") {
        timeTraining += duration;
      } else if (currentMode == "Sleep") {
        timeSleep += duration;
      } else if (currentMode == "Break") {
        timeBreak += duration;
      }
      endTime = DateTime.now();
      saveStatus(endTime);
      endTime = null;
      startTime = null;
      currentMode = null;
      _saveCurrentState(); // Save the current state
      _timer?.cancel();

      update();
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      update();
    });
  }

  String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;
    return "$hours h - $minutes m - $seconds s";
  }
  String getCurrentModeDuration() {
    Duration duration =timeTraining-timeTraining;
    if (currentMode == "Training") {
      duration = timeTraining + (DateTime.now().difference(startTime!));
    } else if (currentMode == "Sleep") {
      duration = timeSleep + (DateTime.now().difference(startTime!));
    } else if (currentMode == "Break") {
      duration = timeBreak + (DateTime.now().difference(startTime!));
    } else {
      return "0 h - 0 m - 0 s";
    }

    return formatDuration(duration);
  }





  void _saveCurrentState() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('currentMode', currentMode ?? "Break");
    prefs.setInt(
        'startTime',
        startTime?.millisecondsSinceEpoch ??
            DateTime.now().millisecondsSinceEpoch);
  }

  void _loadLastState() async {
    final prefs = await SharedPreferences.getInstance();
    currentMode = prefs.getString('currentMode') ?? "Break";
    titleMode = currentMode!;

    int? startTimeMillis = prefs.getInt('startTime');

    if (currentMode == "Training") {
      imgMode = 'assets/lottie/Training.json';
    } else if (currentMode == "Sleep") {
      imgMode = 'assets/lottie/Sleep.json';
    } else if (currentMode == "Break") {
      imgMode = 'assets/lottie/Break.json';
    } else {
      imgMode = 'assets/lottie/Sleep.json';
    }

    if (startTimeMillis != null) {
      startTime = DateTime.fromMillisecondsSinceEpoch(startTimeMillis);
    } else {
      startTime = DateTime.now();
      endTime = DateTime.now();
    }

    _startTimer();
    update();
  }

  rf() {
    update();
  }

  //==================================
  @override
  saveStatus(endTime) async {


    var response = await statusRemoteData.setStatus(
        myservices.sharedPref.getInt("users_id").toString()!,
        currentMode.toString(),
        startTime.toString(),
        endTime.toString(),
        true.toString());
    print("$response *****");
    print(endTime);
    print(startTime.toString());
    //
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        print("Done save *****");
      } else {
        statusRequest = StatusRequest.failuer;
      }
    }
    update();
  }
}
