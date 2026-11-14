import 'package:ahlachat/users/data/models/FireBaseGoogleModel.dart';
import 'package:ahlachat/users/data/models/UserModel.dart';
import 'package:equatable/equatable.dart';

class SuccesMessageModel extends Equatable {
  bool? statusCode;
  int? errNum;
  String? statusMessage;
  String? image;
  TokenData? data;
  FireBaseGoogleModel? FirebaseAuth;

  SuccesMessageModel(
      {this.statusCode,
      this.errNum,
      this.data,
      this.statusMessage,
      this.FirebaseAuth});

  SuccesMessageModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status'];
    errNum = int.tryParse(json['errNum']?.toString() ?? '');
    statusMessage = json['message'] ?? json['msg'];
    // Login/loginGoogle return their user directly under `users` along with
    // `userToken`, unlike the former OAuth-shaped `data` response.
    final payload = json['data'] ?? json;
    data = payload is Map<String, dynamic> ? TokenData.fromJson(payload) : null;
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.statusCode;
    data['errNum'] = this.errNum;
    data['message'] = this.statusMessage;
    data['image'] = this.image;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }

  @override
  List<Object?> get props => [
        statusCode,
        statusMessage,
        errNum,
      ];
}

class TokenData extends Equatable {
  String? accessToken;
  String? tokenType;
  UserModel? UserInfo;
  int? expiresIn;
  List<UserModel>? users;
  TokenData({this.accessToken, this.tokenType, this.expiresIn, this.users});

  TokenData.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'] ?? json['userToken'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
    final user = json['user'] ?? (json['users'] is Map ? json['users'] : null);
    UserInfo = user is Map<String, dynamic> ? UserModel.fromJson(user) : null;
    if (json['users'] is List) {
      users = <UserModel>[];
      json['users'].forEach((v) {
        users!.add(new UserModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    data['expires_in'] = this.expiresIn;
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  List<Object?> get props =>
      [accessToken, tokenType, expiresIn, UserInfo, users];
}
