import 'package:ahlachat/core/utils/app_constance.dart';

class ItemsModel {
  int? id;
  String? name;
  String? svga;
  String? sound;
  String? image;
  int? price;
  int? kind;
  int? categoryId;
  int? days;
  ItemsModel(
      {this.id,
      this.name,
      this.price,
      this.svga,
      this.sound,
      this.image,
      this.kind,
      this.categoryId,
      this.days});

  ItemsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['transname'] ?? json['name'];
    svga = AppConstance.imageShopUrl(json['svga'] ?? json['svggift'] ?? '');
    sound =
        json['sound'] == null ? null : AppConstance.imageShopUrl(json['sound']);
    price = json['price'];
    kind = json['kind'];
    image = AppConstance.imageShopUrl(json['image'] ?? json['imagegift'] ?? "");
    categoryId = json['category_id'] ?? json['shopcategory_id'];
    days = json['day'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['transname'] = this.name;
    data['svga'] = this.svga;
    data['sound'] = this.sound;
    data['image'] = this.image;
    data['price'] = this.price;
    data['kind'] = this.kind;
    data['category_id'] = this.categoryId;
    data['day'] = this.days;
    return data;
  }
}
