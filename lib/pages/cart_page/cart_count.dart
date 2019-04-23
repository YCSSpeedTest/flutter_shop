import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../provide/cart.dart';
import 'package:provide/provide.dart';

class CartCount extends StatelessWidget {
  var item;
  CartCount(this.item);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(165),
      margin: EdgeInsets.only(top: 5.0),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.black12
        )
      ),
      child: Row(
        children: <Widget>[
         _reduceBtn(context,item),
        
         _count (),
          _addBtn(context,item),
        ],
      ),
      
    );
  }

  //-
  Widget _reduceBtn(BuildContext context,item){
    return InkWell(
      onTap: (){
     Provide.value<CartProvide>(context).addOrReduceAction(item,'reduce');
      },
      child:Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color:item.count>1?Colors.white:Colors.black12,
          border: Border(
            right: BorderSide(
              width: 1,
              color: Colors.black12
            )
          )
        ),
        child: Text(item.count>1?'-':'',),
      ) ,
    );
  }

  //+
  Widget _addBtn(BuildContext context,item){
    return InkWell(
      onTap: (){
Provide.value<CartProvide>(context).addOrReduceAction(item,'add');
      },
      child:Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(
              width: 1,
              color: Colors.black12
            )
          )
        ),
        child: Text('+'),
      ) ,
    );
  }

  //数字区域
  Widget _count () {
    return Container(
        width: ScreenUtil().setWidth(70),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        color: Colors.white12,
        child: Text('${item.count}'),
    );
  }

}