// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:report_project/common/models/project_priority/manpower_model.dart';
import 'package:report_project/common/models/project_priority/material_feasibility_model.dart';
import 'package:report_project/common/models/project_priority/money_estimate_model.dart';
import 'package:report_project/common/models/project_priority/time_span_model.dart';

enum ProjectPriorityModelEnum {
  id('id'),
  projectId('project_id'),
  timeSpanId('time_span_id'),
  timeSpan('time_span'),

  moneyEstimateId('money_estimate_id'),
  moneyEstimate('money_estimate'),

  manpowerId('manpower_id'),
  manpower('manpower'),

  materialFeasibilityId('material_feasibility_id'),
  materialFeasibility('material_feasibility');

  const ProjectPriorityModelEnum(this.value);
  final String value;
}

@immutable
class ProjectPriorityModel {
  final String id;
  final String projectId;
  final TimeSpanModel timeSpan;
  final MoneyEstimateModel moneyEstimate;
  final ManpowerModel manpower;
  final MaterialFeasibilityModel materialFeasibility;
  const ProjectPriorityModel({
    required this.id,
    required this.projectId,
    required this.timeSpan,
    required this.moneyEstimate,
    required this.manpower,
    required this.materialFeasibility,
  });

  ProjectPriorityModel copyWith({
    String? id,
    String? projectId,
    TimeSpanModel? timeSpan,
    MoneyEstimateModel? moneyEstimate,
    ManpowerModel? manpower,
    MaterialFeasibilityModel? materialFeasibility,
  }) {
    return ProjectPriorityModel(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      timeSpan: timeSpan ?? this.timeSpan,
      moneyEstimate: moneyEstimate ?? this.moneyEstimate,
      manpower: manpower ?? this.manpower,
      materialFeasibility: materialFeasibility ?? this.materialFeasibility,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      ProjectPriorityModelEnum.id.value: id,
      ProjectPriorityModelEnum.projectId.value: projectId,
      ProjectPriorityModelEnum.timeSpan.value: timeSpan.toMap(),
      ProjectPriorityModelEnum.moneyEstimate.value: moneyEstimate.toMap(),
      ProjectPriorityModelEnum.manpower.value: manpower.toMap(),
      ProjectPriorityModelEnum.materialFeasibility.value:
          materialFeasibility.toMap(),
    };
  }

  factory ProjectPriorityModel.fromMap(Map<String, dynamic> map) {
    return ProjectPriorityModel(
      id: map[ProjectPriorityModelEnum.id.value] as String,
      projectId: map[ProjectPriorityModelEnum.projectId.value] as String,
      timeSpan: TimeSpanModel.fromMap(
          map[ProjectPriorityModelEnum.timeSpan.value] as Map<String, dynamic>),
      moneyEstimate: MoneyEstimateModel.fromMap(
          map[ProjectPriorityModelEnum.moneyEstimate.value]
              as Map<String, dynamic>),
      manpower: ManpowerModel.fromMap(
          map[ProjectPriorityModelEnum.manpower.value] as Map<String, dynamic>),
      materialFeasibility: MaterialFeasibilityModel.fromMap(
          map[ProjectPriorityModelEnum.materialFeasibility.value]
              as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProjectPriorityModel.fromJson(String source) =>
      ProjectPriorityModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProjectPriorityModel(id: $id, projectId: $projectId, timeSpan: $timeSpan, moneyEstimate: $moneyEstimate, manpower: $manpower, materialFeasibility: $materialFeasibility)';
  }

  @override
  bool operator ==(covariant ProjectPriorityModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.projectId == projectId &&
        other.timeSpan == timeSpan &&
        other.moneyEstimate == moneyEstimate &&
        other.manpower == manpower &&
        other.materialFeasibility == materialFeasibility;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        projectId.hashCode ^
        timeSpan.hashCode ^
        moneyEstimate.hashCode ^
        manpower.hashCode ^
        materialFeasibility.hashCode;
  }
}
