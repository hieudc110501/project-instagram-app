import 'package:instagram_clone_course/enum/date_sorting.dart';
import 'package:instagram_clone_course/state/posts/typedefs/post_id.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class RequestForPostAndComments {
  final PostId postId;
  final bool sortByCreatedAt;
  final DateSorting dateSorting;
  final int? limit;

  const RequestForPostAndComments({
    required this.postId,
    this.sortByCreatedAt = true,
    this.dateSorting = DateSorting.newestOnTop,
    this.limit,
  });

  @override
  bool operator ==(covariant RequestForPostAndComments other) =>
      postId == other.postId &&
      sortByCreatedAt == other.sortByCreatedAt &&
      dateSorting == other.dateSorting &&
      limit == other.limit;

  @override
  int get hashCode => Object.hashAll(
    [
      postId,
      sortByCreatedAt,
      dateSorting,
      limit,
    ]
  );
}
