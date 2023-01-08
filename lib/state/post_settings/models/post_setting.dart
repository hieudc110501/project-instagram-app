import 'package:instagram_clone_course/state/post_settings/constants/constants.dart';

enum PostSetting {
  allowLikes(
    title: Constants.allowLikesTitle,
    desciption: Constants.allowLikeDescription,
    storageKey: Constants.allowLikesStorageKey,
  ),

  allowComments(
    title: Constants.allowCommentsTitle,
    desciption: Constants.allowCommentsDescription,
    storageKey: Constants.allowCommentsStorageKey,
  );

  final String title;
  final String desciption;
  final String storageKey;

  const PostSetting({
    required this.title,
    required this.desciption,
    required this.storageKey,
  });
}
