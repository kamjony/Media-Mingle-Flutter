import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_mingle/state/comments/models/comment.dart';
import 'package:media_mingle/state/user_info/providers/user_info_model_provider.dart';
import 'package:media_mingle/view/components/animations/small_error_animation_view.dart';
import 'package:media_mingle/view/components/rich_text/base_text.dart';
import 'package:media_mingle/view/components/rich_text/rich_text_widget.dart';
import 'package:media_mingle/view/components/rich_two_parts_text.dart';

class CompactCommentTile extends ConsumerWidget {
  final Comment comment;

  const CompactCommentTile({super.key, required this.comment});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(userInfoModelProvider(
      comment.fromUserId,
    ));

    return userInfo.when(data: (data) {
      return RichTextWidget(
        texts: [
          BaseText(
              text: '${data.displayName} ',
              style: const TextStyle(fontWeight: FontWeight.bold)),
          BaseText(text: comment.comment)
        ],
        styleForAll: const TextStyle(
          height: 1.5,
          color: Colors.white70,
        ),
      );
    }, error: (error, stackTrace) {
      return const SmallErrorAnimationView();
    }, loading: () {
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}
