// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

enum ReportMediaModelEnum {
  objectId,
  reportId,
  reportAttachment,
}

@immutable
class ReportMediaModel {
  final String id;
  final String reportId;
  final String reportAttachment;
  const ReportMediaModel({
    required this.id,
    required this.reportId,
    required this.reportAttachment,
  });

  factory ReportMediaModel.fromParseObject(ParseObject parse) {
    return ReportMediaModel(
      id: parse.get<String>(ReportMediaModelEnum.objectId.name)!,
      reportId: parse.get<String>(ReportMediaModelEnum.reportId.name)!,
      reportAttachment: parse
              .get<ParseFile>(ReportMediaModelEnum.reportAttachment.name)!
              .url ??
          '',
    );
  }

  ReportMediaModel copyWith({
    String? id,
    String? reportId,
    String? reportAttachment,
  }) {
    return ReportMediaModel(
      id: id ?? this.id,
      reportId: reportId ?? this.reportId,
      reportAttachment: reportAttachment ?? this.reportAttachment,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'reportId': reportId,
      'reportAttachment': reportAttachment,
    };
  }

  factory ReportMediaModel.fromMap(Map<String, dynamic> map) {
    return ReportMediaModel(
      id: map['id'] as String,
      reportId: map['reportId'] as String,
      reportAttachment: map['reportAttachment'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReportMediaModel.fromJson(String source) =>
      ReportMediaModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ReportMediaModel(id: $id, reportId: $reportId, reportAttachment: $reportAttachment)';

  @override
  bool operator ==(covariant ReportMediaModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.reportId == reportId &&
        other.reportAttachment == reportAttachment;
  }

  @override
  int get hashCode =>
      id.hashCode ^ reportId.hashCode ^ reportAttachment.hashCode;
}
