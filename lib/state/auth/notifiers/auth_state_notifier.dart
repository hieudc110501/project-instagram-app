import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_course/state/auth/backend/authenticator.dart';
import 'package:instagram_clone_course/state/auth/models/auth_result.dart';
import 'package:instagram_clone_course/state/auth/models/auth_state.dart';

class AuthStateNotifier extends StateNotifier<AuthSate> {
  final _authenticator = const Authenticator();

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

  //login with gg
  Future<void> loginWithGoogle() async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.loginWithGoogle();
    final userId = _authenticator.userId;

  }
}
