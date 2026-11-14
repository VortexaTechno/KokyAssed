import 'package:ahlachat/gift/data/models/GiftCategoryModel.dart';
import 'package:ahlachat/shop/data/models/CategoryModel.dart';

import 'package:equatable/equatable.dart';

class SuccesMessageCategoryModel extends Equatable {
  bool? statusCode;
  int? errNum;
  String? statusMessage;
  List<GiftCategoryModel>? data;

  SuccesMessageCategoryModel(
      {this.statusCode, this.errNum, this.data, this.statusMessage});

  SuccesMessageCategoryModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status'];
    errNum = int.tryParse(json['errNum']?.toString() ?? '');
    statusMessage = json['message'] ?? json['msg'];

    final categories = json['data'] ?? json['category'];
    if (categories is List) {
      data = <GiftCategoryModel>[];
      categories.forEach((v) {
        data!.add(new GiftCategoryModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.statusCode;
    data['errNum'] = this.errNum;
    data['message'] = this.statusMessage;

    return data;
  }

  @override
  List<Object?> get props => [statusCode, statusMessage, errNum, data];
}
