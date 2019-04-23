import 'package:flutter/material.dart';
import '../model/detail.dart';
import '../service/service_url.dart';
import 'dart:convert';


class DetailsInfoProvide with ChangeNotifier {
  DetailsModel goodsInfo = null;
  bool isLeft = true;
  bool isRight = true;
 //tabbar切换
 changLeftAndRight(String changeState){
   if (changeState == 'left') {
     isLeft = true;
     isRight = false;
   } else if(changeState == 'right'){
     isLeft = false;
     isRight = true;
   }
   notifyListeners();
 }
  //从后台获取商品数据
  getGoodsInfo (String id) async{
    var formData = {
      'goodId':id,
    };
   await  request('getGoodDetilsById',formData: formData).then((val){
     var responseData = json.decode(val.toString());
     print(responseData);
     goodsInfo = DetailsModel.fromJson(responseData);
     notifyListeners();
    });
  }
}