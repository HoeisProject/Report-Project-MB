// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_media_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getReportMediaHash() => r'173a0ae634eaa03af0728e4080d4d4a073806662';

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

typedef GetReportMediaRef
    = AutoDisposeFutureProviderRef<List<ReportMediaModel>>;

/// See also [getReportMedia].
@ProviderFor(getReportMedia)
const getReportMediaProvider = GetReportMediaFamily();

/// See also [getReportMedia].
class GetReportMediaFamily extends Family<AsyncValue<List<ReportMediaModel>>> {
  /// See also [getReportMedia].
  const GetReportMediaFamily();

  /// See also [getReportMedia].
  GetReportMediaProvider call({
    required String reportId,
  }) {
    return GetReportMediaProvider(
      reportId: reportId,
    );
  }

  @override
  GetReportMediaProvider getProviderOverride(
    covariant GetReportMediaProvider provider,
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
  String? get name => r'getReportMediaProvider';
}

/// See also [getReportMedia].
class GetReportMediaProvider
    extends AutoDisposeFutureProvider<List<ReportMediaModel>> {
  /// See also [getReportMedia].
  GetReportMediaProvider({
    required this.reportId,
  }) : super.internal(
          (ref) => getReportMedia(
            ref,
            reportId: reportId,
          ),
          from: getReportMediaProvider,
          name: r'getReportMediaProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getReportMediaHash,
          dependencies: GetReportMediaFamily._dependencies,
          allTransitiveDependencies:
              GetReportMediaFamily._allTransitiveDependencies,
        );

  final String reportId;

  @override
  bool operator ==(Object other) {
    return other is GetReportMediaProvider && other.reportId == reportId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, reportId.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
