import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_mingle/state/image_upload/notifier/image_upload_notifier.dart';
import 'package:media_mingle/state/image_upload/typedefs/is_loading.dart';

final imageUploaderProvider =
    StateNotifierProvider<ImageUploadNotifier, IsLoading>(
  (ref) => ImageUploadNotifier(),
);
