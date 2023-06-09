import 'package:report_project/admin/services/admin_project_priority_service.dart';
import 'package:report_project/common/models/project_priority/project_priority_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:report_project/common/models/project_priority/project_priority_calculate_model.dart';
import 'package:report_project/common/models/project_priority/time_span_model.dart';
import 'package:report_project/common/models/project_priority/money_estimate_model.dart';
import 'package:report_project/common/models/project_priority/manpower_model.dart';
import 'package:report_project/common/models/project_priority/material_feasibility_model.dart';

part 'admin_project_priority_controller.g.dart';

@riverpod
FutureOr<ProjectPriorityModel?> findProjectPriorityByProjectId(
  FindProjectPriorityByProjectIdRef ref, {
  required String projectId,
}) async {
  final projecPriorityService = ref.watch(adminProjectPriorityServiceProvider);
  final res = await projecPriorityService.findByProjectId(projectId);
  return res.fold((l) => null, (r) => r);
}

@riverpod
FutureOr<List<ProjectPriorityCalculateModel>> calculateProjectPriority(
  CalculateProjectPriorityRef ref, {
  required String timeSpan,
  required String moneyEstimate,
  required String manpower,
  required String materialFeasibility,
}) async {
  if (timeSpan.isEmpty ||
      moneyEstimate.isEmpty ||
      manpower.isEmpty ||
      materialFeasibility.isEmpty) {
    return [];
  }
  final projecPriorityService = ref.watch(adminProjectPriorityServiceProvider);
  final res = await projecPriorityService.calculate(
    timeSpan,
    moneyEstimate,
    manpower,
    materialFeasibility,
  );
  return res.fold((l) => [], (r) => r);
}

@Riverpod(keepAlive: true)
FutureOr<List<TimeSpanModel>> getTimeSpan(
  GetTimeSpanRef ref,
) async {
  final projecPriorityService = ref.watch(adminProjectPriorityServiceProvider);
  final res = await projecPriorityService.getTimeSpan();
  return res.fold((l) => [], (r) => r);
}

@Riverpod(keepAlive: true)
FutureOr<List<MoneyEstimateModel>> getMoneyEstimate(
  GetMoneyEstimateRef ref,
) async {
  final projecPriorityService = ref.watch(adminProjectPriorityServiceProvider);
  final res = await projecPriorityService.getMoneyEstimate();
  return res.fold((l) => [], (r) => r);
}

@Riverpod(keepAlive: true)
FutureOr<List<ManpowerModel>> getManpower(
  GetManpowerRef ref,
) async {
  final projecPriorityService = ref.watch(adminProjectPriorityServiceProvider);
  final res = await projecPriorityService.getManpower();
  return res.fold((l) => [], (r) => r);
}

@Riverpod(keepAlive: true)
FutureOr<List<MaterialFeasibilityModel>> getMaterialFeasibility(
  GetMaterialFeasibilityRef ref,
) async {
  final projecPriorityService = ref.watch(adminProjectPriorityServiceProvider);
  final res = await projecPriorityService.getMaterialFeasibility();
  return res.fold((l) => [], (r) => r);
}
