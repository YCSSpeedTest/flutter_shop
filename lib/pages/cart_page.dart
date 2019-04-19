import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/count.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class cartPage extends StatelessWidget {
  final Widget child;

  cartPage({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Number(),
          IncreaseBtn(),
        ],
      ),
    );
  }
}


class Number extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(margin: EdgeInsets.all(30),
    padding: EdgeInsets.all(20),
    child: Center(
      child: Provide<Count>(
        builder: (context,child,counter){
      return Text(
        '${counter.value}');
        },
      ) 
    ),
    );
  }
}

class IncreaseBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: (){
      Provide.value<Count>(context).increase();
      },
      child: Text('点击'),
    );
  }
}

