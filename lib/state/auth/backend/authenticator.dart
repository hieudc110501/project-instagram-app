import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:instagram_clone_course/state/auth/constants/constants.dart';
import 'package:instagram_clone_course/state/auth/models/auth_result.dart';
import 'package:instagram_clone_course/state/posts/typedefs/user_id.dart';

class Authenticator {
  const Authenticator();

  //get current user's information from Firebase
  User? get currentUser => FirebaseAuth.instance.currentUser;
  UserId? get userId => currentUser?.uid;
  bool get isAlreadyLoggedIn => userId != null;
  String get displayName => currentUser?.displayName ?? '';
  String? get email => currentUser?.email;

  //logout
  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    await FacebookAuth.instance.logOut();
  }

  //login with facebook
  Future<AuthResult> loginWithFacebook() async {
    final loginResult = await FacebookAuth.instance.login();
    final token = loginResult.accessToken?.token;

    if (token == null) {
      //user has aborted the logging in process
      return AuthResult.aborted;
    }
    final oauthCredential = FacebookAuthProvider.credential(token);
    try {
      await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      return AuthResult.success;
    } on FirebaseAuthException catch (e) {
      final email = e.email;
      final credential = e.credential;

      //if user exists and firebase has email login method, will login with google and link
      if (e.code == Constants.accountExistsWithDifferentCredential &&
          email != null &&
          credential != null) {
        final providers =
            await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
        if (providers.contains(Constants.googleCom)) {
          await loginWithGoogle();
          currentUser?.linkWithCredential(
            credential,
          );
        }
        return AuthResult.success;
      }
      return AuthResult.failure;
    }
  }

  //login with google
  Future<AuthResult> loginWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        Constants.emailScope,
      ],
    );

    final signInAccount = await googleSignIn.signIn();
    if (signInAccount == null) {
      //user has aborted the logging in process
      return AuthResult.aborted;
    }

    final googleAuth = await signInAccount.authentication;
    final oauthCredentials = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );

    try {
      await FirebaseAuth.instance.signInWithCredential(oauthCredentials);
      return AuthResult.success;
    } catch (e) {
      return AuthResult.failure;
    }
  }
}
