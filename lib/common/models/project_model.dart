// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:report_project/common/models/user_model.dart';

enum ProjectModelEnum {
  objectId,
  name,
  userId,
  description,
  startDate,
  endDate,
}

@immutable
class ProjectModel {
  final String id;
  final String userId;
  final String name;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  const ProjectModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.description,
    required this.startDate,
    required this.endDate,
  });

  factory ProjectModel.fromParseObject(ParseObject parse) {
    return ProjectModel(
      id: parse.get<String>(ProjectModelEnum.objectId.name)!,
      userId: parse
          .get<ParseUser>(ProjectModelEnum.userId.name)!
          .get(UserModelEnum.objectId.name),
      name: parse.get<String>(ProjectModelEnum.description.name)!,
      description: parse.get<String>(ProjectModelEnum.name.name)!,
      startDate: parse.get<DateTime>(ProjectModelEnum.startDate.name)!,
      endDate: parse.get<DateTime>(ProjectModelEnum.endDate.name)!,
    );
  }

  ProjectModel copyWith({
    String? id,
    String? userId,
    String? name,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return ProjectModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'startDate': startDate.millisecondsSinceEpoch,
      'endDate': endDate.millisecondsSinceEpoch,
    };
  }

  factory ProjectModel.fromMap(Map<String, dynamic> map) {
    return ProjectModel(
      id: map['id'] as String,
      userId: map['userId'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      startDate: DateTime.fromMillisecondsSinceEpoch(map['startDate'] as int),
      endDate: DateTime.fromMillisecondsSinceEpoch(map['endDate'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProjectModel.fromJson(String source) =>
      ProjectModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProjectModel(id: $id, userId: $userId name: $name, description: $description, startDate: $startDate, endDate: $endDate)';
  }

  @override
  bool operator ==(covariant ProjectModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.userId == userId &&
        other.name == name &&
        other.description == description &&
        other.startDate == startDate &&
        other.endDate == endDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        name.hashCode ^
        description.hashCode ^
        startDate.hashCode ^
        endDate.hashCode;
  }
}
