import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_mingle/state/auth/providers/auth_state_provider.dart';
import 'package:media_mingle/state/comments/providers/delete_comment_provider.dart';
import 'package:media_mingle/state/comments/providers/send_comment_provider.dart';
import 'package:media_mingle/state/image_upload/providers/image_uploader_provider.dart';
import 'package:media_mingle/state/posts/providers/delete_post_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'is_loading_provider.g.dart';

@riverpod
bool isLoading(IsLoadingRef ref) {
  final authState = ref.watch(authStateProvider);
  final isUploadingImage = ref.watch(imageUploaderProvider);
  final isSendingComment = ref.watch(sendCommentProvider);
  final isDeletingComment = ref.watch(deleteCommentProvider);
  final isDeletingPost = ref.watch(deletePostProvider);

  return authState.isLoading ||
      isUploadingImage ||
      isSendingComment ||
      isDeletingComment ||
      isDeletingPost;
}
