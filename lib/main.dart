import 'package:flutter/material.dart';
import 'pages/index_page.dart';
import 'package:provide/provide.dart';
import './provide/count.dart';
import 'provide/child_category.dart';
import 'provide/category_goodsList.dart';
import 'package:fluro/fluro.dart';



void main(){
  var count = Count();
  var childCategory = ChildCategory();
  var category = CategoryGoodsListModelProvide();
   var provides = Providers();
  

   provides..provide(Provider<Count>.value(count));
   provides..provide(Provider<ChildCategory>.value(childCategory));
   provides..provide(Provider<CategoryGoodsListModelProvide>.value(category));
  runApp(ProviderNode(child: MyApp(),providers: provides,));
}

class MyApp extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: '百姓生活+',
        //去掉bug
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.pink
        ),
        home: IndexPage(),
      ),
    );
  }
}