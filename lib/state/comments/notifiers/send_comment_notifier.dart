import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_course/state/comments/models/comment_payload.dart';
import 'package:instagram_clone_course/state/constants/firebase_collection_name.dart';
import 'package:instagram_clone_course/state/image_upload/typedefs/is_loading.dart';
import 'package:instagram_clone_course/state/posts/typedefs/post_id.dart';
import 'package:instagram_clone_course/state/posts/typedefs/user_id.dart';

class SendCommentNotifier extends StateNotifier<IsLoading> {
  SendCommentNotifier() : super(false);

  set isLoading(bool value) => state = value;

  Future<bool> sendComment({
    required UserId userId,
    required PostId postId,
    required String comment,
  }) async {
    isLoading = true;
    final payload = CommentPayload(
      fromUserId: userId,
      onPostId: postId,
      comment: comment,
    );
    try {
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.comments)
          .add(payload);
      return true;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
