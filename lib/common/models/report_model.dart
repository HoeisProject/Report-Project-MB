// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:report_project/common/models/project_model.dart';
import 'package:report_project/common/models/report_status_model.dart';
import 'package:report_project/common/models/user_model.dart';

enum ReportModelEnum {
  id('id'),
  project('project'),
  projectId('project_id'),
  user('user'),
  userId('user_id'),
  reportStatus('report_status'),
  reportStatusId('report_status_id'),
  title('title'),
  description('description'),
  position('position'),
  createdAt('created_at'),
  updatedAt('updated_at');

  const ReportModelEnum(this.value);
  final String value;
}

@immutable
class ReportModel {
  final String id;
  final ProjectModel? project;
  final UserModel? user;
  final ReportStatusModel? reportStatus;
  final String title;
  final String description;
  final String position;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ReportModel({
    required this.id,
    this.project,
    this.user,
    this.reportStatus,
    required this.title,
    required this.description,
    required this.position,
    required this.createdAt,
    required this.updatedAt,
  });

  ReportModel copyWith({
    String? id,
    ProjectModel? project,
    UserModel? user,
    ReportStatusModel? reportStatus,
    String? title,
    String? description,
    String? position,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ReportModel(
      id: id ?? this.id,
      project: project ?? this.project,
      user: user ?? this.user,
      reportStatus: reportStatus ?? this.reportStatus,
      title: title ?? this.title,
      description: description ?? this.description,
      position: position ?? this.position,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      ReportModelEnum.id.value: id,
      ReportModelEnum.project.value: project?.toMap(),
      ReportModelEnum.user.value: user?.toMap(),
      ReportModelEnum.reportStatus.value: reportStatus?.toMap(),
      ReportModelEnum.title.value: title,
      ReportModelEnum.description.value: description,
      ReportModelEnum.position.value: position,
      ReportModelEnum.createdAt.value: createdAt.millisecondsSinceEpoch,
      ReportModelEnum.updatedAt.value: updatedAt.millisecondsSinceEpoch,
    };
  }

  factory ReportModel.fromMap(Map<String, dynamic> map) {
    return ReportModel(
      id: map[ReportModelEnum.id.value] as String,
      project: map[ReportModelEnum.project.value] != null
          ? ProjectModel.fromMap(
              map[ReportModelEnum.project.value] as Map<String, dynamic>)
          : null,
      user: map[ReportModelEnum.user.value] != null
          ? UserModel.fromMap(
              map[ReportModelEnum.user.value] as Map<String, dynamic>)
          : null,
      reportStatus: map[ReportModelEnum.reportStatus.value] != null
          ? ReportStatusModel.fromMap(
              map[ReportModelEnum.reportStatus.value] as Map<String, dynamic>)
          : null,
      title: map[ReportModelEnum.title.value] as String,
      description: map[ReportModelEnum.description.value] as String,
      position: map[ReportModelEnum.position.value] as String,
      createdAt: DateTime.parse(map[ReportModelEnum.createdAt.value]),
      updatedAt: DateTime.parse(map[ReportModelEnum.updatedAt.value]),
    );
  }

  String toJson() => json.encode(toMap());

  factory ReportModel.fromJson(String source) =>
      ReportModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ReportModel(id: $id, project: $project, user: $user, reportStatus: $reportStatus, title: $title, description: $description, position: $position, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant ReportModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.project == project &&
        other.user == user &&
        other.reportStatus == reportStatus &&
        other.title == title &&
        other.description == description &&
        other.position == position &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        project.hashCode ^
        user.hashCode ^
        reportStatus.hashCode ^
        title.hashCode ^
        description.hashCode ^
        position.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
