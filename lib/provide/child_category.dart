import 'package:flutter/material.dart';
import 'package:flutter_shop/model/category.dart';

class ChildCategory with ChangeNotifier {  //全局可用
  int page = 0;  
  String noMoreText= '';//显示没有数据提示
  int childIndex = 0;//子类高亮索引
   String categoryId = '4'; //大类id
    String categorySubId = ''; //大类id
  //大类切换逻辑
  List <BxMallSubDto> childCategroyList = [];
  getChildCategory(List<BxMallSubDto> list,String id){
    page = 1;
    String noMoreText= '';
    categoryId = id;
    childIndex = 0;
    BxMallSubDto all = BxMallSubDto();
    all.mallSubId = '';
    all.mallCategoryId = '00';
    all.comments = 'null';
    all.mallSubName = '全部';
    childCategroyList = [all];
    childCategroyList.addAll(list);
    notifyListeners(); //通知听众
  }

  //改变子类索引
  changeChildIndex(index,String id){
    page = 1;
    String noMoreText= '';
    childIndex = index;
    categorySubId = id;
    notifyListeners();
  }

  //增加page方法
  addPage(){
    page++;
    notifyListeners();
  }

   changeNoMore(String text) {
     noMoreText= text;
     notifyListeners();
   }
}