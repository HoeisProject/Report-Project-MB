import 'package:flutter/foundation.dart';

enum RoleModelNameEnum {
  admin,
  employee,
}

enum RoleModelEnum {
  objectId,
  name,
  description,
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
