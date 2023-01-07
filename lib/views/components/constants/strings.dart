import 'package:flutter/foundation.dart' show immutable;

@immutable
class Strings {
  static const allowLikesTitle = 'Allow likes';
  static const allowLikeDescription = 'By allowing likes, users will be able to press the like button on your post.';
  static const allowLikesStorageKey = 'allow_likes';
  static const allowCommentsTitle = 'Allow comments';
  static const allowCommentsDescription = 'By allowing comments, users will be able to press the comment button on your post.';
  static const allow = 'allow_comments';

  static const comment = 'comment';
  static const loading = 'Loading...';
  static const person = 'person';
  static const people = 'people';
  static const likedThis = 'liked this';
  static const delete = 'Delete';
  static const areYouSureYouWantToDeteteThis = 'Are you sure you want to delete this';
  static const logOut = 'Log out';
  static const areYouSureThatYouWantToLogOutOfTheApp = 'Are you sure that you want to log out the app';
  static const cancel = 'Cancel';


  const Strings._();
}