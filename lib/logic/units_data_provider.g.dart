// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'units_data_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$unitsDataNotifierHash() => r'ac67c749549eebe7526c0c16bc23ea2b61b8c11f';

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

abstract class _$UnitsDataNotifier
    extends BuildlessAutoDisposeNotifier<List<List<String>>> {
  late final int unitType;

  List<List<String>> build(
    int unitType,
  );
}

/// See also [UnitsDataNotifier].
@ProviderFor(UnitsDataNotifier)
const unitsDataNotifierProvider = UnitsDataNotifierFamily();

/// See also [UnitsDataNotifier].
class UnitsDataNotifierFamily extends Family<List<List<String>>> {
  /// See also [UnitsDataNotifier].
  const UnitsDataNotifierFamily();

  /// See also [UnitsDataNotifier].
  UnitsDataNotifierProvider call(
    int unitType,
  ) {
    return UnitsDataNotifierProvider(
      unitType,
    );
  }

  @override
  UnitsDataNotifierProvider getProviderOverride(
    covariant UnitsDataNotifierProvider provider,
  ) {
    return call(
      provider.unitType,
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
  String? get name => r'unitsDataNotifierProvider';
}

/// See also [UnitsDataNotifier].
class UnitsDataNotifierProvider extends AutoDisposeNotifierProviderImpl<
    UnitsDataNotifier, List<List<String>>> {
  /// See also [UnitsDataNotifier].
  UnitsDataNotifierProvider(
    int unitType,
  ) : this._internal(
          () => UnitsDataNotifier()..unitType = unitType,
          from: unitsDataNotifierProvider,
          name: r'unitsDataNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$unitsDataNotifierHash,
          dependencies: UnitsDataNotifierFamily._dependencies,
          allTransitiveDependencies:
              UnitsDataNotifierFamily._allTransitiveDependencies,
          unitType: unitType,
        );

  UnitsDataNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.unitType,
  }) : super.internal();

  final int unitType;

  @override
  List<List<String>> runNotifierBuild(
    covariant UnitsDataNotifier notifier,
  ) {
    return notifier.build(
      unitType,
    );
  }

  @override
  Override overrideWith(UnitsDataNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: UnitsDataNotifierProvider._internal(
        () => create()..unitType = unitType,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        unitType: unitType,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<UnitsDataNotifier, List<List<String>>>
      createElement() {
    return _UnitsDataNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UnitsDataNotifierProvider && other.unitType == unitType;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, unitType.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UnitsDataNotifierRef
    on AutoDisposeNotifierProviderRef<List<List<String>>> {
  /// The parameter `unitType` of this provider.
  int get unitType;
}

class _UnitsDataNotifierProviderElement
    extends AutoDisposeNotifierProviderElement<UnitsDataNotifier,
        List<List<String>>> with UnitsDataNotifierRef {
  _UnitsDataNotifierProviderElement(super.provider);

  @override
  int get unitType => (origin as UnitsDataNotifierProvider).unitType;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
