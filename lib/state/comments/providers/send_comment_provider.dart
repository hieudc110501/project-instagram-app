import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_course/state/comments/notifiers/send_comment_notifier.dart';
import 'package:instagram_clone_course/state/image_upload/typedefs/is_loading.dart';

final sendCommentProvider =
    StateNotifierProvider<SendCommentNotifier, IsLoading>(
  (_) => SendCommentNotifier(),
);
