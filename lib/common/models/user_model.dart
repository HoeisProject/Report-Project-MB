// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:report_project/common/models/role_model.dart';
import 'package:report_project/data/constant_data.dart';

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
  id('id'),
  roleId('role_id'),
  role('role'),
  username('username'),
  nickname('nickname'),
  email('email'),
  nik('nik'),
  phoneNumber('phone_number'),
  status('status'),
  password('password'),
  userImage('user_image'),
  ktpImage('ktp_image');

  const UserModelEnum(this.value);
  final String value;
}

@immutable
class UserModel {
  final String id;
  final RoleModel? role;
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
    required this.role,
    required this.username,
    required this.nickname,
    required this.email,
    this.nik,
    required this.phoneNumber,
    required this.status,
    required this.userImage,
    this.ktpImage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      UserModelEnum.id.value: id,
      UserModelEnum.role.value: role == null ? null : role!.toMap(),
      UserModelEnum.username.value: username,
      UserModelEnum.nickname.value: nickname,
      UserModelEnum.email.value: email,
      UserModelEnum.nik.value: nik,
      UserModelEnum.phoneNumber.value: phoneNumber,
      UserModelEnum.status.value: status,
      UserModelEnum.userImage.value: userImage,
      UserModelEnum.ktpImage.value: ktpImage,
    };
  }

  UserModel copyWith({
    String? id,
    RoleModel? role,
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
      role: role ?? this.role,
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

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map[UserModelEnum.id.value].toString(),
      role: map[UserModelEnum.role.value] != null
          ? RoleModel.fromMap(
              map[UserModelEnum.role.value] as Map<String, dynamic>)
          : null,
      username: map[UserModelEnum.username.value] as String,
      nickname: map[UserModelEnum.nickname.value] as String,
      email: map[UserModelEnum.email.value] as String,
      nik: map[UserModelEnum.nik.value] != null
          ? map[UserModelEnum.nik.value] as String
          : null,
      phoneNumber: map[UserModelEnum.phoneNumber.value] as String,
      // status: map[UserModelEnum.status.value] as int,
      status: int.parse(map[UserModelEnum.status.value]),

      /// TODO Remove base url after deploymeny maybe
      userImage: ConstantApi.baseUrl + map[UserModelEnum.userImage.value],
      ktpImage: map[UserModelEnum.ktpImage.value] != null
          ? ConstantApi.baseUrl + map[UserModelEnum.ktpImage.value]
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, role: $role, username: $username, nickname: $nickname, email: $email, nik: $nik, phoneNumber: $phoneNumber, status: $status, userImage: $userImage, ktpImage: $ktpImage)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.role == role &&
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
        role.hashCode ^
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
