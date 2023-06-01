// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translate_position.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$translatePositionHash() => r'5d776033d01f4d0528ed7e1ed4b7c435d9b7ea51';

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

typedef TranslatePositionRef = AutoDisposeFutureProviderRef<String>;

/// See also [translatePosition].
@ProviderFor(translatePosition)
const translatePositionProvider = TranslatePositionFamily();

/// See also [translatePosition].
class TranslatePositionFamily extends Family<AsyncValue<String>> {
  /// See also [translatePosition].
  const TranslatePositionFamily();

  /// See also [translatePosition].
  TranslatePositionProvider call({
    required String position,
  }) {
    return TranslatePositionProvider(
      position: position,
    );
  }

  @override
  TranslatePositionProvider getProviderOverride(
    covariant TranslatePositionProvider provider,
  ) {
    return call(
      position: provider.position,
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
  String? get name => r'translatePositionProvider';
}

/// See also [translatePosition].
class TranslatePositionProvider extends AutoDisposeFutureProvider<String> {
  /// See also [translatePosition].
  TranslatePositionProvider({
    required this.position,
  }) : super.internal(
          (ref) => translatePosition(
            ref,
            position: position,
          ),
          from: translatePositionProvider,
          name: r'translatePositionProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$translatePositionHash,
          dependencies: TranslatePositionFamily._dependencies,
          allTransitiveDependencies:
              TranslatePositionFamily._allTransitiveDependencies,
        );

  final String position;

  @override
  bool operator ==(Object other) {
    return other is TranslatePositionProvider && other.position == position;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, position.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
