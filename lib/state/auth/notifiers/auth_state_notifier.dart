import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_course/state/auth/backend/authenticator.dart';
import 'package:instagram_clone_course/state/auth/models/auth_result.dart';
import 'package:instagram_clone_course/state/auth/models/auth_state.dart';
import 'package:instagram_clone_course/state/posts/typedefs/user_id.dart';
import 'package:instagram_clone_course/state/user_info/backend/user_info_storage.dart';

class AuthStateNotifier extends StateNotifier<AuthSate> {
  final _authenticator = const Authenticator();
  final _userInfoStorage = const UserInfoStorage();

  //state is parameter of StateNotifier
  AuthStateNotifier() : super(const AuthSate.unknown()) {
    //logged in is set value AuthState
    if (_authenticator.isAlreadyLoggedIn) {
      state = AuthSate(
        result: AuthResult.success,
        isLoading: false,
        userId: _authenticator.userId,
      );
    }
  }

  //logout
  Future<void> logOut() async {
    state = state.copiedWithIsLoading(true);
    await _authenticator.logOut();
    state = const AuthSate.unknown(); //set unknow
  }

  //login with gg and create or update user
  Future<void> loginWithGoogle() async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.loginWithGoogle();
    final userId = _authenticator.userId;
    if (result == AuthResult.success && userId != null) {
      await saveUserInfo(userId: userId);
    }
    //update state
    state = AuthSate(
      result: result,
      isLoading: false,
      userId: userId,
    );
  }

  //login with fb and create or update user
  Future<void> loginWithFacebook() async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.loginWithFacebook();
    final userId = _authenticator.userId;
    if (result == AuthResult.success && userId != null) {
      await saveUserInfo(userId: userId);
    }
    //update state
    state = AuthSate(
      result: result,
      isLoading: false,
      userId: userId,
    );
  }

  Future<void> saveUserInfo({required UserId userId}) =>
      _userInfoStorage.saveUserInfo(
        userId: userId,
        displayName: _authenticator.displayName,
        email: _authenticator.email,
      );
}
