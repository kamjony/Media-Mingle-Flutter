// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thumbnail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$thumbnailHash() => r'e28d57845f1a3d731d70e4ef251b9c4d3a81bc86';

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

/// See also [thumbnail].
@ProviderFor(thumbnail)
const thumbnailProvider = ThumbnailFamily();

/// See also [thumbnail].
class ThumbnailFamily extends Family<AsyncValue<ImageWithAspectRatio>> {
  /// See also [thumbnail].
  const ThumbnailFamily();

  /// See also [thumbnail].
  ThumbnailProvider call({
    required ThumbnailRequest request,
  }) {
    return ThumbnailProvider(
      request: request,
    );
  }

  @override
  ThumbnailProvider getProviderOverride(
    covariant ThumbnailProvider provider,
  ) {
    return call(
      request: provider.request,
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
  String? get name => r'thumbnailProvider';
}

/// See also [thumbnail].
class ThumbnailProvider
    extends AutoDisposeFutureProvider<ImageWithAspectRatio> {
  /// See also [thumbnail].
  ThumbnailProvider({
    required ThumbnailRequest request,
  }) : this._internal(
          (ref) => thumbnail(
            ref as ThumbnailRef,
            request: request,
          ),
          from: thumbnailProvider,
          name: r'thumbnailProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$thumbnailHash,
          dependencies: ThumbnailFamily._dependencies,
          allTransitiveDependencies: ThumbnailFamily._allTransitiveDependencies,
          request: request,
        );

  ThumbnailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.request,
  }) : super.internal();

  final ThumbnailRequest request;

  @override
  Override overrideWith(
    FutureOr<ImageWithAspectRatio> Function(ThumbnailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ThumbnailProvider._internal(
        (ref) => create(ref as ThumbnailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        request: request,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<ImageWithAspectRatio> createElement() {
    return _ThumbnailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ThumbnailProvider && other.request == request;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, request.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ThumbnailRef on AutoDisposeFutureProviderRef<ImageWithAspectRatio> {
  /// The parameter `request` of this provider.
  ThumbnailRequest get request;
}

class _ThumbnailProviderElement
    extends AutoDisposeFutureProviderElement<ImageWithAspectRatio>
    with ThumbnailRef {
  _ThumbnailProviderElement(super.provider);

  @override
  ThumbnailRequest get request => (origin as ThumbnailProvider).request;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
