import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_mingle/state/likes/providers/post_likes_count_provider.dart';
import 'package:media_mingle/state/posts/typedefs/post_id.dart';
import 'package:media_mingle/view/components/animations/small_error_animation_view.dart';
import 'package:media_mingle/view/components/constants/strings.dart';

class LikesCountView extends ConsumerWidget {
  final PostId postId;

  const LikesCountView({super.key, required this.postId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final likesCount = ref.watch(postLikesCountProvider(postId));
    return likesCount.when(data: (int likesCounter) {
      final personOrPeople =
          likesCounter == 1 ? Strings.person : Strings.people;
      final likesText = '$likesCounter $personOrPeople ${Strings.likedThis}';
      return Text(
        likesText,
      );
    }, error: (error, stackTrace) {
      return const SmallErrorAnimationView();
    }, loading: () {
      return const CircularProgressIndicator();
    });
  }
}
