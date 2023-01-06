import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_course/state/auth/models/auth_state.dart';
import 'package:instagram_clone_course/state/auth/notifiers/auth_state_notifier.dart';

//connect to StateNotifier
final authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthSate>(
  (_) => AuthStateNotifier(),
);
