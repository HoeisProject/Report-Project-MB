// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:report_project/data/constant_data.dart';

enum ReportMediaModelEnum {
  id('id'),
  reportId('report_id'),
  attachment('attachment');

  const ReportMediaModelEnum(this.value);
  final String value;
}

@immutable
class ReportMediaModel {
  final String id;
  final String? reportId;
  final String attachment;
  const ReportMediaModel({
    required this.id,
    this.reportId,
    required this.attachment,
  });

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
      ReportMediaModelEnum.id.value: id,
      ReportMediaModelEnum.reportId.value: reportId,
      ReportMediaModelEnum.attachment.value: attachment,
    };
  }

  factory ReportMediaModel.fromMap(Map<String, dynamic> map) {
    return ReportMediaModel(
      id: map[ReportMediaModelEnum.id.value] as String,
      reportId: map[ReportMediaModelEnum.reportId.value],
      attachment:
          ConstantApi.baseUrl + map[ReportMediaModelEnum.attachment.value],
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
