import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:report_project/common/models/report_status_model.dart';
import 'package:report_project/data/constant_data.dart';
import 'package:report_project/data/dio_client.dart';
import 'package:report_project/data/token_manager.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'report_status_service.g.dart';

@Riverpod(keepAlive: true)
ReportStatusService reportStatusService(ReportStatusServiceRef ref) {
  return ReportStatusService(
    ref.watch(dioClientProvider),
    ref.watch(tokenManagerProvider),
  );
}

class ReportStatusService {
  final DioClient _dioClient;
  final TokenManager _tokenManager;

  ReportStatusService(this._dioClient, this._tokenManager);

  Future<Either<String, List<ReportStatusModel>>> get() async {
    final String? token = await _tokenManager.read();
    if (token == null) return left('Token not exitst');
    try {
      final res = await _dioClient.get(
        EndPoint.reportStatus,
        options: _dioClient.tokenOptions(token),
      );
      final data = res.data['data'] as List;
      return right(data.map((e) => ReportStatusModel.fromMap(e)).toList());
    } on DioError catch (e) {
      return left(e.toString());
    }
  }
}
