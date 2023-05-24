import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:report_project/common/models/role_model.dart';
import 'package:report_project/data/constant_data.dart';
import 'package:report_project/data/dio_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'role_service.g.dart';

@Riverpod(keepAlive: true)
RoleService roleService(RoleServiceRef ref) {
  return RoleService(ref.watch(dioClientProvider));
}

class RoleService {
  final DioClient _dioClient;

  RoleService(this._dioClient);

  Future<Either<String, List<RoleModel>>> get() async {
    try {
      final Response res = await _dioClient.get(
        EndPoint.role,
        options: _dioClient.tokenOptions(
          '1|JN1QSq1FFA7BvMcjVP0qNmmdJuvQqkH1JJTyjdv5',
        ),
      );
      final data = ((res.data['data']) as List);
      final roles = data.map((e) => RoleModel.fromMap(e)).toList();
      return right(roles);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<String> ping() async {
    final Response res = await _dioClient.get(EndPoint.ping);
    return res.data as String;
  }
}
