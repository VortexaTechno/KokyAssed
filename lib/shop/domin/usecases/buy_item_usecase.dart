import 'package:ahlachat/core/network/succes_message_shop_model.dart';
import 'package:ahlachat/shop/domin/repository/base_shop_repository.dart';

import 'package:dartz/dartz.dart';
import 'package:ahlachat/shop/data/models/ItemModel.dart';

class BuyItemUseCase {
  final BaseShopRepository baseShopRepository;
  BuyItemUseCase(this.baseShopRepository);
  Future<Either<SuccesMessageShopModel, SuccesMessageShopModel>> BuyItem(
      {required ItemsModel item}) async {
    return await baseShopRepository.BuyItem(item: item);
  }
}
