import 'package:flutter/foundation.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import 'package:report_project/common/models/project_model.dart';
import 'package:report_project/common/models/report_status_model.dart';
import 'package:report_project/common/models/user_model.dart';

enum ReportModelEnum {
  objectId,
  projectId,
  userId,
  reportStatusId,
  title,
  description,
  position,
  createdAt,
  updatedAt
}

@immutable
class ReportModel {
  final String id;
  final String projectId;
  final UserModel userId;
  final String reportStatusId;
  final String title;
  final String description;
  final ParseGeoPoint position;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ReportModel({
    required this.id,
    required this.projectId,
    required this.userId,
    required this.reportStatusId,
    required this.title,
    required this.description,
    required this.position,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ReportModel.fromParseObject(ParseObject parse) {
    debugPrint(parse.toString());
    return ReportModel(
      id: parse.get<String>(ReportModelEnum.objectId.name)!,
      projectId: parse
          .get<ParseObject>(ReportModelEnum.projectId.name)!
          .get(ProjectModelEnum.objectId.name)!,
      userId: UserModel.fromParseObject(
          parse.get<ParseObject>(ReportModelEnum.userId.name)!),
      reportStatusId: parse
          .get<ParseObject>(ReportModelEnum.reportStatusId.name)!
          .get(ReportStatusModelEnum.objectId.name),
      title: parse.get<String>(ReportModelEnum.title.name)!,
      description: parse.get<String>(ReportModelEnum.description.name)!,
      position: parse.get<ParseGeoPoint>(ReportModelEnum.position.name)!,
      createdAt: parse.get<DateTime>(ReportModelEnum.createdAt.name)!,
      updatedAt: parse.get<DateTime>(ReportModelEnum.updatedAt.name) ??
          parse.get<DateTime>(ReportModelEnum.createdAt.name)!,
    );
  }

  ReportModel copyWith({
    String? id,
    String? projectId,
    UserModel? userId,
    String? reportStatusId,
    String? title,
    String? description,
    ParseGeoPoint? position,
    DateTime? createdAt,
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
      createdAt: createdAt ?? this.createdAt,
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
  //     'createdAt': createdAt.millisecondsSinceEpoch,
  //     'updatedAt': updatedAt.millisecondsSinceEpoch,
  //   };
  // }

  // factory ReportModel.fromMap(Map<String, dynamic> map) {
  //   return ReportModel(
  //     id: map['id'] as String,
  //     projectId: map['projectId'] as String,
  //     userId: map['userId'] as String,
  //     reportStatusId: map['reportStatusId'] as String,
  //     title: map['title'] as String,
  //     description: map['description'] as String,
  //     position: ParseGeoPoint.fromMap(map['position'] as Map<String,dynamic>),
  //     createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
  //     updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory ReportModel.fromJson(String source) => ReportModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ReportModel(id: $id, projectId: $projectId, userId: $userId, reportStatusId: $reportStatusId, title: $title, description: $description, position: $position, createdAt: $createdAt, updatedAt: $updatedAt)';
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
        other.position == position &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        projectId.hashCode ^
        userId.hashCode ^
        reportStatusId.hashCode ^
        title.hashCode ^
        description.hashCode ^
        position.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
