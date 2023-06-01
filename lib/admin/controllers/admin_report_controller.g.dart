// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_report_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getAdminReportByProjectHash() =>
    r'3ae29e4a4de1a905e30dd4d341942999c8b23df7';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

typedef GetAdminReportByProjectRef
    = AutoDisposeFutureProviderRef<List<ReportModel>>;

/// See also [getAdminReportByProject].
@ProviderFor(getAdminReportByProject)
const getAdminReportByProjectProvider = GetAdminReportByProjectFamily();

/// See also [getAdminReportByProject].
class GetAdminReportByProjectFamily
    extends Family<AsyncValue<List<ReportModel>>> {
  /// See also [getAdminReportByProject].
  const GetAdminReportByProjectFamily();

  /// See also [getAdminReportByProject].
  GetAdminReportByProjectProvider call({
    required String projectId,
  }) {
    return GetAdminReportByProjectProvider(
      projectId: projectId,
    );
  }

  @override
  GetAdminReportByProjectProvider getProviderOverride(
    covariant GetAdminReportByProjectProvider provider,
  ) {
    return call(
      projectId: provider.projectId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getAdminReportByProjectProvider';
}

/// See also [getAdminReportByProject].
class GetAdminReportByProjectProvider
    extends AutoDisposeFutureProvider<List<ReportModel>> {
  /// See also [getAdminReportByProject].
  GetAdminReportByProjectProvider({
    required this.projectId,
  }) : super.internal(
          (ref) => getAdminReportByProject(
            ref,
            projectId: projectId,
          ),
          from: getAdminReportByProjectProvider,
          name: r'getAdminReportByProjectProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getAdminReportByProjectHash,
          dependencies: GetAdminReportByProjectFamily._dependencies,
          allTransitiveDependencies:
              GetAdminReportByProjectFamily._allTransitiveDependencies,
        );

  final String projectId;

  @override
  bool operator ==(Object other) {
    return other is GetAdminReportByProjectProvider &&
        other.projectId == projectId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, projectId.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$reportRejectedControllerHash() =>
    r'6c0a7650a17f5d094b9db8eb5e03f5d0b222e189';

/// See also [reportRejectedController].
@ProviderFor(reportRejectedController)
final reportRejectedControllerProvider =
    FutureProvider<List<ReportModel>>.internal(
  reportRejectedController,
  name: r'reportRejectedControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$reportRejectedControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ReportRejectedControllerRef = FutureProviderRef<List<ReportModel>>;
String _$adminReportControllerHash() =>
    r'8138340e36f930bf174980c9076d7d90eab4a7c5';

/// See also [AdminReportController].
@ProviderFor(AdminReportController)
final adminReportControllerProvider =
    AsyncNotifierProvider<AdminReportController, List<ReportModel>>.internal(
  AdminReportController.new,
  name: r'adminReportControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$adminReportControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AdminReportController = AsyncNotifier<List<ReportModel>>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
