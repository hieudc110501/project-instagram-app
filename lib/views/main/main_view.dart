import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_course/state/auth/providers/auth_state_provider.dart';
import 'package:instagram_clone_course/state/image_upload/helpers/image_picker_helper.dart';
import 'package:instagram_clone_course/state/image_upload/models/file_type.dart';
import 'package:instagram_clone_course/state/post_settings/providers/post_settings_provider.dart';
import 'package:instagram_clone_course/views/components/dialogs/alert_dialog_model.dart';
import 'package:instagram_clone_course/views/components/dialogs/logout_dialog.dart';
import 'package:instagram_clone_course/views/constants/strings.dart';
import 'package:instagram_clone_course/views/create_new_post/create_new_post_view.dart';
import 'package:instagram_clone_course/views/tabs/home/home_view.dart';
import 'package:instagram_clone_course/views/tabs/search/search_view.dart';
import 'package:instagram_clone_course/views/tabs/users_posts/user_posts_view.dart';

class MainView extends ConsumerStatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainViewState();
}

class _MainViewState extends ConsumerState<MainView> {
  int _currentIndex = 0;
  final tabs = const [
    HomeView(),
    SearchView(),
    HomeView(),
    HomeView(),
    UserPostsView(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(Strings.appName),
          actions: [
            IconButton(
              onPressed: () async {
                final videoFile =
                    await ImagePickerHelper.pickVideoFromGallery();
                if (videoFile == null) {
                  return;
                }
                ref.refresh(postSettingProvider);

                //go to screen to create a new post
                if (!mounted) {
                  return;
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CreateNewPostView(
                      fileToPost: videoFile,
                      fileType: FileType.video,
                    ),
                  ),
                );
              },
              icon: const FaIcon(
                FontAwesomeIcons.film,
              ),
            ),
            IconButton(
              onPressed: () async {
                final imageFile =
                    await ImagePickerHelper.pickImageFromGallery();
                if (imageFile == null) {
                  return;
                }
                ref.refresh(postSettingProvider);

                //go to screen to create a new post
                if (!mounted) {
                  return;
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CreateNewPostView(
                      fileToPost: imageFile,
                      fileType: FileType.image,
                    ),
                  ),
                );
              },
              icon: const Icon(
                Icons.add_photo_alternate_outlined,
              ),
            ),
            IconButton(
              onPressed: () async {
                final shouldLogOut = await const LogoutDialog()
                    .present(context)
                    .then((value) => value ?? false);
                if (shouldLogOut) {
                  await ref.watch(authStateProvider.notifier).logOut();
                }
              },
              icon: const Icon(
                Icons.logout,
              ),
            ),
          ],
        ),
        body: tabs[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.black,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                _currentIndex == 0 ? Icons.home : Icons.home_outlined,
                color: Colors.white,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                _currentIndex == 1 ? Icons.search : Icons.search_rounded,
                color: Colors.white,
                size: _currentIndex == 1 ? 26 : 24,
              ),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                _currentIndex == 2 ? Icons.video_collection : Icons.video_collection_outlined,
                color: Colors.white,
              ),
              label: 'Reels',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                _currentIndex == 3 ? Icons.favorite : Icons.favorite_border,
                color: Colors.white,
              ),
              label: 'Favorite',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                _currentIndex == 4 ? Icons.person : Icons.person_outline,
                color: Colors.white,
              ),
              label: 'Person',
            )
          ],
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
