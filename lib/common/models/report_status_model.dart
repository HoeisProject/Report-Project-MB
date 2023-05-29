// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:flutter/foundation.dart';

enum ReportStatusEnum {
  pending, // 0
  approve, // 1
  reject, // 2
}

enum ReportStatusModelEnum {
  objectId,
  name,
  description,
}

@immutable
class ReportStatusModel {
  final String id;
  final String name;
  final String description;
  const ReportStatusModel({
    required this.id,
    required this.name,
    required this.description,
  });

  ReportStatusModel copyWith({
    String? id,
    String? name,
    String? description,
  }) {
    return ReportStatusModel(
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

  factory ReportStatusModel.fromMap(Map<String, dynamic> map) {
    return ReportStatusModel(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReportStatusModel.fromJson(String source) =>
      ReportStatusModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ReportStatusModel(id: $id, name: $name, description: $description)';

  @override
  bool operator ==(covariant ReportStatusModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.description == description;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ description.hashCode;
}
