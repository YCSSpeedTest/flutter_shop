import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../service/service_url.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  String homePageContent = '正在获取数据';


  @override
  Widget build(BuildContext context) {
    var formData = {"lon": "115.02932", 'lat': '35.76189'};
    return Scaffold(
      appBar: AppBar(
        title: Text('百姓生活'),
      ),
      body: FutureBuilder(
        future: request('homePageContent',formData),
        //initialData: InitialData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            var data = json.decode(snapshot.data.toString());
            print(data);
            List<Map> swiper = (data['data']['slides'] as List).cast();
            List<Map> navgation = (data['data']['category'] as List).cast();
            String adPicture =
                data['data']['advertesPicture']['PICTURE_ADDRESS'];
            String leaderIamge = data['data']['shopInfo']['leaderImage'];
            String phone = data['data']['shopInfo']['leaderPhone'];
            List<Map> recommendList =
                (data['data']['recommend'] as List).cast();
            String floortitle = data['data']['floor1Pic']['PICTURE_ADDRESS'];
            String floortitle2 = data['data']['floor2Pic']['PICTURE_ADDRESS'];
            String floortitle3 = data['data']['floor3Pic']['PICTURE_ADDRESS'];
            List<Map> floor1 = (data['data']['floor1'] as List).cast();
            List<Map> floor2 = (data['data']['floor2'] as List).cast();
            List<Map> floor3 = (data['data']['floor3'] as List).cast();

            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SwiperDiy(swiper),
                  TopNavigator(navgation),
                  AddBanner(adPicture),
                  LeaderPhone(leaderIamge, phone),
                  Recommend(recommendList),
                  Floor(floortitle),
                  FloorContent(floor1),
                  Floor(floortitle2),
                  FloorContent(floor2),
                  Floor(floortitle3),
                  FloorContent(floor3),
                ],
              ),
            );
          } else {
            return Center(
              child: Text(
                '加载中',
              ),
            );
          }
        },
      ),
    );
  }
}

//首页轮播组建
class SwiperDiy extends StatelessWidget {
  final List swiperDateList;
  SwiperDiy(this.swiperDateList);
  @override
  Widget build(BuildContext context) {
   
    print('设备像素密度：${ScreenUtil.pixelRatio}');
    print('设备像素密度：${ScreenUtil.screenHeight}');
    print('设备像素密度：${ScreenUtil.screenWidth}');
    var swiper = Swiper(
      itemBuilder: (BuildContext context, int index) {
        return Image.network('${swiperDateList[index]['image']}',
            fit: BoxFit.fill);
      },
      itemCount: 3,
      pagination: SwiperPagination(),
      autoplay: true,
    );
    return Container(
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: swiper,
    );
  }
}

class TopNavigator extends StatelessWidget {
  final List navigatorList;
  TopNavigator(this.navigatorList);
  Widget _gridViewItemUI(BuildContext context, item) {
    return InkWell(
      onTap: () {
        print('点击了导航');
      },
      child: Column(
        children: <Widget>[
          Image.network(
            item['image'],
            width: ScreenUtil().setWidth(95),
          ),
          Text(item['mallCategoryName']),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (this.navigatorList.length > 10) {
      this.navigatorList.removeRange(10, this.navigatorList.length);
    }
    return Container(
      height: ScreenUtil().setHeight(320),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        crossAxisCount: 5,
        padding: EdgeInsets.all(5.0),
        children: navigatorList.map((item) {
          return _gridViewItemUI(context, item);
        }).toList(),
      ),
    );
  }
}

class AddBanner extends StatelessWidget {
  final String adPicture;
  AddBanner(this.adPicture);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(adPicture),
    );
  }
}

//打电话

class LeaderPhone extends StatelessWidget {
  final String leaderImage;
  final String phone;
  LeaderPhone(this.leaderImage, this.phone);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: _launchURL,
        child: Image.network(leaderImage),
      ),
    );
  }

  void _launchURL() async {
    String url = 'tel' + phone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'url 不能进行访问';
    }
  }
}

//商品推荐类
class Recommend extends StatelessWidget {
  final List recommendList;
  Recommend(this.recommendList);
//标题
  Widget _titleWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10.0, 2.0, 0, 5.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 1, color: Colors.black12),
          )),
      child: Text(
        '商品推荐',
        style: TextStyle(color: Colors.pink),
      ),
    );
  }

//商品单独方法
  Widget _item(int index) {
    return InkWell(
        onTap: () {},
        child: Container(
          height: ScreenUtil().setHeight(340),
          width: ScreenUtil().setWidth(250),
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(left: BorderSide(width: 1, color: Colors.black12)),
          ),
          child: Column(
            children: <Widget>[
              Image.network(recommendList[index]['image']),
              Text('¥${recommendList[index]['mallPrice']}'),
              Text(
                '¥${recommendList[index]['price']}',
                style: TextStyle(
                    decoration: TextDecoration.lineThrough, color: Colors.grey),
              ),
            ],
          ),
        ));
  }

//横行列表方法
  Widget _recommendList() {
    return Container(
      height: ScreenUtil().setHeight(340),
      margin: EdgeInsets.only(top: 10.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommendList.length,
        itemBuilder: (BuildContext context, int index) {
          return _item(index);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: ScreenUtil().setHeight(430),
        margin: EdgeInsets.only(top: 10.0),
        child: Column(
          children: <Widget>[
            _titleWidget(),
            _recommendList(),
          ],
        ));
  }
}

//楼层标题
class Floor extends StatelessWidget {
  final String pictureAdress;
  Floor(this.pictureAdress);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Image.network(pictureAdress),
    );
  }
}

//楼���商品列表
class FloorContent extends StatelessWidget {
  final List floorGoodsList;
  FloorContent(this.floorGoodsList);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          _firstRow(),
          _otherGoods(),
        ],
      ),
    );
  }

  Widget _otherGoods() {
    return Row(
      children: <Widget>[
        _goodsItem(floorGoodsList[3]),
        _goodsItem(floorGoodsList[4]),
      ],
    );
  }

  Widget _firstRow() {
    return Row(
      children: <Widget>[
        _goodsItem(floorGoodsList[0]),
        Column(
          children: <Widget>[
            _goodsItem(floorGoodsList[1]),
            _goodsItem(floorGoodsList[2]),
          ],
        ),
      ],
    );
  }

  Widget _goodsItem(Map goods) {
    return Container(
      
      width: ScreenUtil().setWidth(355),
      child: InkWell(
        onTap: () {
          print('点击了商品');
        },
        child: Image.network(goods['image']),
      ),
    );
  }
}


class HotGoods extends StatefulWidget {
  @override
  _HotGoodsState createState() => _HotGoodsState();
}


class _HotGoodsState extends State<HotGoods> {
  @override
void initState() { 
  super.initState();
  request('homePageBelowContent', 1).then((val){
    print(val);
  });
}
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}
