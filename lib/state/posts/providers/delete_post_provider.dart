import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_mingle/state/image_upload/typedefs/is_loading.dart';
import 'package:media_mingle/state/posts/notifiers/delete_post_notifier.dart';

final deletePostProvider = StateNotifierProvider<DeletePostNotifier, IsLoading>(
    (ref) => DeletePostNotifier());
