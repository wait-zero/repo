import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/models/auth_response.dart';
import '../../../core/repositories/auth_repository.dart';

const _tokenKey = 'auth_token';

/// SharedPreferences provider - must be overridden in main.dart
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('Must be overridden in main.dart');
});

/// Auth token stored in SharedPreferences
final authTokenProvider = StateProvider<String?>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return prefs.getString(_tokenKey);
});

/// Auth state notifier
final authStateProvider =
    AsyncNotifierProvider<AuthStateNotifier, AuthResponse?>(
        AuthStateNotifier.new);

class AuthStateNotifier extends AsyncNotifier<AuthResponse?> {
  @override
  Future<AuthResponse?> build() async {
    final token = ref.read(authTokenProvider);
    if (token == null) return null;

    final repo = ref.read(authRepositoryProvider);
    final user = await repo.getMe(token);
    if (user == null) {
      // Token invalid, clear it
      await _clearToken();
      return null;
    }
    return user;
  }

  Future<void> login(String phone, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(authRepositoryProvider);
      final result = await repo.login(phone, password);
      if (result.token != null) {
        await _saveToken(result.token!);
      }
      return result;
    });
  }

  Future<void> signup(String name, String phone, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(authRepositoryProvider);
      final result = await repo.signup(name, phone, password);
      if (result.token != null) {
        await _saveToken(result.token!);
      }
      return result;
    });
  }

  Future<void> logout() async {
    await _clearToken();
    state = const AsyncData(null);
  }

  Future<void> _saveToken(String token) async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setString(_tokenKey, token);
    ref.read(authTokenProvider.notifier).state = token;
  }

  Future<void> _clearToken() async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.remove(_tokenKey);
    ref.read(authTokenProvider.notifier).state = null;
  }
}

/// Whether user is logged in
final isLoggedInProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.valueOrNull != null;
});

/// Current user ID (null if not logged in)
final currentUserIdProvider = Provider<int?>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.valueOrNull?.userId;
});
