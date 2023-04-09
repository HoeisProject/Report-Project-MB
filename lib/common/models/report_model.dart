// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import 'package:report_project/common/models/user_model.dart';

enum ProjectReportStatusEnum {
  pending, // 0
  approve, // 1
  reject, // 2
}

enum ReportEnum {
  objectId,
  projectTitle,
  projectDesc,
  projectStatus,
  projectPosition,
  projectDateTime,
  uploadBy,
}

// class ReportModel {
//   final String objectId;
//   final String title;
// }

@immutable
class ReportModel {
  final String objectId;
  final String title;
  final String desc;
  final int status;
  final ParseGeoPoint position;
  final DateTime dateTime;
  final UserModel uploadBy;

  const ReportModel({
    required this.objectId,
    required this.title,
    required this.desc,
    required this.status,
    required this.position,
    required this.dateTime,
    required this.uploadBy,
  });

  factory ReportModel.fromParseObject(ParseObject parseObject) {
    return ReportModel(
      objectId: parseObject.get<String>(ReportEnum.objectId.name)!,
      title: parseObject.get<String>(ReportEnum.projectTitle.name)!,
      desc: parseObject.get<String>(ReportEnum.projectDesc.name)!,
      status: parseObject.get<int>(ReportEnum.projectStatus.name)!,
      position:
          parseObject.get<ParseGeoPoint>(ReportEnum.projectPosition.name)!,
      dateTime: parseObject.get<DateTime>(ReportEnum.projectDateTime.name)!,
      // projectDateTime: DateTime.fromMillisecondsSinceEpoch(
      //     parseObject['projectDateTime'] as int),
      uploadBy: UserModel.fromParseUser(
          parseObject.get<ParseUser>(ReportEnum.uploadBy.name)!),
    );
  }

  ReportModel copyWith({
    String? objectId,
    String? title,
    String? desc,
    int? status,
    ParseGeoPoint? position,
    DateTime? dateTime,
    UserModel? uploadBy,
  }) {
    return ReportModel(
      objectId: objectId ?? this.objectId,
      title: title ?? this.title,
      desc: desc ?? this.desc,
      status: status ?? this.status,
      position: position ?? this.position,
      dateTime: dateTime ?? this.dateTime,
      uploadBy: uploadBy ?? this.uploadBy,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'objectId': objectId,
      'title': title,
      'desc': desc,
      'status': status,
      'position': position,
      'dateTime': dateTime.millisecondsSinceEpoch,
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
    return 'ReportModel(objectId: $objectId, title: $title, desc: $desc, status: $status, position: $position, dateTime: $dateTime, uploadBy: $uploadBy)';
  }

  @override
  bool operator ==(covariant ReportModel other) {
    if (identical(this, other)) return true;

    return other.objectId == objectId &&
        other.title == title &&
        other.desc == desc &&
        other.status == status &&
        other.position == position &&
        other.dateTime == dateTime &&
        other.uploadBy == uploadBy;
  }

  @override
  int get hashCode {
    return objectId.hashCode ^
        title.hashCode ^
        desc.hashCode ^
        status.hashCode ^
        position.hashCode ^
        dateTime.hashCode ^
        uploadBy.hashCode;
  }
}
