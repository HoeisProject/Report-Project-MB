// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/foundation.dart';

enum ReportStatusEnum {
  pending, // 0
  approve, // 1
  reject, // 2
}

enum ReportStatusModelEnum {
  objectId,
  name,
  description,
}

@immutable
class ReportStatusModel {
  final String id;
  final String name;
  final String description;
  const ReportStatusModel({
    required this.id,
    required this.name,
    required this.description,
  });
}
