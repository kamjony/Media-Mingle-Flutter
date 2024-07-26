import 'package:flutter/foundation.dart' show immutable;
import 'package:media_mingle/state/posts/typedefs/post_id.dart';
import 'package:media_mingle/state/posts/typedefs/user_id.dart';

@immutable
class LikesDislikeRequest {
  final PostId postId;
  final UserId likedBy;

  const LikesDislikeRequest({required this.postId, required this.likedBy});
}