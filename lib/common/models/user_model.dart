// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:report_project/common/models/role_model.dart';

enum UserModelEnum {
  objectId,
  roleId,
  username,
  nickname,
  email,
  nik,
  phoneNumber,
  isUserVerified,
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
  final bool isUserVerified;
  final String userImage;
  final String? ktpImage;

  factory UserModel.fromParseUser(ParseUser parse) {
    debugPrint(parse.toString());
    return UserModel(
      id: parse.get<String>(UserModelEnum.objectId.name)!,
      roleId: parse
          .get<ParseObject>(UserModelEnum.roleId.name)!
          .get(RoleModelEnum.objectId.name),
      username: parse.get<String>(UserModelEnum.username.name)!,
      nickname: parse.get<String>(UserModelEnum.nickname.name)!,
      email: parse.get<String>(UserModelEnum.email.name)!,
      nik: parse.get<String>(UserModelEnum.objectId.name),
      phoneNumber: parse.get<String>(UserModelEnum.phoneNumber.name)!,
      isUserVerified: parse.get<bool>(UserModelEnum.isUserVerified.name)!,
      userImage: parse.get<ParseFile>(UserModelEnum.userImage.name)?.url ?? '',
      ktpImage: parse.get<String>(UserModelEnum.objectId.name),
    );
  }

  factory UserModel.fromParseObject(ParseObject parse) {
    debugPrint("Debug PRINT : $parse");
    final String? a = parse.get<String>('email');
    debugPrint("EMAIL : $a");
    return UserModel(
      id: parse.get<String>(UserModelEnum.objectId.name)!,
      roleId: parse
          .get<ParseObject>(UserModelEnum.roleId.name)!
          .get(RoleModelEnum.objectId.name),
      username: parse.get<String>(UserModelEnum.username.name)!,
      nickname: parse.get<String>(UserModelEnum.nickname.name)!,
      email: parse.get<String>(UserModelEnum.email.name)!,
      nik: parse.get<String>(UserModelEnum.objectId.name),
      phoneNumber: parse.get<String>(UserModelEnum.phoneNumber.name)!,
      isUserVerified: parse.get<bool>(UserModelEnum.isUserVerified.name)!,
      userImage: parse.get<ParseFile>(UserModelEnum.userImage.name)?.url ?? '',
      ktpImage: parse.get<String>(UserModelEnum.objectId.name),
    );
  }

  const UserModel({
    required this.id,
    required this.roleId,
    required this.username,
    required this.nickname,
    required this.email,
    this.nik,
    required this.phoneNumber,
    required this.isUserVerified,
    required this.userImage,
    this.ktpImage,
  });

  UserModel copyWith({
    String? id,
    String? roleId,
    String? username,
    String? nickname,
    String? email,
    String? nik,
    String? phoneNumber,
    bool? isUserVerified,
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
      isUserVerified: isUserVerified ?? this.isUserVerified,
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
      'isUserVerified': isUserVerified,
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
      isUserVerified: map['isUserVerified'] as bool,
      userImage: map['userImage'] as String,
      ktpImage: map['ktpImage'] != null ? map['ktpImage'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, roleId: $roleId, username: $username, nickname: $nickname, email: $email, nik: $nik, phoneNumber: $phoneNumber, isUserVerified: $isUserVerified, userImage: $userImage, ktpImage: $ktpImage)';
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
        other.isUserVerified == isUserVerified &&
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
        isUserVerified.hashCode ^
        userImage.hashCode ^
        ktpImage.hashCode;
  }
}
