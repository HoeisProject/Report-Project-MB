// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

enum ReportEnum {
  objectId,
  projectId,
  userId,
  reportStatusId,
  title,
  description,
  position,
  updatedAt,
}

@immutable
class ReportModel {
  final String id;
  final String projectId;
  final String userId;
  final String reportStatusId;
  final String title;
  final String description;
  final ParseGeoPoint position;
  final DateTime updatedAt;

  const ReportModel({
    required this.id,
    required this.projectId,
    required this.userId,
    required this.reportStatusId,
    required this.title,
    required this.description,
    required this.position,
    required this.updatedAt,
  });

  factory ReportModel.fromParseObject(ParseObject parse) {
    return ReportModel(
      id: parse.get<String>(ReportEnum.objectId.name)!,
      projectId: parse.get<String>(ReportEnum.projectId.name)!,
      userId: parse.get<String>(ReportEnum.userId.name)!,
      reportStatusId: parse.get<String>(ReportEnum.reportStatusId.name)!,
      title: parse.get<String>(ReportEnum.title.name)!,
      description: parse.get<String>(ReportEnum.description.name)!,
      position: parse.get<ParseGeoPoint>(ReportEnum.position.name)!,
      updatedAt: parse.get<DateTime>(ReportEnum.updatedAt.name)!,
    );
  }

  ReportModel copyWith({
    String? id,
    String? projectId,
    String? userId,
    String? reportStatusId,
    String? title,
    String? description,
    ParseGeoPoint? position,
    DateTime? updatedAt,
  }) {
    return ReportModel(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      userId: userId ?? this.userId,
      reportStatusId: reportStatusId ?? this.reportStatusId,
      title: title ?? this.title,
      description: description ?? this.description,
      position: position ?? this.position,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'id': id,
  //     'projectId': projectId,
  //     'userId': userId,
  //     'reportStatusId': reportStatusId,
  //     'title': title,
  //     'description': description,
  //     'position': position.toMap(),
  //   };
  // }

  // factory ReportModel.fromMap(Map<String, dynamic> map) {
  //   return ReportModel(
  //     id: map['id'] as String,
  //     projectId: map['projectId'] as String,
  //     userId: map['userId'] as String,
  //     reportStatusId: map['reportStatusId'] as int,
  //     title: map['title'] as String,
  //     description: map['description'] as String,
  //     position: ParseGeoPoint.fromMap(map['position'] as Map<String,dynamic>),
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory ReportModel.fromJson(String source) => ReportModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ReportModel(id: $id, projectId: $projectId, userId: $userId, reportStatusId: $reportStatusId, title: $title, description: $description, position: $position)';
  }

  @override
  bool operator ==(covariant ReportModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.projectId == projectId &&
        other.userId == userId &&
        other.reportStatusId == reportStatusId &&
        other.title == title &&
        other.description == description &&
        other.position == position;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        projectId.hashCode ^
        userId.hashCode ^
        reportStatusId.hashCode ^
        title.hashCode ^
        description.hashCode ^
        position.hashCode;
  }
}
