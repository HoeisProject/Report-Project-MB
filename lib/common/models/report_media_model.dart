// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

enum ReportMediaModelEnum {
  objectId,
  reportId,
  attachment,
}

@immutable
class ReportMediaModel {
  final String id;
  final String reportId;
  final String attachment;
  const ReportMediaModel({
    required this.id,
    required this.reportId,
    required this.attachment,
  });

  factory ReportMediaModel.fromParseObject(ParseObject parse) {
    return ReportMediaModel(
      id: parse.get<String>(ReportMediaModelEnum.objectId.name)!,
      reportId: parse.get<String>(ReportMediaModelEnum.reportId.name)!,
      attachment:
          parse.get<ParseFile>(ReportMediaModelEnum.attachment.name)!.url ?? '',
    );
  }

  ReportMediaModel copyWith({
    String? id,
    String? reportId,
    String? attachment,
  }) {
    return ReportMediaModel(
      id: id ?? this.id,
      reportId: reportId ?? this.reportId,
      attachment: attachment ?? this.attachment,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'reportId': reportId,
      'attachment': attachment,
    };
  }

  factory ReportMediaModel.fromMap(Map<String, dynamic> map) {
    return ReportMediaModel(
      id: map['id'] as String,
      reportId: map['reportId'] as String,
      attachment: map['attachment'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReportMediaModel.fromJson(String source) =>
      ReportMediaModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ReportMediaModel(id: $id, reportId: $reportId, attachment: $attachment)';

  @override
  bool operator ==(covariant ReportMediaModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.reportId == reportId &&
        other.attachment == attachment;
  }

  @override
  int get hashCode => id.hashCode ^ reportId.hashCode ^ attachment.hashCode;
}
