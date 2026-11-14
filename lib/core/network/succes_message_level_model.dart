import 'package:ahlachat/profile/data/models/levelModel.dart';

import 'package:equatable/equatable.dart';

class SuccesMessageLevelModel extends Equatable {
  bool? statusCode;
  int? errNum;
  String? statusMessage;
  List<LevelModel>? Wealth;
  List<LevelModel>? Income;

  SuccesMessageLevelModel(
      {this.statusCode,
      this.errNum,
      this.Wealth,
      this.Income,
      this.statusMessage});

  SuccesMessageLevelModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status'];
    errNum = int.tryParse(json['errNum']?.toString() ?? '');
    statusMessage = json['message'] ?? json['msg'];
    final payload = json['Levels'] ?? json['level'];

    final wealth = payload is List
        ? payload
        : payload is Map<String, dynamic>
            ? payload['wealth']
            : null;
    if (wealth is List) {
      Wealth = <LevelModel>[];
      wealth.whereType<Map>().forEach((v) {
        Wealth!.add(LevelModel.fromJson(Map<String, dynamic>.from(v)));
      });
    }
    final income = payload is Map<String, dynamic> ? payload['Icnome'] : null;
    if (income is List) {
      Income = <LevelModel>[];
      income.whereType<Map>().forEach((v) {
        Income!.add(LevelModel.fromJson(Map<String, dynamic>.from(v)));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.statusCode;
    data['errNum'] = this.errNum;
    data['message'] = this.statusMessage;
    data['Levels'] = this.Wealth?.map((v) => v.toJson()).toList();
    return data;
  }

  @override
  List<Object?> get props =>
      [statusCode, statusMessage, errNum, Income, Wealth];
}
