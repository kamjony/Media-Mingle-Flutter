import 'dart:collection' show MapView;
import 'package:flutter/foundation.dart' show immutable;
import 'package:media_mingle/state/constants/firebase_field_name.dart';
import 'package:media_mingle/state/posts/typedefs/post_id.dart';
import 'package:media_mingle/state/posts/typedefs/user_id.dart';

@immutable
class Like extends MapView<String, String> {
  Like({
    required PostId postId,
    required UserId likedBy,
    required DateTime date,
  }) : super({
          FirebaseFieldName.postId: postId,
          FirebaseFieldName.userId: likedBy,
          FirebaseFieldName.date: date.toIso8601String(),
        });
}
