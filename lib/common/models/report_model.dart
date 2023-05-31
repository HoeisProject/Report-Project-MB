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
      'id': id,
      'project': project?.toMap(),
      'user': user?.toMap(),
      'reportStatus': reportStatus?.toMap(),
      'title': title,
      'description': description,
      'position': position,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory ReportModel.fromMap(Map<String, dynamic> map) {
    return ReportModel(
      id: map['id'] as String,
      project: map['project'] != null
          ? ProjectModel.fromMap(map['project'] as Map<String, dynamic>)
          : null,
      user: map['user'] != null
          ? UserModel.fromMap(map['user'] as Map<String, dynamic>)
          : null,
      reportStatus: map['reportStatus'] != null
          ? ReportStatusModel.fromMap(
              map['reportStatus'] as Map<String, dynamic>)
          : null,
      title: map['title'] as String,
      description: map['description'] as String,
      position: map['position'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
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
