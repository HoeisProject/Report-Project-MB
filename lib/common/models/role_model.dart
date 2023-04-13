import 'package:flutter/foundation.dart';

enum RoleModelEnum {
  admin,
  employee,
}

@immutable
class RoleModel {
  final String id;
  final String name;
  final String description;
  const RoleModel({
    required this.id,
    required this.name,
    required this.description,
  });
}
