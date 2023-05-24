// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

enum RoleModelNameEnum {
  admin('admin'),
  employee('employee');

  const RoleModelNameEnum(this.name);
  final String name;
}

enum RoleModelEnum {
  id('id'),
  name('name'),
  description('description');

  const RoleModelEnum(this.value);
  final String value;
}

@immutable
class RoleModel {
  final String id;
  final String name;
  final String description;
  const RoleModel({
    required this.id,
    required this.name,
    required this.description,
  });

  RoleModel copyWith({
    String? id,
    String? name,
    String? description,
  }) {
    return RoleModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
    };
  }

  factory RoleModel.fromMap(Map<String, dynamic> map) {
    return RoleModel(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RoleModel.fromJson(String source) =>
      RoleModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'RoleModel(id: $id, name: $name, description: $description)';

  @override
  bool operator ==(covariant RoleModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.description == description;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ description.hashCode;
}
