import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter_shop/config/service_url.dart';

//获取首页主题内容

Future request(url,{formData}) async {
  try {
    print('开始获取首页数据.....');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded");
      if (formData==null) {
         response = await dio.post(servicePath[url], data: formData);
        
      } else {
     
    response = await dio.post(servicePath[url], data: formData);
      }
    

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口出现异常。');
    }
  } catch (e) {
    return print('ERROR: =========#${e}');
  }
}


