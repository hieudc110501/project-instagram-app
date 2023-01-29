import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_course/state/posts/providers/all_posts_provider.dart';
import 'package:instagram_clone_course/views/components/animations/empty_contents_with_text_animation_view.dart';
import 'package:instagram_clone_course/views/components/animations/error_animation_view.dart';
import 'package:instagram_clone_course/views/components/animations/loading_animation_view.dart';
import 'package:instagram_clone_course/views/components/post/posts_grid_view.dart';
import 'package:instagram_clone_course/views/components/post/posts_list_view.dart';
import 'package:instagram_clone_course/views/constants/strings.dart';

class HomeView extends ConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(allPostsProvider);

    return RefreshIndicator(
      child: posts.when(
        data: (posts) {
          if (posts.isEmpty) {
            return const EmptyContentsWithTextAnimationView(
              text: Strings.noPostsAvailable,
            );
          } else {
            return PostListView(
              posts: posts,
            );
          }
        },
        error: (error, stackTrace) {
          return const ErrorAnimationView();
        },
        loading: () {
          return const LoadingAnimationView();
        },
      ),
      onRefresh: () {
        ref.watch(allPostsProvider);
        return Future.delayed(
          const Duration(seconds: 1),
        );
      },
    );
  }
}
