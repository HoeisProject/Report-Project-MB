// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

enum ProjectModelEnum {
  objectId,
  name,
  startDate,
  endDate,
}

@immutable
class ProjectModel {
  final String id;
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  const ProjectModel({
    required this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
  });

  factory ProjectModel.fromParseObject(ParseObject parse) {
    return ProjectModel(
      id: parse.get<String>(ProjectModelEnum.objectId.name)!,
      name: parse.get<String>(ProjectModelEnum.name.name)!,
      startDate: parse.get<DateTime>(ProjectModelEnum.startDate.name)!,
      endDate: parse.get<DateTime>(ProjectModelEnum.endDate.name)!,
    );
  }

  ProjectModel copyWith({
    String? id,
    String? name,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return ProjectModel(
      id: id ?? this.id,
      name: name ?? this.name,
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
      name: map['name'] as String,
      startDate: DateTime.fromMillisecondsSinceEpoch(map['startDate'] as int),
      endDate: DateTime.fromMillisecondsSinceEpoch(map['endDate'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProjectModel.fromJson(String source) =>
      ProjectModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProjectModel(id: $id, name: $name, startDate: $startDate, endDate: $endDate)';
  }

  @override
  bool operator ==(covariant ProjectModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.startDate == startDate &&
        other.endDate == endDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ startDate.hashCode ^ endDate.hashCode;
  }
}
