class CardInfoModel {
  String goodsId;
  String goodsName;
  int count;
  double price;
  String images;
  bool isCheck;

  CardInfoModel(
      {this.goodsId, this.goodsName, this.count, this.price, this.images});

  CardInfoModel.fromJson(Map<String, dynamic> json) {
    goodsId = json['goodsId'];
    isCheck = json['isCheck'];
    goodsName = json['goodsName'];
    count = json['count'];
    price = json['price'];
    images = json['images'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['goodsId'] = this.goodsId;
    data['goodsName'] = this.goodsName;
    data['count'] = this.count;
    data['price'] = this.price;
    data['images'] = this.images;
    data['isCheck'] = this.isCheck;
    return data;
  }
}