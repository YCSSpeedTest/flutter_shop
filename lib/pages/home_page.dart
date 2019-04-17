import 'package:flutter/material.dart';
import 'package:dio/src/dio.dart';


class homePage extends StatefulWidget {
  final Widget child;

  homePage({Key key, this.child}) : super(key: key);

  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  TextEditingController typeController = TextEditingController();
  String show_text = '欢迎您';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('天上人间'),
      ),
      body: SingleChildScrollView(
        child: 
      Container(
        child: Column(
          children: <Widget>[
            TextField(
              controller: typeController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                labelText: '美女类型',
                helperText: '请输入类型',
              ),
              autofocus: false,
            ),
            RaisedButton(
              onPressed: _choiseAction,
              
              child: Text('选择完毕'),
            ),
            Text(
              show_text,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ),
      ),
    );
  }

  void _choiseAction() {
    print('被执行......');
    if (typeController.text.toString() == '') {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('不能唯恐'),
              ));
    } else {
      getHttp(typeController.text.toString()).then((val) {
        setState(() {
          show_text = val['data']['name'].toString();
        });
      });
    }
  }

  Future getHttp(String typText) async {
    try {
      
      Response response;
      var data = {'name': typText};
      response = (await Dio().get(
          'https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian',
          queryParameters: data)) as Response;
      return response.data;
    } catch (e) {
      print(e);
    }
  }
}

class Response {
  Future get data => null;
}
