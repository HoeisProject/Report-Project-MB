// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

@immutable
class UserModel {
  final String objectId;
  final String username;
  final String email;
  final String nik;
  final String role;
  final String userImage;

  const UserModel({
    required this.objectId,
    required this.username,
    required this.email,
    required this.role,
    required this.nik,
    required this.userImage,
  });

  factory UserModel.fromParseUser(ParseUser parseUser) {
    return UserModel(
      objectId: parseUser.get<String>('objectId')!,
      username: parseUser.get<String>('username')!,
      email: parseUser.get<String>('email')!,
      nik: parseUser.get<String>('nik')!,
      role: parseUser.get<String>('role')!,
      userImage: parseUser.get<ParseFile>('userImage')!.url ?? '',
    );
  }

  UserModel copyWith({
    String? objectId,
    String? username,
    String? email,
    String? nik,
    String? role,
    String? userImage,
  }) {
    return UserModel(
      objectId: objectId ?? this.objectId,
      username: username ?? this.username,
      email: email ?? this.email,
      nik: nik ?? this.nik,
      role: role ?? this.role,
      userImage: userImage ?? this.userImage,
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
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(objectId: $objectId, username: $username, email: $email, nik: $nik, role : $role, userImage: $userImage)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.objectId == objectId &&
        other.username == username &&
        other.email == email &&
        other.nik == nik &&
        other.role == role &&
        other.userImage == userImage;
  }

  @override
  int get hashCode {
    return objectId.hashCode ^
        username.hashCode ^
        email.hashCode ^
        nik.hashCode ^
        role.hashCode ^
        userImage.hashCode;
  }
}
