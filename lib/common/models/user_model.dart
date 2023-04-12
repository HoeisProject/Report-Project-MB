// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

enum UserRoleEnum { admin, employee }

enum UserModelEnum {
  objectId,
  username,
  email,
  nik,
  role,
  userImage,
  phoneNumber,
  ktpImage,
  nickname,
}

@immutable
class UserModel {
  final String objectId;
  final String username;
  final String email;
  final String nik;
  final String role;
  final String userImage;
  final String phoneNumber;
  final String ktpImage;
  final String nickname;

  const UserModel({
    required this.objectId,
    required this.username,
    required this.email,
    required this.role,
    required this.nik,
    required this.userImage,
    required this.phoneNumber,
    required this.ktpImage,
    required this.nickname,
  });

  factory UserModel.fromParseUser(ParseUser parseUser) {
    return UserModel(
      objectId: parseUser.get<String>(UserModelEnum.objectId.name) ?? '',
      username: parseUser.get<String>(UserModelEnum.username.name) ?? '',
      email: parseUser.get<String>(UserModelEnum.email.name) ?? '',
      nik: parseUser.get<String>(UserModelEnum.nik.name) ?? '',
      role: parseUser.get<String>(UserModelEnum.role.name) ?? '',
      userImage:
          parseUser.get<ParseFile>(UserModelEnum.userImage.name)?.url ?? '',
      phoneNumber: parseUser.get<String>(UserModelEnum.phoneNumber.name) ?? '',
      ktpImage:
          parseUser.get<ParseFile>(UserModelEnum.ktpImage.name)?.url ?? '',
      nickname: parseUser.get<String>(UserModelEnum.nickname.name) ?? '',
    );
  }

  UserModel copyWith({
    String? objectId,
    String? username,
    String? email,
    String? nik,
    String? role,
    String? userImage,
    String? phoneNumber,
    String? ktpImage,
    String? nickname,
  }) {
    return UserModel(
      objectId: objectId ?? this.objectId,
      username: username ?? this.username,
      email: email ?? this.email,
      nik: nik ?? this.nik,
      role: role ?? this.role,
      userImage: userImage ?? this.userImage,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      ktpImage: ktpImage ?? this.ktpImage,
      nickname: nickname ?? this.nickname,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'objectId': objectId,
      'username': username,
      'email': email,
      'nik': nik,
      'role': role,
      'userImage': userImage,
      'phoneNumber': phoneNumber,
      'ktpImage': ktpImage,
      'nickname': nickname
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      objectId: map['objectId'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
      nik: map['nik'] as String,
      role: map['role'] as String,
      userImage: map['userImage'] as String,
      phoneNumber: map['phoneNumber'] as String,
      ktpImage: map['ktpImage'] as String,
      nickname: map['nickname'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(objectId: $objectId, username: $username, email: $email, nik: $nik, role : $role, userImage: $userImage), phoneNumber: $phoneNumber), ktpImage: $ktpImage), nickname: $nickname)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.objectId == objectId &&
        other.username == username &&
        other.email == email &&
        other.nik == nik &&
        other.role == role &&
        other.userImage == userImage &&
        other.phoneNumber == phoneNumber &&
        other.ktpImage == ktpImage &&
        other.nickname == nickname;
  }

  @override
  int get hashCode {
    return objectId.hashCode ^
        username.hashCode ^
        email.hashCode ^
        nik.hashCode ^
        role.hashCode ^
        userImage.hashCode ^
        phoneNumber.hashCode ^
        ktpImage.hashCode ^
        nickname.hashCode;
  }
}
