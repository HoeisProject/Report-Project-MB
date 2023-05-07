// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:report_project/common/models/role_model.dart';

// https://stackoverflow.com/questions/38908285/how-do-i-add-methods-or-values-to-enums-in-dart
enum UserStatus {
  admin(0),
  noupload(1),
  pending(2),
  approve(3),
  reject(4);

  const UserStatus(this.value);
  final int value;
}

enum UserModelEnum {
  objectId,
  roleId,
  username,
  nickname,
  email,

  /// TODO After migration to Laravel
  emailClone, // Only back4apps use case, because restricted permission
  nik,
  phoneNumber,
  status,
  userImage,
  ktpImage,
}

@immutable
class UserModel {
  final String id;
  final String roleId;
  final String username;
  final String nickname;
  final String email;
  final String? nik;
  final String phoneNumber;
  final int status;
  final String userImage;
  final String? ktpImage;

  const UserModel({
    required this.id,
    required this.roleId,
    required this.username,
    required this.nickname,
    required this.email,
    this.nik,
    required this.phoneNumber,
    required this.status,
    required this.userImage,
    this.ktpImage,
  });

  factory UserModel.fromParseUser(ParseUser parse) {
    debugPrint("UserModel.fromParseUser : $parse");
    return UserModel(
      id: parse.get<String>(UserModelEnum.objectId.name)!,
      roleId: parse
          .get<ParseObject>(UserModelEnum.roleId.name)!
          .get(RoleModelEnum.objectId.name),
      username: parse.get<String>(UserModelEnum.username.name)!,
      nickname: parse.get<String>(UserModelEnum.nickname.name)!,
      email: parse.get<String>(UserModelEnum.email.name)!,
      nik: parse.get<String>(UserModelEnum.nik.name),
      phoneNumber: parse.get<String>(UserModelEnum.phoneNumber.name)!,
      status: parse.get<int>(UserModelEnum.status.name)!,
      userImage: parse.get<ParseFile>(UserModelEnum.userImage.name)?.url ?? '',
      ktpImage: parse.get<ParseFile>(UserModelEnum.ktpImage.name)?.url,
    );
  }

  factory UserModel.fromParseObject(ParseObject parse) {
    debugPrint("UserModel.fromParseObject : $parse");
    return UserModel(
      id: parse.get<String>(UserModelEnum.objectId.name)!,
      roleId: parse
          .get<ParseObject>(UserModelEnum.roleId.name)!
          .get(RoleModelEnum.objectId.name),
      username: parse.get<String>(UserModelEnum.username.name)!,
      nickname: parse.get<String>(UserModelEnum.nickname.name)!,
      email: parse.get<String>(UserModelEnum.emailClone.name)!,
      nik: parse.get<String>(UserModelEnum.nik.name),
      phoneNumber: parse.get<String>(UserModelEnum.phoneNumber.name)!,
      status: parse.get<int>(UserModelEnum.status.name)!,
      userImage: parse.get<ParseFile>(UserModelEnum.userImage.name)?.url ?? '',
      ktpImage: parse.get<ParseFile>(UserModelEnum.ktpImage.name)?.url,
    );
  }

  UserModel copyWith({
    String? id,
    String? roleId,
    String? username,
    String? nickname,
    String? email,
    String? nik,
    String? phoneNumber,
    int? status,
    String? userImage,
    String? ktpImage,
  }) {
    return UserModel(
      id: id ?? this.id,
      roleId: roleId ?? this.roleId,
      username: username ?? this.username,
      nickname: nickname ?? this.nickname,
      email: email ?? this.email,
      nik: nik ?? this.nik,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      status: status ?? this.status,
      userImage: userImage ?? this.userImage,
      ktpImage: ktpImage ?? this.ktpImage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'roleId': roleId,
      'username': username,
      'nickname': nickname,
      'email': email,
      'nik': nik,
      'phoneNumber': phoneNumber,
      'status': status,
      'userImage': userImage,
      'ktpImage': ktpImage,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      roleId: map['roleId'] as String,
      username: map['username'] as String,
      nickname: map['nickname'] as String,
      email: map['email'] as String,
      nik: map['nik'] != null ? map['nik'] as String : null,
      phoneNumber: map['phoneNumber'] as String,
      status: map['status'] as int,
      userImage: map['userImage'] as String,
      ktpImage: map['ktpImage'] != null ? map['ktpImage'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, roleId: $roleId, username: $username, nickname: $nickname, email: $email, nik: $nik, phoneNumber: $phoneNumber, status: $status, userImage: $userImage, ktpImage: $ktpImage)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.roleId == roleId &&
        other.username == username &&
        other.nickname == nickname &&
        other.email == email &&
        other.nik == nik &&
        other.phoneNumber == phoneNumber &&
        other.status == status &&
        other.userImage == userImage &&
        other.ktpImage == ktpImage;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        roleId.hashCode ^
        username.hashCode ^
        nickname.hashCode ^
        email.hashCode ^
        nik.hashCode ^
        phoneNumber.hashCode ^
        status.hashCode ^
        userImage.hashCode ^
        ktpImage.hashCode;
  }
}
