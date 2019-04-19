import 'package:flutter/material.dart';
import '../service/service_url.dart';
import 'dart:convert';
import '../model/category.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../provide/child_category.dart';
import '../model/categoryGoods.dart';
import '../provide/category_goodsList.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  var listIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCategory();
    _getGoodsList();
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
    isClick = (index == listIndex) ? true : false;

    return InkWell(
      onTap: () {

        setState(() {
          listIndex = index;
        });
        var childList = list[index].bxMallSubDto;
        var categoryId = list[index].mallCategoryId;
        Provide.value<ChildCategory>(context).getChildCategory(childList,categoryId);
        _getGoodsList(categoryId: categoryId);
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10, top: 20),
        decoration: BoxDecoration(
          color: isClick ? Color.fromRGBO(236, 236, 236, 1.0) : Colors.white,
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
      Provide.value<ChildCategory>(context)
          .getChildCategory(list[0].bxMallSubDto,list[0].mallCategoryId);
    });
  }

  void _getGoodsList({String categoryId}) async {
    var data = {
      'categoryId': categoryId == null ? '4' : categoryId,
      'categorySubId': '',
      'page': 1
    };
    await request('getMallGoods', formData: data).then((val) {
      var data = jsonDecode(val.toString());
      CategoryGoodsListModel goodList = CategoryGoodsListModel.fromJson(data);

      Provide.value<CategoryGoodsListModelProvide>(context)
          .getGoodsList(goodList.data);
    });
  }
}

//二级导航
class RightCatetoryNav extends StatefulWidget {
  @override
  _RightCatetoryNavState createState() => _RightCatetoryNavState();
}

class _RightCatetoryNavState extends State<RightCatetoryNav> {
  @override
  Widget build(BuildContext context) {
    return Provide<ChildCategory>(
      builder: (context, child, childCategory) {

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
              return _rightInkWell(index, childCategory.childCategroyList[index]);
            },
          ),
        );
      },
    );
  }

  Widget _rightInkWell(int index,BxMallSubDto item) {
    bool isClick = false;
    isClick = (index == Provide.value<ChildCategory>(context).childIndex)?true:false;
    return InkWell(
      onTap: () {
       Provide.value<ChildCategory>(context).changeChildIndex(index,item.mallSubId);
       _getGoodsList(item.mallSubId);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        child: Text(
          item.mallSubName,
          style: TextStyle(fontSize: ScreenUtil().setSp(28),
          color: isClick?Colors.pink:Colors.black
          ),
        ),
      ),
    );
  }

   void _getGoodsList(String categorySubId) async {
    var data = {
      'categoryId': Provide.value<ChildCategory>(context).categoryId,
      'categorySubId':categorySubId,
      'page': 1
    };
    await request('getMallGoods', formData: data).then((val) {
      var data = jsonDecode(val.toString());
      CategoryGoodsListModel goodList = CategoryGoodsListModel.fromJson(data);
      if (goodList.data == null) {
         Provide.value<CategoryGoodsListModelProvide>(context)
          .getGoodsList([]);

      } else {
         Provide.value<CategoryGoodsListModelProvide>(context)
          .getGoodsList(goodList.data);
      }
     
    });
  }
}

//商品列表，可以上拉加载效果
class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {
   GlobalKey <RefreshFooterState>_footerkey = new GlobalKey<RefreshFooterState>();
   var scrollController = new ScrollController();
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListModelProvide>(
      builder: (context, child, data) {
        try{
          if (Provide.value<ChildCategory>(context).page==1) {
            //列表位置，放在最上面
           scrollController.jumpTo(0.0);
            
          } else {
          }
        }catch(e){
          print('进入页面第一次初始化：${e}');

        }
        if (data.goodsList.length>0) {
           return Expanded(
          child: 
          Container(
            width: ScreenUtil().setWidth(570),
            child: EasyRefresh(
               //自定义footer
               refreshFooter: ClassicsFooter(
                 bgColor: Colors.white,
                 textColor: Colors.pink,
                 moreInfoColor: Colors.pink,
                 showMore: true,
                 noMoreText: '',
                 moreInfo: Provide.value<ChildCategory>(context).noMoreText,
                 loadReadyText: '上拉加载',
                 key: _footerkey,
               ),
            child: ListView.builder(
              controller: scrollController,
              itemCount: data.goodsList.length,
              itemBuilder: (BuildContext context, int index) {
                return _goodsItem(data.goodsList, index);
              },
            ),
            loadMore: (){
              _getMoreGoodsList();
            },
            ),
          ),
        );
        } else {
          return Text('暂无数据');
        }
       
      },
    );
  }

   void _getMoreGoodsList() async {
    Provide.value<ChildCategory>(context).addPage();
    var data = {
      'categoryId': Provide.value<ChildCategory>(context).categoryId,
      'categorySubId':Provide.value<ChildCategory>(context).categorySubId,
      'page': Provide.value<ChildCategory>(context).page
    };
    await request('getMallGoods', formData: data).then((val) {
      var data = jsonDecode(val.toString());
      CategoryGoodsListModel goodList = CategoryGoodsListModel.fromJson(data);
      if (goodList.data == null) {
         Fluttertoast.showToast(
           msg: '已经到底了',
           toastLength: Toast.LENGTH_SHORT,
           gravity: ToastGravity.CENTER,
           backgroundColor: Colors.pink,
           textColor: Colors.white,
           fontSize: 16.0,
         );
         Provide.value<ChildCategory>(context).changeNoMore('没有更多了');
         // .getGoodsList([]);

      } else {
         Provide.value<CategoryGoodsListModelProvide>(context)
          .getMoreList(goodList.data);
      }
     
    });
  }

  Widget _goodsImage(List newList, int index) {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(newList[index].image),
    );
  }

  Widget _goodsName(List newList, int index) {
    return Container(
      padding: EdgeInsets.all(5.0),
      width: ScreenUtil().setWidth(370),
      child: Text(
        newList[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(28)),
      ),
    );
  }

  Widget _goodsprice(List newList, int index) {
    return Container(
        margin: EdgeInsets.only(top: 20.0),
        width: ScreenUtil().setWidth(370),
        child: Row(
          children: <Widget>[
            Text(
              '价格：¥${newList[index].presentPrice}',
              style: TextStyle(
                  color: Colors.pink, fontSize: ScreenUtil().setSp(38)),
            ),
            Text(
              '¥${newList[index].oriPrice}',
              style: TextStyle(
                  color: Colors.black26,
                  decoration: TextDecoration.lineThrough,
                  fontSize: ScreenUtil().setSp(38)),
            ),
          ],
        ));
  }

  Widget _goodsItem(List newList, int index) {
    return InkWell(
      onTap: () {
        
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 5.0, top: 5.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        child: Row(
          children: <Widget>[
            _goodsImage(newList, index),
            Column(
              children: <Widget>[
                _goodsName(newList, index),
                _goodsprice(newList, index),
              ],
            )
          ],
        ),
      ),
    );
  }
}
