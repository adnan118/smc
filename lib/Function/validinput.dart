
import 'package:get/get.dart';

validinput(String val,int min,int max,String type){
  if(val.isEmpty  ){
    return "vEmpty".tr;
  }

  //username
  if(type=="url"){
    if(!GetUtils.isURL(val)){
      return "vURL".tr;
    }
  }


  //username
  if(type=="username"){
    if(!GetUtils.isUsername(val)){
      return "vUsername".tr;
    }
  }
  //username
  if(type=="fullname"){
    if(val.length <min){
      return "vMin".tr+"$min";
    }

    if(val.length >max){
      return "vMax".tr+"$max";
    }
  }
  //email
  if(type=="email"){
    if(!GetUtils.isEmail(val)){
      return "vEmail".tr;
    }
  }

  //phone
  if(type=="phone"){
    if(!GetUtils.isPhoneNumber(val)){
      return "vPhone".tr;
    }
  }


///////////////////////
  if(val.length <min){
    return "vMin".tr+"$min";
  }

  if(val.length >max){
    return "vMax".tr+"$max";
  }
}
