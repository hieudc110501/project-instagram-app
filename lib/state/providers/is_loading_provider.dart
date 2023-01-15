import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_course/state/auth/providers/auth_state_provider.dart';
import 'package:instagram_clone_course/state/comments/providers/delete_comment_provider.dart';
import 'package:instagram_clone_course/state/comments/providers/send_comment_provider.dart';
import 'package:instagram_clone_course/state/image_upload/providers/image_uploader_provider.dart';
import 'package:instagram_clone_course/state/posts/providers/delete_post_provider.dart';

//get current isLoading's status
final isLoadingProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  final isUploadingImage = ref.watch(imageUploadProvider);
  final isSendingComment = ref.watch(sendCommentProvider);
  final isDeletingComment = ref.watch(deleteCommentProvider);
  final isDeletingPost = ref.watch(deletePostProvider);

  return authState.isLoading ||
      isUploadingImage ||
      isSendingComment ||
      isDeletingComment ||
      isDeletingPost;
});
