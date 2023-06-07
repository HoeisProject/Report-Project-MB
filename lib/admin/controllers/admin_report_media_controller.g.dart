// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_report_media_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getAdminReportMediaByReportHash() =>
    r'9cf5c593e386f63afce74302be58445e6ae4e226';

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

typedef GetAdminReportMediaByReportRef
    = AutoDisposeFutureProviderRef<List<ReportMediaModel>>;

/// See also [getAdminReportMediaByReport].
@ProviderFor(getAdminReportMediaByReport)
const getAdminReportMediaByReportProvider = GetAdminReportMediaByReportFamily();

/// See also [getAdminReportMediaByReport].
class GetAdminReportMediaByReportFamily
    extends Family<AsyncValue<List<ReportMediaModel>>> {
  /// See also [getAdminReportMediaByReport].
  const GetAdminReportMediaByReportFamily();

  /// See also [getAdminReportMediaByReport].
  GetAdminReportMediaByReportProvider call({
    required String reportId,
  }) {
    return GetAdminReportMediaByReportProvider(
      reportId: reportId,
    );
  }

  @override
  GetAdminReportMediaByReportProvider getProviderOverride(
    covariant GetAdminReportMediaByReportProvider provider,
  ) {
    return call(
      reportId: provider.reportId,
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
  String? get name => r'getAdminReportMediaByReportProvider';
}

/// See also [getAdminReportMediaByReport].
class GetAdminReportMediaByReportProvider
    extends AutoDisposeFutureProvider<List<ReportMediaModel>> {
  /// See also [getAdminReportMediaByReport].
  GetAdminReportMediaByReportProvider({
    required this.reportId,
  }) : super.internal(
          (ref) => getAdminReportMediaByReport(
            ref,
            reportId: reportId,
          ),
          from: getAdminReportMediaByReportProvider,
          name: r'getAdminReportMediaByReportProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getAdminReportMediaByReportHash,
          dependencies: GetAdminReportMediaByReportFamily._dependencies,
          allTransitiveDependencies:
              GetAdminReportMediaByReportFamily._allTransitiveDependencies,
        );

  final String reportId;

  @override
  bool operator ==(Object other) {
    return other is GetAdminReportMediaByReportProvider &&
        other.reportId == reportId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, reportId.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
