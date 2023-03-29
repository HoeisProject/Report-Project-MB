// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

enum ReportMediaEnum {
  objectId,
  reportAttachment,
  reportId,
}

@immutable
class ReportMediaModel {
  final String objectId;
  final String reportAttachment;
  final String reportId;
  const ReportMediaModel({
    required this.objectId,
    required this.reportAttachment,
    required this.reportId,
  });

  factory ReportMediaModel.fromParseObject(ParseObject parseObject) {
    return ReportMediaModel(
      objectId: parseObject.get<String>(ReportMediaEnum.objectId.name)!,
      reportAttachment: parseObject
              .get<ParseFile>(ReportMediaEnum.reportAttachment.name)!
              .url ??
          '',
      reportId: parseObject.get<String>(ReportMediaEnum.reportId.name)!,
    );
  }

  ReportMediaModel copyWith({
    String? objectId,
    String? reportAttachment,
    String? reportId,
  }) {
    return ReportMediaModel(
      objectId: objectId ?? this.objectId,
      reportAttachment: reportAttachment ?? this.reportAttachment,
      reportId: reportId ?? this.reportId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'objectId': objectId,
      'reportAttachment': reportAttachment,
      'reportId': reportId,
    };
  }

  factory ReportMediaModel.fromMap(Map<String, dynamic> map) {
    return ReportMediaModel(
      objectId: map['objectId'] as String,
      reportAttachment: map['reportAttachment'] as String,
      reportId: map['reportId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReportMediaModel.fromJson(String source) =>
      ReportMediaModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ReportMediaModel(objectId: $objectId, reportAttachment: $reportAttachment, reportId: $reportId)';

  @override
  bool operator ==(covariant ReportMediaModel other) {
    if (identical(this, other)) return true;

    return other.objectId == objectId &&
        other.reportAttachment == reportAttachment &&
        other.reportId == reportId;
  }

  @override
  int get hashCode =>
      objectId.hashCode ^ reportAttachment.hashCode ^ reportId.hashCode;
}
