import 'package:flutter/material.dart';
import 'package:instagram_clone_course/state/comments/models/comment.dart';
import 'package:instagram_clone_course/views/components/comments/compact_comment_tile.dart';

class CompactCommentColumn extends StatelessWidget {
  final Iterable<Comment> comments;
  const CompactCommentColumn({
    Key? key,
    required this.comments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (comments.isEmpty) {
      return const SizedBox();
    }
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 8, right: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: comments.map((comment) {
          return CompactCommentTile(
            comment: comment,
          );
        }).toList(),
      ),
    );
  }
}
