import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:media_mingle/state/auth/constants/contants.dart';
import 'package:media_mingle/state/auth/models/auth_result.dart';
import 'package:media_mingle/state/posts/typedefs/user_id.dart';

class Authenticator {
  const Authenticator();

  User? get currentUser => FirebaseAuth.instance.currentUser;

  UserId? get userId => currentUser?.uid;

  bool get isAlreadyLoggedIn => userId != null;

  String get displayName => currentUser?.displayName ?? '';

  String? get email => currentUser?.email;

  String? get userPhoto => currentUser?.photoURL;

  Future<AuthResult> loginWithFacebook() async {
    final loginResult = await FacebookAuth.instance.login();
    final token = loginResult.accessToken?.tokenString;
    if (token == null) {
      return AuthResult.aborted;
    }
    final oAuthCredentials = FacebookAuthProvider.credential(token);
    try {
      await FirebaseAuth.instance.signInWithCredential(
        oAuthCredentials,
      );
      return AuthResult.success;
    } on FirebaseAuthException catch (e) {
      final email = e.email;
      final credential = e.credential;
      if (e.code == Constants.accountExistsWithDifferentCredential &&
          email != null &&
          credential != null) {
        final providers =
            await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
        if (providers.contains(Constants.googleCom)) {
          await loginWithGoogle();
          currentUser?.linkWithCredential(credential);
        }
        return AuthResult.success;
      }
      return AuthResult.failure;
    }
  }

  Future<AuthResult> loginWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(scopes: [
      Constants.emailScope,
    ]);
    final signInAccount = await googleSignIn.signIn();
    if (signInAccount == null) {
      return AuthResult.aborted;
    }
    final googleAuth = await signInAccount.authentication;
    final oAuthCredentials = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    try {
      await FirebaseAuth.instance.signInWithCredential(
        oAuthCredentials,
      );
      return AuthResult.success;
    } on FirebaseAuthException catch (e) {
      return AuthResult.failure;
    }
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    await FacebookAuth.instance.logOut();
  }
}
