import 'package:ahlachat/vip/data/models/VipModel.dart';
import 'package:ahlachat/vip/data/models/VipSalesModel.dart';
import 'package:equatable/equatable.dart';

class SuccesMessageVipShopModel extends Equatable {
  bool? statusCode;
  int? errNum;
  String? statusMessage;
  List<VipModel>? Vip;
  List<VipSalesModel>? Sales;

  SuccesMessageVipShopModel(
      {this.statusCode, this.errNum, this.Vip, this.statusMessage});

  SuccesMessageVipShopModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status'];
    errNum = int.tryParse(json['errNum']?.toString() ?? '');
    statusMessage = json['message'] ?? json['msg'];
    final payload = json['Vip'];

    // Current Laravel returns `Vip` as a list; older deployments returned
    // `{shop: [], mysales: []}`. Accept both contracts.
    final shop = payload is List
        ? payload
        : payload is Map<String, dynamic>
            ? payload['shop']
            : null;
    if (shop is List) {
      Vip = <VipModel>[];
      shop.whereType<Map>().forEach((v) {
        Vip!.add(VipModel.fromJson(Map<String, dynamic>.from(v)));
      });
    }
    final sales = payload is Map<String, dynamic> ? payload['mysales'] : null;
    if (sales is List) {
      Sales = <VipSalesModel>[];
      sales.whereType<Map>().forEach((v) {
        Sales!.add(VipSalesModel.fromJson(Map<String, dynamic>.from(v)));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.statusCode;
    data['errNum'] = this.errNum;
    data['message'] = this.statusMessage;
    data['Vip'] = this.Vip?.map((v) => v.toJson()).toList();
    return data;
  }

  @override
  List<Object?> get props => [statusCode, statusMessage, errNum, Vip];
}
