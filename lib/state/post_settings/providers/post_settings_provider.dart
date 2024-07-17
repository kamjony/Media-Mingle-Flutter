import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_mingle/state/post_settings/models/post_settings.dart';
import 'package:media_mingle/state/post_settings/notifiers/post_settings_notifier.dart';

final postSettingsProvider =
    StateNotifierProvider<PostSettingNotifier, Map<PostSetting, bool>>(
  (ref) => PostSettingNotifier(),
);
