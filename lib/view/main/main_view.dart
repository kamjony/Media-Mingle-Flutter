import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_mingle/state/auth/providers/auth_state_provider.dart';
import 'package:media_mingle/view/components/dialogs/alert_dialog_model.dart';
import 'package:media_mingle/view/components/dialogs/logout_dialog.dart';
import 'package:media_mingle/view/constants/strings.dart';
import 'package:media_mingle/view/tabs/users_posts/user_posts_view.dart';

class MainView extends ConsumerStatefulWidget {
  const MainView({super.key});

  @override
  ConsumerState<MainView> createState() => _MainViewState();
}

class _MainViewState extends ConsumerState<MainView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(Strings.appName),
            actions: [
              IconButton(
                onPressed: () async {},
                icon: const FaIcon(FontAwesomeIcons.film),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add_photo_alternate_outlined),
              ),
              IconButton(
                onPressed: () async {
                  final shouldLogOut = await const LogoutDialog()
                      .present(context)
                      .then((value) => value ?? false);

                  if (shouldLogOut) {
                    await ref.read(authStateProvider.notifier).logOut();
                  }
                },
                icon: const Icon(Icons.logout),
              ),
            ],
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.person)),
                Tab(icon: Icon(Icons.search)),
                Tab(icon: Icon(Icons.home)),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              UserPostsView(),
              UserPostsView(),
              UserPostsView(),
            ],
          ),
        ));
  }
}
