import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_mingle/state/auth/providers/user_id_provider.dart';
import 'package:media_mingle/state/constants/firebase_collection_name.dart';
import 'package:media_mingle/state/constants/firebase_field_name.dart';
import 'package:media_mingle/state/posts/models/post.dart';
import 'package:media_mingle/state/posts/models/post_key.dart';

final allPostsProvider = StreamProvider.autoDispose<Iterable<Post>>((ref) {
  final userId = ref.watch(userIdProvider);
  final controller = StreamController<Iterable<Post>>();

  final sub = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.posts)
      .orderBy(FirebaseFieldName.createdAt, descending: true)
      .where(PostKey.userId, isNotEqualTo: userId)
      .snapshots()
      .listen((snapshot) {
    final posts =
        snapshot.docs.map((doc) => Post(postId: doc.id, json: doc.data()));
    controller.sink.add(posts);
  });

  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });

  return controller.stream;
});
