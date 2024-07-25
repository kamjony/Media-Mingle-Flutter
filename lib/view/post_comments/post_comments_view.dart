import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:media_mingle/state/auth/providers/user_id_provider.dart';
import 'package:media_mingle/state/comments/models/post_comments_request.dart';
import 'package:media_mingle/state/comments/providers/post_comment_provider.dart';
import 'package:media_mingle/state/comments/providers/send_comment_provider.dart';
import 'package:media_mingle/state/posts/typedefs/post_id.dart';
import 'package:media_mingle/view/components/animations/empty_contents_with_text_animation_view.dart';
import 'package:media_mingle/view/components/animations/error_animation_view.dart';
import 'package:media_mingle/view/components/animations/loading_animation_view.dart';
import 'package:media_mingle/view/components/animations/small_error_animation_view.dart';
import 'package:media_mingle/view/components/comment/comment_tile.dart';
import 'package:media_mingle/view/constants/strings.dart';
import 'package:media_mingle/view/extensions/dismiss_keyboard.dart';

class PostCommentsView extends HookConsumerWidget {
  final PostId postId;

  const PostCommentsView({super.key, required this.postId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentController = useTextEditingController();
    final hasText = useState(false);
    final request = useState(RequestForPostAndComments(postId: postId));
    final comments = ref.watch(postCommentProvider(request.value));

    useEffect(() {
      commentController.addListener(() {
        hasText.value = commentController.text.isNotEmpty;
      });
      return () {};
    }, [commentController]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
        actions: [
          IconButton(
            onPressed: hasText.value
                ? () {
                    _submitCommentWithController(commentController, ref);
                  }
                : null,
            icon: const Icon(
              Icons.send,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              flex: 4,
              child: comments.when(data: (data) {
                if (data.isEmpty) {
                  return const SingleChildScrollView(
                    child: EmptyContentsWithTextAnimationView(
                        text: Strings.noCommentsYet),
                  );
                }
                return RefreshIndicator(
                    onRefresh: () {
                      ref.refresh(postCommentProvider(request.value));
                      return Future.delayed(const Duration(seconds: 1));
                    },
                    child: ListView.builder(
                      itemCount: data.length,
                      padding: const EdgeInsets.all(8.0),
                      itemBuilder: (context, index) {
                        final comment = data.elementAt(index);
                        return CommentTile(comment: comment);
                      },
                    ));
              }, error: (error, stacktrace) {
                return const ErrorAnimationView();
              }, loading: () {
                return const LoadingAnimationView();
              }),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextField(
                    textInputAction: TextInputAction.send,
                    controller: commentController,
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        _submitCommentWithController(commentController, ref);
                      }
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: Strings.writeYourCommentHere),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _submitCommentWithController(
      TextEditingController controller, WidgetRef ref) async {
    final userId = ref.read(userIdProvider);
    if (userId == null) {
      return;
    }
    final isSent = await ref.read(sendCommentProvider.notifier).sendComment(
        fromUserId: userId, onPostId: postId, comment: controller.text);

    if (isSent) {
      controller.clear();
      dismissKeyboard();
    }
  }
}
