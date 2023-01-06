import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_course/state/auth/models/auth_result.dart';
import 'package:instagram_clone_course/state/auth/providers/auth_state_provider.dart';

//listen if user logged in return true else false 
final isLoggedInProvider = Provider<bool> ((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.result == AuthResult.success;
});