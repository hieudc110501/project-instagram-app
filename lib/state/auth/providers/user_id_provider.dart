import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_course/state/auth/providers/auth_state_provider.dart';
import 'package:instagram_clone_course/state/posts/typedefs/user_id.dart';

//listen state to get user's ID
final userIdProvider = Provider<UserId?> (
  (ref) => ref.watch(authStateProvider).userId,
);