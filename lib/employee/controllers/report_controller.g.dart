// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getReportByProjectHash() =>
    r'2c02397fa6fa3a83a5432a0d89cbe972024a654c';

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

typedef GetReportByProjectRef = AutoDisposeFutureProviderRef<List<ReportModel>>;

/// See also [getReportByProject].
@ProviderFor(getReportByProject)
const getReportByProjectProvider = GetReportByProjectFamily();

/// See also [getReportByProject].
class GetReportByProjectFamily extends Family<AsyncValue<List<ReportModel>>> {
  /// See also [getReportByProject].
  const GetReportByProjectFamily();

  /// See also [getReportByProject].
  GetReportByProjectProvider call({
    required String projectId,
    required bool showOnlyRejected,
  }) {
    return GetReportByProjectProvider(
      projectId: projectId,
      showOnlyRejected: showOnlyRejected,
    );
  }

  @override
  GetReportByProjectProvider getProviderOverride(
    covariant GetReportByProjectProvider provider,
  ) {
    return call(
      projectId: provider.projectId,
      showOnlyRejected: provider.showOnlyRejected,
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
  String? get name => r'getReportByProjectProvider';
}

/// See also [getReportByProject].
class GetReportByProjectProvider
    extends AutoDisposeFutureProvider<List<ReportModel>> {
  /// See also [getReportByProject].
  GetReportByProjectProvider({
    required this.projectId,
    required this.showOnlyRejected,
  }) : super.internal(
          (ref) => getReportByProject(
            ref,
            projectId: projectId,
            showOnlyRejected: showOnlyRejected,
          ),
          from: getReportByProjectProvider,
          name: r'getReportByProjectProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getReportByProjectHash,
          dependencies: GetReportByProjectFamily._dependencies,
          allTransitiveDependencies:
              GetReportByProjectFamily._allTransitiveDependencies,
        );

  final String projectId;
  final bool showOnlyRejected;

  @override
  bool operator ==(Object other) {
    return other is GetReportByProjectProvider &&
        other.projectId == projectId &&
        other.showOnlyRejected == showOnlyRejected;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, projectId.hashCode);
    hash = _SystemHash.combine(hash, showOnlyRejected.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$reportControllerHash() => r'361001e0e30e14a31bfe863357d7b6886736140d';

/// See also [ReportController].
@ProviderFor(ReportController)
final reportControllerProvider =
    AsyncNotifierProvider<ReportController, List<ReportModel>>.internal(
  ReportController.new,
  name: r'reportControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$reportControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ReportController = AsyncNotifier<List<ReportModel>>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
