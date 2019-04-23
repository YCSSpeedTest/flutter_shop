import 'package:flutter/material.dart';
import 'pages/index_page.dart';
import 'package:provide/provide.dart';
import 'provide/details_info.dart';
import './provide/count.dart';
import 'provide/child_category.dart';
import 'provide/category_goodsList.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_shop/routers/router.dart';
import 'package:flutter_shop/routers/application.dart';
import 'provide/cart.dart';
import './provide/currentIndex.dart';

void main() {
  var count = Count();
  var childCategory = ChildCategory();
  var category = CategoryGoodsListModelProvide();
  var detailsInfoProvide = DetailsInfoProvide();
  var currentIndexProvide = CurrentIndexProvide();
  var cartProvide = CartProvide();

  var provides = Providers();
  provides..provide(Provider<Count>.value(count));
  provides..provide(Provider<ChildCategory>.value(childCategory));
  provides..provide(Provider<CategoryGoodsListModelProvide>.value(category));
  provides..provide(Provider<DetailsInfoProvide>.value(detailsInfoProvide));
  provides..provide(Provider<CartProvide>.value(cartProvide));
  provides..provide(Provider<CurrentIndexProvide>.value(currentIndexProvide));
  runApp(ProviderNode(
    child: MyApp(),
    providers: provides,
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;

    return Container(
      child: MaterialApp(
        title: '百姓生活+',
        onGenerateRoute: Application.router.generator,
        //去掉bug
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.pink),
        home: IndexPage(),
      ),
    );
  }
}
