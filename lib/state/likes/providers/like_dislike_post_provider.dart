import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_mingle/state/constants/firebase_collection_name.dart';
import 'package:media_mingle/state/constants/firebase_field_name.dart';
import 'package:media_mingle/state/likes/models/like.dart';
import 'package:media_mingle/state/likes/models/likes_dislike_request.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'like_dislike_post_provider.g.dart';

@riverpod
Future<bool> likeDislikePost(LikeDislikePostRef ref,
    {required LikesDislikeRequest request}) async {
  final query = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.likes)
      .where(
        FirebaseFieldName.postId,
        isEqualTo: request.postId,
      )
      .where(
        FirebaseFieldName.userId,
        isEqualTo: request.likedBy,
      )
      .get();

  //First check if user liked post
  final hasLiked = await query.then((snapshot) => snapshot.docs.isNotEmpty);

  if (hasLiked) {
    //dislike post
    try {
      await query.then((snapshot) async {
        for (final doc in snapshot.docs) {
          await doc.reference.delete();
        }
      });
      return true;
    } catch (_) {
      return false;
    }
  } else {
    //like the post
    final like = Like(
        postId: request.postId, likedBy: request.likedBy, date: DateTime.now());

    try {
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.likes)
          .add(like);
      return true;
    } catch (_) {
      return false;
    }
  }
}
