import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_mingle/enums/date_sorting.dart';
import 'package:media_mingle/state/comments/models/post_comments_request.dart';
import 'package:media_mingle/state/posts/models/post.dart';
import 'package:media_mingle/state/posts/providers/can_current_user_delete_post_provider.dart';
import 'package:media_mingle/state/posts/providers/delete_post_provider.dart';
import 'package:media_mingle/state/posts/providers/specific_post_with_comments_provider.dart';
import 'package:media_mingle/view/components/animations/error_animation_view.dart';
import 'package:media_mingle/view/components/animations/loading_animation_view.dart';
import 'package:media_mingle/view/components/animations/small_error_animation_view.dart';
import 'package:media_mingle/view/components/comment/compact_comment_column.dart';
import 'package:media_mingle/view/components/dialogs/alert_dialog_model.dart';
import 'package:media_mingle/view/components/dialogs/delete_dialog.dart';
import 'package:media_mingle/view/components/like_button.dart';
import 'package:media_mingle/view/components/likes_count_view.dart';
import 'package:media_mingle/view/components/post/post_date_view.dart';
import 'package:media_mingle/view/components/post/post_display_name_and_message_view.dart';
import 'package:media_mingle/view/components/post/post_image_or_video_view.dart';
import 'package:media_mingle/view/constants/strings.dart';
import 'package:media_mingle/view/post_comments/post_comments_view.dart';
import 'package:share_plus/share_plus.dart';

class PostDetailsView extends ConsumerStatefulWidget {
  final Post post;

  const PostDetailsView({super.key, required this.post});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PostDetailsViewState();
}

class _PostDetailsViewState extends ConsumerState<PostDetailsView> {
  @override
  Widget build(BuildContext context) {
    final request = RequestForPostAndComments(
        postId: widget.post.postId,
        limit: 3,
        sortByCreatedAt: true,
        dateSorting: DateSorting.oldestOnTop);

    //get the actual post together with comments
    final postWithComments =
        ref.watch(specificPostWithCommentsProvider(request));

    //can user delete post
    final canDeletePost =
        ref.watch(canCurrentUserDeletePostProvider(widget.post));

    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.postDetails),
        actions: [
          postWithComments.when(data: (data) {
            return IconButton(
                onPressed: () {
                  final url = data.post.fileUrl;
                  Share.share(
                    url,
                    subject: Strings.checkOutThisPost,
                  );
                },
                icon: const Icon(Icons.share));
          }, error: (error, stackTrace) {
            return const SmallErrorAnimationView();
          }, loading: () {
            return const Center(child: CircularProgressIndicator());
          }),
          if (canDeletePost.value ?? false)
            IconButton(
                onPressed: () async {
                  final shouldDeletePost = await const DeleteDialog(
                          titleOfObjectToDelete: Strings.post)
                      .present(context)
                      .then((shouldDelete) => shouldDelete ?? false);

                  if (shouldDeletePost) {
                    await ref
                        .read(deletePostProvider.notifier)
                        .deletePost(post: widget.post);
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  }
                },
                icon: const Icon(Icons.delete)),
        ],
      ),
      body: postWithComments.when(data: (data) {
        final postId = data.post.postId;
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              PostImageOrVideoView(post: data.post),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (data.post.allowLikes) LikeButton(postId: postId),
                  if (data.post.allowComments)
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      PostCommentsView(postId: postId)));
                        },
                        icon: const Icon(Icons.mode_comment_outlined))
                ],
              ),
              PostDisplayNameAndMessageView(post: data.post),
              PostDateView(dateTime: data.post.createdAt),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(color: Colors.white70,),
              ),
              CompactCommentColumn(comments: data.comments),
              if (data.post.allowLikes)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      LikesCountView(postId: postId),
                    ],
                  ),
                ),
              const SizedBox(height: 100,),
            ],
          ),
        );
      }, error: (error, stackTrace) {
        return const ErrorAnimationView();
      }, loading: () {
        return const LoadingAnimationView();
      }),
    );
  }
}
