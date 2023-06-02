import 'package:report_project/common/models/report_status_model.dart';
import 'package:report_project/common/services/report_status_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'report_status_controller.g.dart';

@Riverpod(keepAlive: true)
class ReportStatusController extends _$ReportStatusController {
  late final ReportStatusService _reportStatusService;

  FutureOr<List<ReportStatusModel>> _get() async {
    final res = await _reportStatusService.get();
    return res.fold((l) => [], (r) => r);
  }

  @override
  FutureOr<List<ReportStatusModel>> build() {
    _reportStatusService = ref.watch(reportStatusServiceProvider);
    return _get();
  }

  String findIdByName(String name) {
    return state.asData!.value.firstWhere((element) => element.name == name).id;
  }
}

// @Riverpod(keepAlive: true)
// class ReportStatusController extends _$ReportStatusController {
//   @override
//   List<ReportStatusModel> build() {
//     return const [
//       ReportStatusModel(
//         id: '3J5anfiVo8',
//         name: 'pending',
//         description: 'Report Pending',
//       ),
//       ReportStatusModel(
//         id: 'ETztkQmNBs',
//         name: 'approve',
//         description: 'Report Approve',
//       ),
//       ReportStatusModel(
//         id: 'ogtULuE5gA',
//         name: 'reject',
//         description: 'Report Reject',
//       ),
//     ];
//   }

//   ReportStatusModel findById(String id) {
//     return state.firstWhere((element) => element.id == id);
//   }

//   int findIndexById(String id) {
//     return state.indexWhere((element) => element.id == id);
//   }

//   String findIdForStatusPending() {
//     return state.firstWhere((element) => element.name == 'pending').id;
//   }

//   String findIdForStatusReject() {
//     return state.firstWhere((element) => element.name == 'reject').id;
//   }
// }
