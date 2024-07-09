import 'package:flutter/foundation.dart' show immutable;

@immutable
class Constants {
  const Constants._(); //private constant so that constants class cannot be initialised from outside world,
  static const accountExistsWithDifferentCredential =
      'account-exists-with-different-credential';
  static const googleCom = 'google.com';
  static const emailScope = 'email';
}
