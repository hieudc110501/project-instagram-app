import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_course/state/comments/typedef/comment_id.dart';
import 'package:instagram_clone_course/state/constants/firebase_collection_name.dart';
import 'package:instagram_clone_course/state/image_upload/typedefs/is_loading.dart';

class DeleteCommentStateNotifier extends StateNotifier<IsLoading> {
  DeleteCommentStateNotifier() : super(false);

  set isLoading(bool value) => state = value;

  Future<bool> deleteComment({
    required CommentId commentId,
  }) async {
    try {
      isLoading = true;

      //get comment
      final query = FirebaseFirestore
      .instance
      .collection(FirebaseCollectionName.comments)
      .where(
        FieldPath.documentId,
        isEqualTo: commentId,
      )
      .limit(1)
      .get();

    //delete comment
    await query.then((query) async {
      for (final doc in query.docs) {
        await doc.reference.delete();
      }
    });

      return true;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}