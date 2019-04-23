import 'package:flutter/material.dart';
import 'package:flutter_shop/provide/details_info.dart';
import 'package:provide/provide.dart';
import 'details_page/detail_explain.dart';
import 'details_page/details_top.dart';
import 'details_page/details_tabbar.dart';
import 'details_page/details_web.dart';
import 'details_page/details_bottom.dart';
class DetailsPage extends StatelessWidget {
  final String goodsId;
  DetailsPage(this.goodsId);
  @override
  Widget build(BuildContext context) {
    _getBackInfo(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
           Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('商品详细页'),
      ),
      body: FutureBuilder(
        future: _getBackInfo(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
          return Stack(
            children: <Widget>[
              Container(
            child: ListView(children: <Widget>[
              DetailsTopArea(),
              DetailsExplain(),
              DetailsTabBar(),
              DetailsWeb(),
            ],),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: DetailsBottom(),
          )
            ],
          ) ;
          } else {
            return Text('加载中');
          }
          
        },
      ),
    );
  }

  Future _getBackInfo(BuildContext context)async {
    await Provide.value<DetailsInfoProvide>(context).getGoodsInfo(goodsId);
   return '完成加载';
      
    
  }
}