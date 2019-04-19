import 'package:flutter/material.dart';
import '../service/service_url.dart';
import 'dart:convert';
import '../model/category.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../provide/child_category.dart';
import '../model/categoryGoods.dart';


class categoryPage extends StatefulWidget {
  @override
  _categoryPageState createState() => _categoryPageState();
}

class _categoryPageState extends State<categoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品分类'),
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCatgegrNav(),
            Column(
              children: <Widget>[
                RightCatetoryNav(),
                CategoryGoodsList(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

//左侧大类导航
class LeftCatgegrNav extends StatefulWidget {
  @override
  _LeftCatgegrNavState createState() => _LeftCatgegrNavState();
}

class _LeftCatgegrNavState extends State<LeftCatgegrNav> {
  List list = [];
  var listIndex=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(width: 1, color: Colors.black12),
        ),
      ),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return _leftInkWell(index);
        },
      ),
    );
  }

  Widget _leftInkWell(int index) {
    bool isClick = false;
    isClick = (index == listIndex)?true:false;
    
    return InkWell(
      onTap: () {
        setState(() {
          listIndex = index;
        });
        var childList = list[index].bxMallSubDto;
        Provide.value<ChildCategory>(context).getChildCategory(childList);
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10, top: 20),
        decoration: BoxDecoration(
          color:isClick? Color.fromRGBO(236, 236, 236, 1.0):Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12)),
        ),
        child: Text(
          list[index].mallCategoryName,
          style: TextStyle(fontSize: ScreenUtil().setSp(28)),
        ),
      ),
    );
  }

  void _getCategory() async {
    await request('getCategory').then((val) {
      var data = jsonDecode(val.toString());
      CategoryModel categoryList = CategoryModel.fromJson(data);
      setState(() {
        list = categoryList.data;
      });
      Provide.value<ChildCategory>(context).getChildCategory(list[0].bxMallSubDto);
    });
  }
}


//头部导航
class RightCatetoryNav extends StatefulWidget {
  @override
  _RightCatetoryNavState createState() => _RightCatetoryNavState();
}

class _RightCatetoryNavState extends State<RightCatetoryNav> {
  
  @override
  Widget build(BuildContext context) {
    
    return Provide<ChildCategory>(
     builder: (context,child,childCategory){
       return Container(
      height: ScreenUtil().setHeight(80),
      width: ScreenUtil().setWidth(570),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(width: 1, color: Colors.white24)),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: childCategory.childCategroyList.length,
        itemBuilder: (BuildContext context, int index) {
          return _rightInkWell(childCategory.childCategroyList[index]);
        },
      ), 
    );
     },
    ); 
  }

  Widget _rightInkWell(BxMallSubDto item) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        child: Text(
          item.mallSubName,
          style: TextStyle(fontSize: ScreenUtil().setSp(28)),
        ),
      ),
    );
  }
}

//商品列表，可以上拉加载效果
class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {
  @override
  void initState() {
    // TODO: implement initState
    _getGoodsList();

    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('商品列表'),
    );
  }

  void _getGoodsList() async {
    var data = {'categoryId':"4",'categorySubId':'','page':1};
    await request('getMallGoods',formData: data).then((val){
      var data = jsonDecode(val.toString());
    CategoryGoodsListModel goodList = CategoryGoodsListModel.fromJson(data);
    print('============${goodList.data[0].goodsName}');
    });

  }
}