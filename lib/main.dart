import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_course/state/auth/backend/authenticator.dart';
import 'package:instagram_clone_course/state/auth/providers/auth_state_provider.dart';
import 'package:instagram_clone_course/state/auth/providers/is_logged_in_provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
        indicatorColor: Colors.blueGrey,
      ),
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Consumer(builder: (context, ref, child) {
        final isLoggedIn = ref.watch(isLoggedInProvider);
        if (isLoggedIn) {
          return const MainView();
        } else {
          return const LoginView();
        }
      }),
    );
  }
}

class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main View'),
      ),
      body: Consumer(builder: (context, ref, child) {
        return TextButton(
          onPressed: () async {
            await ref.read(authStateProvider.notifier).logOut();
          },
          child: const Text('logout'),
        );
      }),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login View'),
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () async {
              final res = await Authenticator().loginWithGoogle();
              print(res);
            },
            child: const Text('Google'),
          ),
          TextButton(
            onPressed: () async {
              final res = await Authenticator().loginWithFacebook();
              print(res);
            },
            child: const Text('Facebook'),
          ),
        ],
      ),
    );
  }
}
