import 'package:flutter/material.dart';
import 'package:media_mingle/state/posts/models/post.dart';
import 'package:media_mingle/view/components/post/post_thumbnail_view.dart';
import 'package:media_mingle/view/post_comments/post_comments_view.dart';
import 'package:media_mingle/view/post_details/post_details_view.dart';

class PostsGridView extends StatelessWidget {
  final Iterable<Post> posts;

  const PostsGridView({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts.elementAt(index);
        return PostThumbnailView(
          post: post,
          onTapped: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => PostDetailsView(post: post,)),
            );
          },
        );
      },
    );
  }
}
