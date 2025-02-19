import 'dart:collection' show MapView;
import 'package:flutter/foundation.dart' show immutable;
import 'package:media_mingle/state/constants/firebase_field_name.dart';
import 'package:media_mingle/state/posts/typedefs/user_id.dart';

@immutable
class UserInfoPayload extends MapView<String, String> {
  UserInfoPayload({
    required UserId userId,
    required String? displayName,
    required String? email,
    required String? profilePhotoUrl,
  }) : super({
          FirebaseFieldName.userId: userId,
          FirebaseFieldName.displayName: displayName ?? '',
          FirebaseFieldName.email: email ?? '',
          FirebaseFieldName.profilePhotoUrl: profilePhotoUrl ?? '',
        });
}
