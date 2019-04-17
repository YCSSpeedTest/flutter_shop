
import 'package:flutter/material.dart';
//ios风格
import 'package:flutter/cupertino.dart';
import 'cart_page.dart';
import 'home_page.dart';
import 'category_page.dart';
import 'rember_page.dart';



class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final List<BottomNavigationBarItem>bottomTabs = [
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.home),
      title: Text('首页')
    ),
     BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.search),
      title: Text('分类')
    ),
     BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.shopping_cart),
      title: Text('购物车')
    ),
     BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.profile_circled),
      title: Text('会员中心')
    ),

  ];

  final List tabBodies = [
    homePage(),
    categoryPage(),
    cartPage(),
    remberPge(),
    ];
    int currentIndex = 0;
    var currentPage;


    @override
  void initState() {
    currentPage =tabBodies[0];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: bottomTabs,
        onTap: (index) {
          setState(() {
            currentIndex =index;
            currentPage =tabBodies[index];
          });
        },
      ),
      body: currentPage,
          );
  }
}