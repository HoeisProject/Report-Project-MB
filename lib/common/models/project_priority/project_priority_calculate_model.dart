// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:report_project/common/models/project_model.dart';

enum ProjectPriorityCalculateModelEnum {
  timeSpan('time_span'),
  moneyEstimate('money_estimate'),
  manpower('manpower'),
  materialFeasibility('material_feasibility'),
  timeSpanWeight('time_span_weight'),
  moneyEstimateWeight('money_estimate_weight'),
  manpowerWeight('manpower_weight'),
  materialFeasibilityWeight('material_feasibility_weight'),
  v('v'),
  project('project');

  const ProjectPriorityCalculateModelEnum(this.value);
  final String value;
}

@immutable
class ProjectPriorityCalculateModel {
  final double timeSpanWeight;
  final double moneyEstimateWeight;
  final double manpowerWeight;
  final double materialFeasibilityWeight;
  final double v;
  final ProjectModel? project;
  const ProjectPriorityCalculateModel({
    required this.timeSpanWeight,
    required this.moneyEstimateWeight,
    required this.manpowerWeight,
    required this.materialFeasibilityWeight,
    required this.v,
    this.project,
  });

  ProjectPriorityCalculateModel copyWith({
    double? timeSpanWeight,
    double? moneyEstimateWeight,
    double? manpowerWeight,
    double? materialFeasibilityWeight,
    double? v,
    ProjectModel? project,
  }) {
    return ProjectPriorityCalculateModel(
      timeSpanWeight: timeSpanWeight ?? this.timeSpanWeight,
      moneyEstimateWeight: moneyEstimateWeight ?? this.moneyEstimateWeight,
      manpowerWeight: manpowerWeight ?? this.manpowerWeight,
      materialFeasibilityWeight:
          materialFeasibilityWeight ?? this.materialFeasibilityWeight,
      v: v ?? this.v,
      project: project ?? this.project,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      ProjectPriorityCalculateModelEnum.timeSpanWeight.value: timeSpanWeight,
      ProjectPriorityCalculateModelEnum.moneyEstimateWeight.value:
          moneyEstimateWeight,
      ProjectPriorityCalculateModelEnum.manpowerWeight.value: manpowerWeight,
      ProjectPriorityCalculateModelEnum.materialFeasibilityWeight.value:
          materialFeasibilityWeight,
      ProjectPriorityCalculateModelEnum.v.value: v,
      ProjectPriorityCalculateModelEnum.project.value: project?.toMap(),
    };
  }

  factory ProjectPriorityCalculateModel.fromMap(Map<String, dynamic> map) {
    debugPrint(map.toString());
    return ProjectPriorityCalculateModel(
      timeSpanWeight:
          map[ProjectPriorityCalculateModelEnum.timeSpanWeight.value]
              .toDouble(),
      moneyEstimateWeight:
          map[ProjectPriorityCalculateModelEnum.moneyEstimateWeight.value]
              .toDouble(),
      manpowerWeight:
          map[ProjectPriorityCalculateModelEnum.manpowerWeight.value]
              .toDouble(),
      materialFeasibilityWeight:
          map[ProjectPriorityCalculateModelEnum.materialFeasibilityWeight.value]
              .toDouble(),
      v: map[ProjectPriorityCalculateModelEnum.v.value].toDouble(),
      project: map[ProjectPriorityCalculateModelEnum.project.value] != null
          ? ProjectModel.fromMap(
              map[ProjectPriorityCalculateModelEnum.project.value]
                  as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProjectPriorityCalculateModel.fromJson(String source) =>
      ProjectPriorityCalculateModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProjectPriorityCalculateModel(timeSpanWeight: $timeSpanWeight, moneyEstimateWeight: $moneyEstimateWeight, manpowerWeight: $manpowerWeight, materialFeasibilityWeight: $materialFeasibilityWeight, v: $v, project: $project)';
  }

  @override
  bool operator ==(covariant ProjectPriorityCalculateModel other) {
    if (identical(this, other)) return true;

    return other.timeSpanWeight == timeSpanWeight &&
        other.moneyEstimateWeight == moneyEstimateWeight &&
        other.manpowerWeight == manpowerWeight &&
        other.materialFeasibilityWeight == materialFeasibilityWeight &&
        other.v == v &&
        other.project == project;
  }

  @override
  int get hashCode {
    return timeSpanWeight.hashCode ^
        moneyEstimateWeight.hashCode ^
        manpowerWeight.hashCode ^
        materialFeasibilityWeight.hashCode ^
        v.hashCode ^
        project.hashCode;
  }
}
