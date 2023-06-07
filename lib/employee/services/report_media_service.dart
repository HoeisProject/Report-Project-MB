import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:report_project/common/models/report_media_model.dart';
import 'package:report_project/data/constant_data.dart';
import 'package:report_project/data/dio_client.dart';
import 'package:report_project/data/token_manager.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'report_media_service.g.dart';

@Riverpod(keepAlive: true)
ReportMediaService reportMediaService(ReportMediaServiceRef ref) {
  return ReportMediaService(
    ref.watch(dioClientProvider),
    ref.watch(tokenManagerProvider),
  );
}

class ReportMediaService {
  final DioClient _dioClient;
  final TokenManager _tokenManager;

  ReportMediaService(this._dioClient, this._tokenManager);

  Future<Either<String, List<ReportMediaModel>>> get(String reportId) async {
    final String? token = await _tokenManager.read();
    if (token == null) return left('Token not exist');
    try {
      final res = await _dioClient.get(
        '${EndPoint.report}/$reportId/${EndPoint.reportMedia}',
        options: _dioClient.tokenOptions(token),
      );
      final data = res.data['data'] as List;
      return right(data.map((e) => ReportMediaModel.fromMap(e)).toList());
    } on DioException catch (e) {
      return left(e.toString());
    }
  }

  Future<String> create(
    String reportId,
    String imagePath,
  ) async {
    try {
      final String? token = await _tokenManager.read();
      if (token == null) return 'Token not exist';
      FormData formData = FormData.fromMap({
        ReportMediaModelEnum.reportId.value: reportId,
        ReportMediaModelEnum.attachment.value:
            await MultipartFile.fromFile(imagePath)
      });
      await _dioClient.post(
        EndPoint.reportMedia,
        options: _dioClient.tokenOptions(token),
        data: formData,
      );
      return '';
    } on DioException catch (e) {
      return e.toString();
    }
  }
}
