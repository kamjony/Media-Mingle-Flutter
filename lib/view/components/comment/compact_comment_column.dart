import 'package:flutter/material.dart';
import 'package:media_mingle/state/comments/models/comment.dart';
import 'package:media_mingle/view/components/comment/compact_comment_tile.dart';

class CompactCommentColumn extends StatelessWidget {
  final Iterable<Comment> comments;

  const CompactCommentColumn({super.key, required this.comments});

  @override
  Widget build(BuildContext context) {
    if (comments.isEmpty) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: comments
            .map(
              (comment) => CompactCommentTile(
                comment: comment,
              ),
            )
            .toList(),
      ),
    );
  }
}
