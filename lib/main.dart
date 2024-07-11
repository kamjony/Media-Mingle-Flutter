import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_mingle/state/auth/providers/auth_state_provider.dart';
import 'package:media_mingle/view/components/animations/data_not_found_animation_view.dart';
import 'package:media_mingle/view/components/animations/empty_contents_animation_view.dart';
import 'package:media_mingle/view/components/animations/error_animation_view.dart';
import 'package:media_mingle/view/components/animations/loading_animation_view.dart';
import 'package:media_mingle/view/components/animations/small_error_animation_view.dart';
import 'package:media_mingle/view/components/loading/loading_screen.dart';
import 'firebase_options.dart';
import 'dart:developer' as devtools show log;

import 'state/auth/providers/is_logged_in_provider.dart';
import 'state/providers/is_loading_provider.dart';
import 'view/login/login_view.dart';

extension Log on Object {
  void log() => devtools.log(toString());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: false,
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
        useMaterial3: false,
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
        indicatorColor: Colors.blueGrey,
        appBarTheme: const AppBarTheme(centerTitle: true),
      ),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: Consumer(
        builder: (context, ref, child) {
          //Show loading screen
          ref.listen<bool>(isLoadingProvider, (_, isLoading) { //listen does not rebuild widget
            if (isLoading) {
              LoadingScreen.instance().show(context: context);
            } else {
              LoadingScreen.instance().hide();
            }
          });

          final isLoggedIn = ref.watch(isLoggedInProvider);  //watch rebuilds widget
          if (isLoggedIn) {
            return const MainView();
          } else {
            return const LoginView();
          }
        },
      ),
    );
  }
}

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main View'),
      ),
      body: Column(
        children: [
          Consumer(builder: (ctx, ref, child) {
            return TextButton(
                onPressed: () async {
                  await ref.read(authStateProvider.notifier).logOut();
                },
                child: const Text(
                  'Log out',
                ));
          })
        ],
      ),
    );
  }
}


