import 'package:flutter/material.dart';

class cartPage extends StatelessWidget {
  final Widget child;

  cartPage({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('cart'),
    );
  }
}