import 'dart:io';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dartz/dartz.dart';
import '../Core/Function/checkInternet.dart';
import 'statusRequest.dart';

class CRUD {
//GET
  getRequest(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        //page  founded
        var resonserbody =
        jsonDecode(response.body); //convert contain  jason to dart
        return resonserbody;
      } else {
        print("Error requesr :: ${response.statusCode}");
      }
    } catch (e) {
      print("Error Source Code  :: ${e}");
    }
  }

/////////POST

  Future<Either<StatusRequest, Map>> postData(String url, Map data) async {

    //map is right
    //statusRequest is left
    try {
      if (await checkInternet()) {
        Uri path = Uri.parse(url);
        var response = await http.post(path, body: data);

        if (response.statusCode == 200) {
          Map resonserbody = jsonDecode(response.body);
          return Right(resonserbody);
        } else {
          return Left(StatusRequest.serverfailuer);
        }
      } else {
        return const Left(StatusRequest.offinternetfailuer);
      }
    } catch (_) {
      return const Left(StatusRequest.serverExption);
    }
  }
//CRUD

////لايمكن استعمال البوست لاستقبال الملفات والصور لذا نقوم ببناء التوابع التالية
//MultipartRequest
    postRequestWithFile(String url, Map data, File file) async {
      var request =
      await http.MultipartRequest("POST", Uri.parse(url));

      var length = await file.length(); //path of file
      var stream = http.ByteStream(file.openRead());
      var multipartFile = http.MultipartFile(
        "file",
        stream,
        length,
        filename: basename(file.path), //تجلب اسم الملف مع اللاحقة
      );

      request.files.add(multipartFile); //تحميل الملف على السيرفر
      //ارسال الملفات مع البيانات
      data.forEach((key, value) {
        request.fields[key] = value;
      });

      var myrequest = await request.send();

      var response = await http.Response.fromStream(myrequest);
      if (myrequest.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print("Errore ${myrequest.statusCode}");
      }
    }
  }
