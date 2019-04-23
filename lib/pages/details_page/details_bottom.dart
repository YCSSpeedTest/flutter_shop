import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../provide/details_info.dart';
import '../../provide/cart.dart';
import '../../provide/currentIndex.dart';

class DetailsBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodsInfo = Provide.value<DetailsInfoProvide>(context).goodsInfo.data.goodInfo;
     var goodsId = goodsInfo.goodsId;
     var goodsName = goodsInfo.goodsName;
     var count = 1;
     var price = goodsInfo.presentPrice;
     var image = goodsInfo.image1;

    return Container(
      height: ScreenUtil().setHeight(80),
      width: ScreenUtil().setWidth(750),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          InkWell(
              onTap: () {
                  Provide.value<CurrentIndexProvide>(context).changeIndex(2);
    Navigator.pop(context);
              },
              child: Container(
                width: ScreenUtil().setWidth(110),
                alignment: Alignment.center,
                child: Icon(
                  Icons.shopping_cart,
                  size: 35,
                  color: Colors.red,
                ),
              )),
          InkWell(
            onTap: () async{
          await Provide.value<CartProvide>(context).save(goodsId, goodsName, count, price, image);

            },
            child: Container(
              width: ScreenUtil().setWidth(320),
              alignment: Alignment.center,
              color: Colors.green,
              height: ScreenUtil().setHeight(80),
              child: Text(
                '加入购物车',
                style: TextStyle(
                    color: Colors.white, fontSize: ScreenUtil().setSp(28)),
              ),
            ),
          ),
          InkWell(
            onTap: () async{
              await Provide.value<CartProvide>(context).remove();
            },
            child: Container(
              width: ScreenUtil().setWidth(320),
              alignment: Alignment.center,
              color: Colors.red,
              height: ScreenUtil().setHeight(80),
              child: Text(
                '立即购买',
                style: TextStyle(
                    color: Colors.white, fontSize: ScreenUtil().setSp(28)),
              ),
            ),
          )
        ],
      ),
    );
  }
}