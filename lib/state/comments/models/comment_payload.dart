import 'dart:collection' show MapView;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_clone_course/state/constants/firebase_field_name.dart';
import 'package:instagram_clone_course/state/posts/typedefs/post_id.dart';
import 'package:instagram_clone_course/state/posts/typedefs/user_id.dart';

@immutable
class CommentPayload extends MapView<String, dynamic> {
  //add comment
  CommentPayload({
    required UserId fromUserId,
    required PostId onPostId,
    required String comment,
  }) : super({
          FirebaseFieldName.userId: fromUserId,
          FirebaseFieldName.postId: onPostId,
          FirebaseFieldName.comment: comment,
          FirebaseFieldName.createdAt: FieldValue.serverTimestamp(),
        });
}
