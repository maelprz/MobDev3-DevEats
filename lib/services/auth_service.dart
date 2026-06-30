import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_service.dart';

class AuthService {
  final SupabaseClient _client = SupabaseService.client;

  Future<void> register({
  required String fullName,
  required String email,
  required String phoneNumber,
  required String password,
}) async {
  final response = await _client.auth.signUp(
    email: email,
    password: password,
  );

  final user = response.user;

  if (user == null) {
    throw Exception("Registration failed.");
  }

  try {
    await _client.from('profiles').insert({
      'id': user.id,
      'full_name': fullName,
      'email': email,
      'phone_number': phoneNumber,
    });
  } catch (e) {
    await _client.auth.admin.deleteUser(user.id);
    rethrow;
  }
}

  Future<void> login({
    required String email,
    required String password,
  }) async {
    await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<void> logout() async {
    await _client.auth.signOut();
  }
}