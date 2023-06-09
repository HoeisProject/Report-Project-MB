// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_report_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$findAdminReportByProjectHash() =>
    r'7a17cee8b0a1d553acf2ee223c8892112fe32449';

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

typedef FindAdminReportByProjectRef
    = AutoDisposeFutureProviderRef<List<ReportModel>>;

/// See also [findAdminReportByProject].
@ProviderFor(findAdminReportByProject)
const findAdminReportByProjectProvider = FindAdminReportByProjectFamily();

/// See also [findAdminReportByProject].
class FindAdminReportByProjectFamily
    extends Family<AsyncValue<List<ReportModel>>> {
  /// See also [findAdminReportByProject].
  const FindAdminReportByProjectFamily();

  /// See also [findAdminReportByProject].
  FindAdminReportByProjectProvider call({
    required String projectId,
    required bool showOnlyRejected,
  }) {
    return FindAdminReportByProjectProvider(
      projectId: projectId,
      showOnlyRejected: showOnlyRejected,
    );
  }

  @override
  FindAdminReportByProjectProvider getProviderOverride(
    covariant FindAdminReportByProjectProvider provider,
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
  String? get name => r'findAdminReportByProjectProvider';
}

/// See also [findAdminReportByProject].
class FindAdminReportByProjectProvider
    extends AutoDisposeFutureProvider<List<ReportModel>> {
  /// See also [findAdminReportByProject].
  FindAdminReportByProjectProvider({
    required this.projectId,
    required this.showOnlyRejected,
  }) : super.internal(
          (ref) => findAdminReportByProject(
            ref,
            projectId: projectId,
            showOnlyRejected: showOnlyRejected,
          ),
          from: findAdminReportByProjectProvider,
          name: r'findAdminReportByProjectProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$findAdminReportByProjectHash,
          dependencies: FindAdminReportByProjectFamily._dependencies,
          allTransitiveDependencies:
              FindAdminReportByProjectFamily._allTransitiveDependencies,
        );

  final String projectId;
  final bool showOnlyRejected;

  @override
  bool operator ==(Object other) {
    return other is FindAdminReportByProjectProvider &&
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

String _$adminReportControllerHash() =>
    r'3eb0b143105966ba7b466e8ef965e449d26e6276';

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
