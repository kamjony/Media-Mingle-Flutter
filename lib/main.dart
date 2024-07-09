import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:media_mingle/state/auth/backend/authenticator.dart';
import 'firebase_options.dart';
import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() => devtools.log(toString());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
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
        appBarTheme: AppBarTheme(centerTitle: true),
      ),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
      ),
      body: Column(
        children: [
          TextButton(
              onPressed: () async {
                final result = await Authenticator().loginWithGoogle();
                result.log();
              },
              child: const Text(
                'Sign in with Google',
              )),
          TextButton(
              onPressed: () async {
                final result = await Authenticator().loginWithFacebook();
                result.log();
              },
              child: const Text(
                'Sign in with Facebook',
              )),
        ],
      ),
    );
  }
}
