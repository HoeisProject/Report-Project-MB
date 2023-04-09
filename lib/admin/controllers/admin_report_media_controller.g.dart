// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_report_media_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getAdminReportMediaHash() =>
    r'cfc241799ca90e4aace4f6c2c8f16c85c8bbb052';

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

typedef GetAdminReportMediaRef
    = AutoDisposeFutureProviderRef<List<ReportMediaModel>>;

/// See also [getAdminReportMedia].
@ProviderFor(getAdminReportMedia)
const getAdminReportMediaProvider = GetAdminReportMediaFamily();

/// See also [getAdminReportMedia].
class GetAdminReportMediaFamily
    extends Family<AsyncValue<List<ReportMediaModel>>> {
  /// See also [getAdminReportMedia].
  const GetAdminReportMediaFamily();

  /// See also [getAdminReportMedia].
  GetAdminReportMediaProvider call({
    required String reportId,
  }) {
    return GetAdminReportMediaProvider(
      reportId: reportId,
    );
  }

  @override
  GetAdminReportMediaProvider getProviderOverride(
    covariant GetAdminReportMediaProvider provider,
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
  String? get name => r'getAdminReportMediaProvider';
}

/// See also [getAdminReportMedia].
class GetAdminReportMediaProvider
    extends AutoDisposeFutureProvider<List<ReportMediaModel>> {
  /// See also [getAdminReportMedia].
  GetAdminReportMediaProvider({
    required this.reportId,
  }) : super.internal(
          (ref) => getAdminReportMedia(
            ref,
            reportId: reportId,
          ),
          from: getAdminReportMediaProvider,
          name: r'getAdminReportMediaProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getAdminReportMediaHash,
          dependencies: GetAdminReportMediaFamily._dependencies,
          allTransitiveDependencies:
              GetAdminReportMediaFamily._allTransitiveDependencies,
        );

  final String reportId;

  @override
  bool operator ==(Object other) {
    return other is GetAdminReportMediaProvider && other.reportId == reportId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, reportId.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
