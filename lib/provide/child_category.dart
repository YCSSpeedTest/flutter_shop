import 'package:flutter/material.dart';
import 'package:flutter_shop/model/category.dart';

class ChildCategory with ChangeNotifier {  //全局可用
  List <BxMallSubDto> childCategroyList = [];
  getChildCategory(List<BxMallSubDto> list){
    BxMallSubDto all = BxMallSubDto();
    all.mallSubId = '00';
    all.mallCategoryId = '00';
    all.comments = 'null';
    all.mallSubName = '全部';
    childCategroyList = [all];
    childCategroyList.addAll(list);
    notifyListeners(); //通知听众
    
  }

}