import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_mingle/state/posts/providers/posts_by_search_term_provider.dart';
import 'package:media_mingle/view/components/animations/data_not_found_animation_view.dart';
import 'package:media_mingle/view/components/animations/empty_contents_with_text_animation_view.dart';
import 'package:media_mingle/view/components/animations/error_animation_view.dart';
import 'package:media_mingle/view/components/post/post_sliver_grid_view.dart';
import 'package:media_mingle/view/components/post/posts_gridview.dart';
import 'package:media_mingle/view/constants/strings.dart';

class SearchGridView extends ConsumerWidget {
  final String searchTerm;

  const SearchGridView({super.key, required this.searchTerm});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (searchTerm.isEmpty) {
      return const SliverToBoxAdapter(
        child: EmptyContentsWithTextAnimationView(
            text: Strings.enterYourSearchTerm),
      );
    }

    final posts = ref.watch(postsBySearchTermProvider(searchTerm));

    return posts.when(data: (data) {
      if (data.isEmpty) {
        return const SliverToBoxAdapter(child: DataNotFoundAnimationView(),);
      } else {
        return PostsSliverGridView(posts: data);
      }
    }, error: (error, stackTrace) {
      return const SliverToBoxAdapter(child: ErrorAnimationView(),);
    }, loading: () {
      return const Center(
        child: SliverToBoxAdapter(child: CircularProgressIndicator(),),
      );
    });
  }
}
