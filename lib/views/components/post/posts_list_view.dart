import 'package:flutter/material.dart';
import 'package:instagram_clone_course/state/posts/models/post.dart';
import 'package:instagram_clone_course/views/post_detials/post_detail_list_view.dart';
import 'package:instagram_clone_course/views/components/post/post_thumbnail_view.dart';
import 'package:instagram_clone_course/views/post_detials/post_details_view.dart';

class PostListView extends StatelessWidget {
  final Iterable<Post> posts;
  const PostListView({
    Key? key,
    required this.posts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts.elementAt(index);
        return PostDetailListView(
          post: post,
        );
      },
    );
  }
}
