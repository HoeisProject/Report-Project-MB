// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:report_project/common/models/user_model.dart';

enum ProjectModelEnum {
  id('id'),
  name('name'),
  userId('user_id'),
  user('user'),
  description('description'),
  startDate('start_date'),
  endDate('end_date');

  const ProjectModelEnum(this.value);
  final String value;
}

@immutable
class ProjectModel {
  final String id;
  final UserModel? user;
  final String name;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  const ProjectModel({
    required this.id,
    required this.user,
    required this.name,
    required this.description,
    required this.startDate,
    required this.endDate,
  });

  ProjectModel copyWith({
    String? id,
    UserModel? user,
    String? name,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return ProjectModel(
      id: id ?? this.id,
      user: user ?? this.user,
      name: name ?? this.name,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      ProjectModelEnum.id.value: id,
      ProjectModelEnum.user.value: user?.toMap(),
      ProjectModelEnum.name.value: name,
      ProjectModelEnum.description.value: description,
      ProjectModelEnum.startDate.value: startDate.millisecondsSinceEpoch,
      ProjectModelEnum.endDate.value: endDate.millisecondsSinceEpoch,
    };
  }

  factory ProjectModel.fromMap(Map<String, dynamic> map) {
    return ProjectModel(
      id: map[ProjectModelEnum.id.value].toString(),
      user: map[ProjectModelEnum.user.value] != null
          ? UserModel.fromMap(
              map[ProjectModelEnum.user.value] as Map<String, dynamic>)
          : null,
      name: map[ProjectModelEnum.name.value] as String,
      description: map[ProjectModelEnum.description.value] as String,
      startDate: DateTime.parse(map[ProjectModelEnum.startDate.value]),
      endDate: DateTime.parse(map[ProjectModelEnum.endDate.value]),
      // endDate: DateTime.fromMillisecondsSinceEpoch(
      //     map[ProjectModelEnum.endDate.value] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProjectModel.fromJson(String source) =>
      ProjectModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProjectModel(id: $id, user: $user, name: $name, description: $description, startDate: $startDate, endDate: $endDate)';
  }

  @override
  bool operator ==(covariant ProjectModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.user == user &&
        other.name == name &&
        other.description == description &&
        other.startDate == startDate &&
        other.endDate == endDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        user.hashCode ^
        name.hashCode ^
        description.hashCode ^
        startDate.hashCode ^
        endDate.hashCode;
  }
}
