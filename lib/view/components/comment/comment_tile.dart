import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_mingle/state/auth/providers/user_id_provider.dart';
import 'package:media_mingle/state/comments/models/comment.dart';
import 'package:media_mingle/state/comments/providers/delete_comment_provider.dart';
import 'package:media_mingle/state/user_info/providers/user_info_model_provider.dart';
import 'package:media_mingle/view/components/animations/small_error_animation_view.dart';
import 'package:media_mingle/view/components/constants/strings.dart';
import 'package:media_mingle/view/components/dialogs/alert_dialog_model.dart';
import 'package:media_mingle/view/components/dialogs/delete_dialog.dart';

class CommentTile extends ConsumerWidget {
  final Comment comment;

  const CommentTile({super.key, required this.comment});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(
      userInfoModelProvider(
        comment.fromUserId,
      ),
    );

    return userInfo.when(data: (userInfo) {
      final currentUserId = ref.read(userIdProvider);
      return ListTile(
        trailing: currentUserId == comment.fromUserId
            ? IconButton(
                onPressed: () async {
                  final shouldDeleteComment =
                      await displayDeleteDialog(context);
                  if (shouldDeleteComment) {
                    await ref
                        .read(deleteCommentProvider.notifier)
                        .deleteComment(commentId: comment.id);
                  }
                },
                icon: const Icon(Icons.delete),
              )
            : null,
        title: Text(
          userInfo.displayName,
        ),
        subtitle: Text(
          comment.comment,
        ),
      );
    }, error: (error, stacktrace) {
      return const SmallErrorAnimationView();
    }, loading: () {
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }

  Future<bool> displayDeleteDialog(BuildContext context) =>
      const DeleteDialog(titleOfObjectToDelete: Strings.comment)
          .present(context)
          .then((value) => value ?? false);
}
