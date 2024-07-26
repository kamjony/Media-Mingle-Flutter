// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like_dislike_post_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$likeDislikePostHash() => r'160f217d158d79580a92494934746cf7f6a6f5c5';

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

/// See also [likeDislikePost].
@ProviderFor(likeDislikePost)
const likeDislikePostProvider = LikeDislikePostFamily();

/// See also [likeDislikePost].
class LikeDislikePostFamily extends Family<AsyncValue<bool>> {
  /// See also [likeDislikePost].
  const LikeDislikePostFamily();

  /// See also [likeDislikePost].
  LikeDislikePostProvider call({
    required LikesDislikeRequest request,
  }) {
    return LikeDislikePostProvider(
      request: request,
    );
  }

  @override
  LikeDislikePostProvider getProviderOverride(
    covariant LikeDislikePostProvider provider,
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
  String? get name => r'likeDislikePostProvider';
}

/// See also [likeDislikePost].
class LikeDislikePostProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [likeDislikePost].
  LikeDislikePostProvider({
    required LikesDislikeRequest request,
  }) : this._internal(
          (ref) => likeDislikePost(
            ref as LikeDislikePostRef,
            request: request,
          ),
          from: likeDislikePostProvider,
          name: r'likeDislikePostProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$likeDislikePostHash,
          dependencies: LikeDislikePostFamily._dependencies,
          allTransitiveDependencies:
              LikeDislikePostFamily._allTransitiveDependencies,
          request: request,
        );

  LikeDislikePostProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.request,
  }) : super.internal();

  final LikesDislikeRequest request;

  @override
  Override overrideWith(
    FutureOr<bool> Function(LikeDislikePostRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LikeDislikePostProvider._internal(
        (ref) => create(ref as LikeDislikePostRef),
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
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _LikeDislikePostProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LikeDislikePostProvider && other.request == request;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, request.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin LikeDislikePostRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `request` of this provider.
  LikesDislikeRequest get request;
}

class _LikeDislikePostProviderElement
    extends AutoDisposeFutureProviderElement<bool> with LikeDislikePostRef {
  _LikeDislikePostProviderElement(super.provider);

  @override
  LikesDislikeRequest get request =>
      (origin as LikeDislikePostProvider).request;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
