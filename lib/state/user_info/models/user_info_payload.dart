import 'dart:collection' show MapView;
import 'package:flutter/foundation.dart';
import 'package:instagram_clone_course/state/constants/firebase_field_name.dart';
import 'package:instagram_clone_course/state/posts/typedefs/user_id.dart';

@immutable
class UserInfoPayload extends MapView<String, String> {
  UserInfoPayload({
    required UserId userId,
    required String? displayName,
    required String? email,
  }) : super({
    FirebaseFieldName.userId: userId,
    FirebaseFieldName.displayName: displayName ?? '',
    FirebaseFieldName.email: email ?? '',
  });
}