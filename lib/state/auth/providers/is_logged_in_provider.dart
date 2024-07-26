import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_mingle/state/auth/models/auth_result.dart';
import 'package:media_mingle/state/auth/providers/auth_state_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'is_logged_in_provider.g.dart';

@riverpod
bool isLoggedIn(IsLoggedInRef ref) {
  final authState = ref.watch(authStateProvider);
  return authState.result == AuthResult.success;
}
