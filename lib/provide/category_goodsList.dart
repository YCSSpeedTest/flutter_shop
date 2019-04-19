import 'package:flutter/material.dart';
import 'package:flutter_shop/model/categoryGoods.dart';

class CategoryGoodsListModelProvide with ChangeNotifier {
  //全局可用
  List<CategoryListdata> goodsList = [];
   getGoodsList(List<CategoryListdata> list) {
    goodsList = list;
    notifyListeners();
  }
  getMoreList(List<CategoryListdata> list) {
    goodsList.addAll(list);
    notifyListeners();
  }
}
