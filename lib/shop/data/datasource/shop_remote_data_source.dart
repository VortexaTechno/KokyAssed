import 'dart:io';

import 'package:ahlachat/core/error/exceptions.dart';
import 'package:ahlachat/core/network/api_constance.dart';
import 'package:ahlachat/core/network/error_message_model.dart';
import 'package:ahlachat/core/network/succes_message_mine_model.dart';
import 'package:ahlachat/core/network/succes_message_model.dart';
import 'package:ahlachat/core/network/succes_message_shop_model.dart';
import 'package:ahlachat/core/utils/app_constance.dart';
import 'package:ahlachat/core/utils/helper.dart';
import 'package:ahlachat/users/data/models/FireBaseGoogleModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ahlachat/shop/data/models/ItemModel.dart';

abstract class BaseShopRemoteDataSource {
  Future<SuccesMessageShopModel> GetPackages();
  Future<SuccesMessageMineModel> GetMineItemPackage();

  Future<SuccesMessageShopModel> ByeItem({required ItemsModel item});
  Future<SuccesMessageShopModel> SendItem(
      {required int ItemId, required int UserId});
  Future<SuccesMessageModel> WearItem({required int SalesId});
  Future<SuccesMessageModel> UnWearItem({required int SalesId});
}

class ShopRemoteDataSource extends BaseShopRemoteDataSource {
  @override
  Future<SuccesMessageShopModel> GetPackages() async {
    final client = await DioInstance();

    final response = await client.get(ApiConstance.GetShopPackages);
    if (response.data is List) {
      final items = (response.data as List).whereType<Map>().toList();
      final categories = <int, List<Map>>{};
      for (final item in items) {
        final categoryId = int.tryParse(
              (item['shopcategory_id'] ?? item['category_id'] ?? 0).toString(),
            ) ??
            0;
        categories.putIfAbsent(categoryId, () => <Map>[]).add(item);
      }
      final categoryPayload = categories.entries.map((entry) {
        final kind = entry.value.isEmpty ? null : entry.value.first['kind'];
        return <String, dynamic>{
          'id': entry.key,
          'transname': kind == 0
              ? 'Entries'
              : kind == 1
                  ? 'Frames'
                  : 'Items',
          'items': entry.value,
        };
      }).toList();
      return SuccesMessageShopModel.fromJson(<String, dynamic>{
        'status': true,
        'package': <Map<String, dynamic>>[
          <String, dynamic>{
            'id': 1,
            'transname': 'Shop',
            'category': categoryPayload,
          }
        ],
      });
    }

    if (response.statusCode == 200) {
      return SuccesMessageShopModel.fromJson(response.data);
    } else {
      return SuccesMessageShopModel.fromJson(response.data);
    }
  }

  Future<SuccesMessageShopModel> ByeItem({required ItemsModel item}) async {
    FormData formData = FormData.fromMap({
      "item_id": item.id.toString(),
      "category_id": item.categoryId.toString(),
      "day": (item.days ?? 1).toString(),
      "price": item.price.toString(),
      "user_id": UserId.toString(),
    });
    final client = await DioInstance();

    final response =
        await client.post(ApiConstance.PurchaseItem, data: formData);

    if (response.statusCode == 200) {
      return SuccesMessageShopModel.fromJson(response.data);
    } else {
      return SuccesMessageShopModel.fromJson(response.data);
    }
  }

  @override
  Future<SuccesMessageShopModel> SendItem(
      {required int ItemId, required int UserId}) async {
    FormData formData = FormData.fromMap(
        {"item_id": ItemId.toString(), "user_id": UserId.toString()});
    final client = await DioInstance();

    final response = await client.post(ApiConstance.SendItem, data: formData);

    if (response.statusCode == 200) {
      return SuccesMessageShopModel.fromJson(response.data);
    } else {
      return SuccesMessageShopModel.fromJson(response.data);
    }
  }

  @override
  Future<SuccesMessageMineModel> GetMineItemPackage() async {
    final client = await DioInstance();

    final response = await client.post(ApiConstance.GetMineItemPackages);

    if (response.statusCode == 200) {
      return SuccesMessageMineModel.fromJson(response.data);
    } else {
      return SuccesMessageMineModel.fromJson(response.data);
    }
  }

  @override
  Future<SuccesMessageModel> WearItem({required int SalesId}) async {
    FormData formData = FormData.fromMap({
      "sales_id": SalesId.toString(),
    });
    final client = await DioInstance();

    final response = await client.post(ApiConstance.WearItem, data: formData);

    if (response.statusCode == 200) {
      return SuccesMessageModel.fromJson(response.data);
    } else {
      return SuccesMessageModel.fromJson(response.data);
    }
  }

  @override
  Future<SuccesMessageModel> UnWearItem({required int SalesId}) async {
    FormData formData = FormData.fromMap({
      "sales_id": SalesId.toString(),
    });
    final client = await DioInstance();

    final response = await client.post(ApiConstance.UnWearItem, data: formData);

    if (response.statusCode == 200) {
      return SuccesMessageModel.fromJson(response.data);
    } else {
      return SuccesMessageModel.fromJson(response.data);
    }
  }
}
