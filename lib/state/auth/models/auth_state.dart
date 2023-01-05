import 'package:flutter/foundation.dart';
import 'package:instagram_clone_course/state/auth/models/auth_result.dart';
import 'package:instagram_clone_course/state/posts/typedefs/user_id.dart';

@immutable
class AuthSate {
  final AuthResult? result;
  final bool isLoading;
  final UserId? userId;

  const AuthSate({
    required this.result,
    required this.isLoading,
    required this.userId,
  });

  const AuthSate.unknown()
      : result = null,
        isLoading = false,
        userId = null;

  //change loading status
  AuthSate copiedWithIsLoading(bool isLoading) => AuthSate(
        result: result,
        isLoading: isLoading,
        userId: userId,
      );

  //comparison
  @override
  bool operator ==(covariant AuthSate other) =>
      identical(this, other) ||
      (result == other.result &&
          isLoading == other.isLoading &&
          userId == other.userId);
          
  @override
  int get hashCode => Object.hash(result, isLoading, userId);
          
}
