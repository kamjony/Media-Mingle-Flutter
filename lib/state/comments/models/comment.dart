import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:media_mingle/state/comments/type_def/comment_id.dart';
import 'package:media_mingle/state/constants/firebase_field_name.dart';
import 'package:media_mingle/state/posts/typedefs/post_id.dart';
import 'package:media_mingle/state/posts/typedefs/user_id.dart';

@immutable
class Comment {
  final CommentId id;
  final String comment;
  final DateTime createdAt;
  final UserId fromUserId;
  final PostId onPostId;

  Comment(Map<String, dynamic> json, {required this.id})
      : comment = json[FirebaseFieldName.comment],
        createdAt = (json[FirebaseFieldName.createdAt] as Timestamp).toDate(),
        fromUserId = json[FirebaseFieldName.userId] as UserId,
        onPostId = json[FirebaseFieldName.postId] as PostId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Comment &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          comment == other.comment &&
          createdAt == other.createdAt &&
          fromUserId == other.fromUserId &&
          onPostId == other.onPostId;

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        comment,
        createdAt,
        fromUserId,
        onPostId,
      ]);
}
