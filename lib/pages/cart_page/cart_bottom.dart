import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../provide/cart.dart';


class CartBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      color: Colors.white,
      child: Provide<CartProvide>(
        builder:(context,child,childCategory) {
          return Row(
        children: <Widget>[
          selectAction(context),
          allPriceArea(context),
          goButton(context),
        ],
      );
        },
      ),
    );
  }

  Widget selectAction(BuildContext context) {
    bool isAllcheck = Provide.value<CartProvide>(context).isAllcheck;
    return Container(
      child: Row(
        children: <Widget>[
          Checkbox(
            value: isAllcheck,
            activeColor: Colors.pink,
            onChanged: (bool val) {
              Provide.value<CartProvide>(context).changeAllCheckBtnState(val);
            },
          ),
          Text('全选')
        ],
      ),
    );
  }

  Widget allPriceArea(BuildContext context) {
    double allPrice = Provide.value<CartProvide>(context).allPrice;
    return Container(
      width: ScreenUtil().setWidth(430),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(280),
                child: Text(
                  '合计：',
                  style: TextStyle(fontSize: ScreenUtil().setSp(36)),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: ScreenUtil().setWidth(150),
                child: Text(
                  '¥${allPrice}',
                  style: TextStyle(
                      color: Colors.red, fontSize: ScreenUtil().setSp(36)),
                ),
              ),
            ],
          ),
           Container(
             padding: EdgeInsets.only(right: 5.0),
                alignment: Alignment.bottomRight,
                width: ScreenUtil().setWidth(430),
                child: Text(
                  '满10元免费配送,预购免配送费',
                  style: TextStyle(
                      color: Colors.black38, fontSize: ScreenUtil().setSp(22)),
                ),
             ),
        ],
      ),
    );
  }

  Widget goButton(BuildContext context) {
    int allGoodsCount  = Provide.value<CartProvide>(context).allGoodsCount;
    return Container(
      alignment: Alignment.center,
      width: ScreenUtil().setWidth(160),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(3.0),
      ),
      child: Text(
        '结算（${allGoodsCount}）',
        style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(26)),
      ),
    );
  }
}
