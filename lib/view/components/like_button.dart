import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_mingle/state/auth/providers/user_id_provider.dart';
import 'package:media_mingle/state/likes/models/likes_dislike_request.dart';
import 'package:media_mingle/state/likes/providers/has_liked_post_provider.dart';
import 'package:media_mingle/state/likes/providers/like_dislike_post_provider.dart';
import 'package:media_mingle/state/posts/typedefs/post_id.dart';
import 'package:media_mingle/view/components/animations/small_error_animation_view.dart';

class LikeButton extends ConsumerWidget {
  final PostId postId;

  const LikeButton({super.key, required this.postId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasLiked = ref.watch(hasLikedPostProvider(postId));

    return hasLiked.when(data: (bool liked) {
      return IconButton(
          onPressed: () {
            final userId = ref.read(userIdProvider);
            if (userId == null) {
              return;
            }
            final likeRequest = LikesDislikeRequest(
              postId: postId,
              likedBy: userId,
            );
            ref.read(likeDislikePostProvider(request: likeRequest));
          },
          icon: FaIcon(
            liked ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
          ));
    }, error: (error, stackTrace) {
      return const SmallErrorAnimationView();
    }, loading: () {
      return const Center(child: CircularProgressIndicator());
    });
  }
}
