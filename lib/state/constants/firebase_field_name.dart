import 'package:flutter/foundation.dart' show immutable;

@immutable
class FirebaseFieldName {

  const FirebaseFieldName._();
  static const userId = 'uid';
  static const postId = 'post_id';
  static const comment = 'comment';
  static const createdAt = 'created_at';
  static const date = 'date';
  static const displayName = 'display_name';
  static const email = 'email';
  static const profilePhotoUrl = 'profile_photo_url';
}