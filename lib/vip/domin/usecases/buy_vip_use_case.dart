import 'package:ahlachat/core/network/succes_message_model.dart';
import 'package:ahlachat/vip/data/models/VipModel.dart';
import 'package:ahlachat/vip/domin/repository/base_vip_shop_repository.dart';
import 'package:dartz/dartz.dart';

class BuyVipUseCase {
  final BaseVipRepository baseVipRepository;
  BuyVipUseCase(this.baseVipRepository);
  Future<Either<SuccesMessageModel, SuccesMessageModel>> BuyVipItem(
      {required VipModel vip}) async {
    return await baseVipRepository.BuyVip(vip: vip);
  }
}
