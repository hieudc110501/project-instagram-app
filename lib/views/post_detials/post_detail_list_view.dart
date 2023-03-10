import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_course/enum/date_sorting.dart';
import 'package:instagram_clone_course/state/comments/models/post_comment_request.dart';
import 'package:instagram_clone_course/state/posts/models/post.dart';
import 'package:instagram_clone_course/state/posts/providers/can_current_user_delete_post_provider.dart';
import 'package:instagram_clone_course/state/posts/providers/delete_post_provider.dart';
import 'package:instagram_clone_course/state/posts/providers/specific_post_with_comments_provider.dart';
import 'package:instagram_clone_course/views/components/animations/error_animation_view.dart';
import 'package:instagram_clone_course/views/components/animations/small_error_animation_view.dart';
import 'package:instagram_clone_course/views/components/comments/compact_comment_column.dart';
import 'package:instagram_clone_course/views/components/dialogs/alert_dialog_model.dart';
import 'package:instagram_clone_course/views/components/dialogs/delete_dialog.dart';
import 'package:instagram_clone_course/views/components/like_button.dart';
import 'package:instagram_clone_course/views/components/likes_count_view.dart';
import 'package:instagram_clone_course/views/components/post/post_date_view.dart';
import 'package:instagram_clone_course/views/components/post/post_display_name_and_message_view.dart';
import 'package:instagram_clone_course/views/components/post/post_image_or_video_view.dart';
import 'package:instagram_clone_course/views/components/post/post_user_avatar.dart';
import 'package:instagram_clone_course/views/constants/strings.dart';
import 'package:instagram_clone_course/views/post_comments/post_comments_view.dart';
import 'package:share_plus/share_plus.dart';

class PostDetailListView extends ConsumerStatefulWidget {
  final Post post;
  const PostDetailListView({
    required this.post,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PostDetailListViewState();
}

class _PostDetailListViewState extends ConsumerState<PostDetailListView> {
  @override
  Widget build(BuildContext context) {
    final request = RequestForPostAndComments(
        postId: widget.post.postId,
        limit: 3,
        sortByCreatedAt: true,
        dateSorting: DateSorting.oldestOnTop);

    //get the actual post together with its commentss
    final postWithComments = ref.watch(
      specificPostWithCommentsProvider(
        request,
      ),
    );

    return postWithComments.when(
      data: (postWithComments) {
        final postId = postWithComments.post.postId;
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //avatar
              PostUserAvatar(
                post: postWithComments.post,
              ),

              //image
              PostImageOrVideoView(
                post: postWithComments.post,
              ),

              //post button
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //like button if post allows liking
                  if (postWithComments.post.allowsLikes)
                    LikeButton(postId: postId),

                  //comment button if post allows commenting
                  if (postWithComments.post.allowsComments)
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                PostCommentsView(postId: postId),
                          ),
                        );
                      },
                      icon: const Icon(Icons.mode_comment_outlined),
                    ),
                  IconButton(
                    onPressed: () {
                      final url = postWithComments.post.fileUrl;
                      Share.share(
                        url,
                        subject: Strings.checkOutThisPost,
                      );
                    },
                    icon: const Icon(Icons.share),
                  ),
                ],
              ),

              //post detail show divider
              PostDisplayNameAndMessageView(
                post: postWithComments.post,
              ),
              PostDateView(
                dateTime: postWithComments.post.createdAt,
              ),
              const Padding(
                padding: EdgeInsets.all(8),
                child: Divider(
                  color: Colors.white70,
                ),
              ),

              //display comments
              CompactCommentColumn(
                comments: postWithComments.comments,
              ),

              //display like count
              if (postWithComments.post.allowsLikes)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      LikesCountView(postId: postId),
                    ],
                  ),
                ),

              //add spacing to bottom of screen
              const SizedBox(
                height: 100,
              )
            ],
          ),
        );
      },
      error: (error, stackTrace) {
        return const ErrorAnimationView();
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
