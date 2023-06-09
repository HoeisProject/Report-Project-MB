// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_project_priority_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$findProjectPriorityByProjectIdHash() =>
    r'a29ec0092bec454a4fea66279c9e616defb42fe4';

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

typedef FindProjectPriorityByProjectIdRef
    = AutoDisposeFutureProviderRef<ProjectPriorityModel?>;

/// See also [findProjectPriorityByProjectId].
@ProviderFor(findProjectPriorityByProjectId)
const findProjectPriorityByProjectIdProvider =
    FindProjectPriorityByProjectIdFamily();

/// See also [findProjectPriorityByProjectId].
class FindProjectPriorityByProjectIdFamily
    extends Family<AsyncValue<ProjectPriorityModel?>> {
  /// See also [findProjectPriorityByProjectId].
  const FindProjectPriorityByProjectIdFamily();

  /// See also [findProjectPriorityByProjectId].
  FindProjectPriorityByProjectIdProvider call({
    required String projectId,
  }) {
    return FindProjectPriorityByProjectIdProvider(
      projectId: projectId,
    );
  }

  @override
  FindProjectPriorityByProjectIdProvider getProviderOverride(
    covariant FindProjectPriorityByProjectIdProvider provider,
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
  String? get name => r'findProjectPriorityByProjectIdProvider';
}

/// See also [findProjectPriorityByProjectId].
class FindProjectPriorityByProjectIdProvider
    extends AutoDisposeFutureProvider<ProjectPriorityModel?> {
  /// See also [findProjectPriorityByProjectId].
  FindProjectPriorityByProjectIdProvider({
    required this.projectId,
  }) : super.internal(
          (ref) => findProjectPriorityByProjectId(
            ref,
            projectId: projectId,
          ),
          from: findProjectPriorityByProjectIdProvider,
          name: r'findProjectPriorityByProjectIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$findProjectPriorityByProjectIdHash,
          dependencies: FindProjectPriorityByProjectIdFamily._dependencies,
          allTransitiveDependencies:
              FindProjectPriorityByProjectIdFamily._allTransitiveDependencies,
        );

  final String projectId;

  @override
  bool operator ==(Object other) {
    return other is FindProjectPriorityByProjectIdProvider &&
        other.projectId == projectId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, projectId.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$calculateProjectPriorityHash() =>
    r'1c31a311f4ac6904eee49ea720ecf30f7304ac08';
typedef CalculateProjectPriorityRef
    = AutoDisposeFutureProviderRef<List<ProjectPriorityCalculateModel>>;

/// See also [calculateProjectPriority].
@ProviderFor(calculateProjectPriority)
const calculateProjectPriorityProvider = CalculateProjectPriorityFamily();

/// See also [calculateProjectPriority].
class CalculateProjectPriorityFamily
    extends Family<AsyncValue<List<ProjectPriorityCalculateModel>>> {
  /// See also [calculateProjectPriority].
  const CalculateProjectPriorityFamily();

  /// See also [calculateProjectPriority].
  CalculateProjectPriorityProvider call({
    required String timeSpan,
    required String moneyEstimate,
    required String manpower,
    required String materialFeasibility,
  }) {
    return CalculateProjectPriorityProvider(
      timeSpan: timeSpan,
      moneyEstimate: moneyEstimate,
      manpower: manpower,
      materialFeasibility: materialFeasibility,
    );
  }

  @override
  CalculateProjectPriorityProvider getProviderOverride(
    covariant CalculateProjectPriorityProvider provider,
  ) {
    return call(
      timeSpan: provider.timeSpan,
      moneyEstimate: provider.moneyEstimate,
      manpower: provider.manpower,
      materialFeasibility: provider.materialFeasibility,
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
  String? get name => r'calculateProjectPriorityProvider';
}

/// See also [calculateProjectPriority].
class CalculateProjectPriorityProvider
    extends AutoDisposeFutureProvider<List<ProjectPriorityCalculateModel>> {
  /// See also [calculateProjectPriority].
  CalculateProjectPriorityProvider({
    required this.timeSpan,
    required this.moneyEstimate,
    required this.manpower,
    required this.materialFeasibility,
  }) : super.internal(
          (ref) => calculateProjectPriority(
            ref,
            timeSpan: timeSpan,
            moneyEstimate: moneyEstimate,
            manpower: manpower,
            materialFeasibility: materialFeasibility,
          ),
          from: calculateProjectPriorityProvider,
          name: r'calculateProjectPriorityProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$calculateProjectPriorityHash,
          dependencies: CalculateProjectPriorityFamily._dependencies,
          allTransitiveDependencies:
              CalculateProjectPriorityFamily._allTransitiveDependencies,
        );

  final String timeSpan;
  final String moneyEstimate;
  final String manpower;
  final String materialFeasibility;

  @override
  bool operator ==(Object other) {
    return other is CalculateProjectPriorityProvider &&
        other.timeSpan == timeSpan &&
        other.moneyEstimate == moneyEstimate &&
        other.manpower == manpower &&
        other.materialFeasibility == materialFeasibility;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, timeSpan.hashCode);
    hash = _SystemHash.combine(hash, moneyEstimate.hashCode);
    hash = _SystemHash.combine(hash, manpower.hashCode);
    hash = _SystemHash.combine(hash, materialFeasibility.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$getTimeSpanHash() => r'c8961d5b957a2512819a50db23ba14eb7313fd6e';

/// See also [getTimeSpan].
@ProviderFor(getTimeSpan)
final getTimeSpanProvider = FutureProvider<List<TimeSpanModel>>.internal(
  getTimeSpan,
  name: r'getTimeSpanProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getTimeSpanHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetTimeSpanRef = FutureProviderRef<List<TimeSpanModel>>;
String _$getMoneyEstimateHash() => r'928381ea81ddc8079fd9d10a0e4da6e025b11550';

/// See also [getMoneyEstimate].
@ProviderFor(getMoneyEstimate)
final getMoneyEstimateProvider =
    FutureProvider<List<MoneyEstimateModel>>.internal(
  getMoneyEstimate,
  name: r'getMoneyEstimateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getMoneyEstimateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetMoneyEstimateRef = FutureProviderRef<List<MoneyEstimateModel>>;
String _$getManpowerHash() => r'0918deacd5a58a3e19e95e7f14f9b2aa83f791b2';

/// See also [getManpower].
@ProviderFor(getManpower)
final getManpowerProvider = FutureProvider<List<ManpowerModel>>.internal(
  getManpower,
  name: r'getManpowerProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getManpowerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetManpowerRef = FutureProviderRef<List<ManpowerModel>>;
String _$getMaterialFeasibilityHash() =>
    r'0a5c22edbed776430f6ffddb84fe2388557afb1c';

/// See also [getMaterialFeasibility].
@ProviderFor(getMaterialFeasibility)
final getMaterialFeasibilityProvider =
    FutureProvider<List<MaterialFeasibilityModel>>.internal(
  getMaterialFeasibility,
  name: r'getMaterialFeasibilityProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getMaterialFeasibilityHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetMaterialFeasibilityRef
    = FutureProviderRef<List<MaterialFeasibilityModel>>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
