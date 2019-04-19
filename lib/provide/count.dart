import 'package:flutter/material.dart';

class Count with ChangeNotifier {  //全局可用
  int value = 0;
  increase(){
    value++;
    notifyListeners(); //通知听众
    
  }

}