// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import 'package:report_project/common/models/user_model.dart';

enum ReportProjectEnum {
  objectId,
  projectTitle,
  projectDesc,
  projectStatus,
  projectPosition,
  projectDateTime,
  uploadBy
}

@immutable
class ProjectReportModel {
  final String objectId;
  final String projectTitle;
  final String projectDesc;
  final int projectStatus;
  final ParseGeoPoint projectPosition;
  final DateTime projectDateTime;
  final UserModel uploadBy;

  const ProjectReportModel({
    required this.objectId,
    required this.projectTitle,
    required this.projectDesc,
    required this.projectStatus,
    required this.projectPosition,
    required this.projectDateTime,
    required this.uploadBy,
  });

  factory ProjectReportModel.fromParseObject(ParseObject parseObject) {
    return ProjectReportModel(
      objectId: parseObject.get<String>(ReportProjectEnum.objectId.name)!,
      projectTitle:
          parseObject.get<String>(ReportProjectEnum.projectTitle.name)!,
      projectDesc: parseObject.get<String>(ReportProjectEnum.projectDesc.name)!,
      projectStatus:
          parseObject.get<int>(ReportProjectEnum.projectStatus.name)!,
      projectPosition: parseObject
          .get<ParseGeoPoint>(ReportProjectEnum.projectPosition.name)!,
      projectDateTime:
          parseObject.get<DateTime>(ReportProjectEnum.projectDateTime.name)!,
      // projectDateTime: DateTime.fromMillisecondsSinceEpoch(
      //     parseObject['projectDateTime'] as int),
      uploadBy: UserModel.fromParseUser(
          parseObject.get<ParseUser>(ReportProjectEnum.uploadBy.name)!),
    );
  }

  ProjectReportModel copyWith({
    String? objectId,
    String? projectTitle,
    String? projectDesc,
    int? projectStatus,
    ParseGeoPoint? projectPosition,
    DateTime? projectDateTime,
    UserModel? uploadBy,
  }) {
    return ProjectReportModel(
      objectId: objectId ?? this.objectId,
      projectTitle: projectTitle ?? this.projectTitle,
      projectDesc: projectDesc ?? this.projectDesc,
      projectStatus: projectStatus ?? this.projectStatus,
      projectPosition: projectPosition ?? this.projectPosition,
      projectDateTime: projectDateTime ?? this.projectDateTime,
      uploadBy: uploadBy ?? this.uploadBy,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'objectId': objectId,
      'projectTitle': projectTitle,
      'projectDesc': projectDesc,
      'projectStatus': projectStatus,
      'projectPosition': projectPosition,
      'projectDateTime': projectDateTime.millisecondsSinceEpoch,
      'uploadBy': uploadBy.toMap(),
    };
  }

  // factory ReportModel.fromMap(Map<String, dynamic> map) {
  //   return ReportModel(
  //     objectId: map['objectId'] as String,
  //     projectTitle: map['projectTitle'] as String,
  //     projectDesc: map['projectDesc'] as String,
  //     projectStatus: map['projectStatus'] as int,
  //     projectPosition:
  //         Position.fromMap(map['projectPosition'] as Map<String, dynamic>),
  //     projectDateTime:
  //         DateTime.fromMillisecondsSinceEpoch(map['projectDateTime'] as int),
  //     uploadBy: UserModel.fromMap(map['uploadBy'] as Map<String, dynamic>),
  //   );
  // }

  String toJson() => json.encode(toMap());

  // factory ReportModel.fromJson(String source) =>
  //     ReportModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ReportModel(objectId: $objectId, projectTitle: $projectTitle, projectDesc: $projectDesc, projectStatus: $projectStatus, projectPosition: $projectPosition, projectDateTime: $projectDateTime, uploadBy: $uploadBy)';
  }

  @override
  bool operator ==(covariant ProjectReportModel other) {
    if (identical(this, other)) return true;

    return other.objectId == objectId &&
        other.projectTitle == projectTitle &&
        other.projectDesc == projectDesc &&
        other.projectStatus == projectStatus &&
        other.projectPosition == projectPosition &&
        other.projectDateTime == projectDateTime &&
        other.uploadBy == uploadBy;
  }

  @override
  int get hashCode {
    return objectId.hashCode ^
        projectTitle.hashCode ^
        projectDesc.hashCode ^
        projectStatus.hashCode ^
        projectPosition.hashCode ^
        projectDateTime.hashCode ^
        uploadBy.hashCode;
  }
}
