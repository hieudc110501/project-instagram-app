import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_course/state/auth/providers/user_id_provider.dart';
import 'package:instagram_clone_course/state/comments/models/post_comment_request.dart';
import 'package:instagram_clone_course/state/comments/providers/post_comments_provider.dart';
import 'package:instagram_clone_course/state/comments/providers/send_comment_provider.dart';
import 'package:instagram_clone_course/state/posts/typedefs/post_id.dart';
import 'package:instagram_clone_course/views/components/animations/empty_contents_with_text_animation_view.dart';
import 'package:instagram_clone_course/views/components/animations/error_animation_view.dart';
import 'package:instagram_clone_course/views/components/animations/loading_animation_view.dart';
import 'package:instagram_clone_course/views/components/comments/comment_tile.dart';
import 'package:instagram_clone_course/views/constants/strings.dart';
import 'package:instagram_clone_course/views/extensions/dismiss_keyboard.dart';

class PostCommentsView extends HookConsumerWidget {
  final PostId postId;
  const PostCommentsView({required this.postId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentController = useTextEditingController();
    final hasText = useState(false);
    final request = useState(
      RequestForPostAndComments(
        postId: postId,
      ),
    );

    final comments = ref.watch(
      postCommentsProvider(request.value),
    );

    // if user typing in TextFiled
    useEffect(() {
      commentController.addListener(() {
        hasText.value = commentController.text.isNotEmpty;
      });
      return () {};
    }, [commentController]);

    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.comments),
        actions: [
          IconButton(
            onPressed: hasText.value
                ? () {
                    _submitCommentWithControlle(
                      commentController,
                      ref,
                    );
                  }
                : null,
            icon: const Icon(Icons.send),
          ),
        ],
      ),
      body: SafeArea(
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              flex: 4,
              child: comments.when(
                data: (comments) {
                  if (comments.isEmpty) {
                    return const SingleChildScrollView(
                      child: EmptyContentsWithTextAnimationView(
                        text: Strings.noCommentsYet,
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () {
                      ref.refresh(
                        postCommentsProvider(request.value),
                      );
                      return Future.delayed(
                        const Duration(seconds: 1),
                      );
                    },
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        final comment = comments.elementAt(index);
                        return CommentTile(comment: comment);
                      },
                    ),
                  );
                },
                error: (error, stackTrace) {
                  return const ErrorAnimationView();
                },
                loading: () {
                  return const LoadingAnimationView();
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: TextField(
                    controller: commentController,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (comment) {
                      if (comment.isNotEmpty) {
                        _submitCommentWithControlle(commentController, ref);
                      }
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: Strings.writeYourCommentHere,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitCommentWithControlle(
    TextEditingController controller,
    WidgetRef ref,
  ) async {
    final userId = ref.read(userIdProvider);
    if (userId == null) {
      return;
    }
    final isSent = await ref
        .read(
          sendCommentProvider.notifier,
        )
        .sendComment(
          userId: userId,
          postId: postId,
          comment: controller.text,
        );
    if (isSent) {
      controller.clear(); //clear text when add successful comment
      dismissKeyboard();
    }
  }
}
