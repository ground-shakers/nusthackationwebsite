import 'package:shared_preferences/shared_preferences.dart';
import '../models/auth_model.dart';

class StorageService {
  static const String _accessTokenKey = 'access_token';
  static const String _userIdKey = 'user_id';
  static const String _userRoleKey = 'user_role';
  static const String _userEmailKey = 'user_email';

  static Future<void> saveLoginData(LoginResponse response) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenKey, response.token.accessToken);
    await prefs.setString(_userIdKey, response.userId);
    await prefs.setString(_userRoleKey, response.role);

    // You might want to store email too for display purposes
    // await prefs.setString(_userEmailKey, response.email); // If available
  }

  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey);
  }

  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userIdKey);
  }

  static Future<String?> getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userRoleKey);
  }

  static Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userEmailKey);
  }

  static Future<void> clearAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_accessTokenKey);
    await prefs.remove(_userIdKey);
    await prefs.remove(_userRoleKey);
    await prefs.remove(_userEmailKey);
  }

  static Future<bool> isLoggedIn() async {
    final token = await getAccessToken();
    return token != null && token.isNotEmpty;
  }

  // Get all user data for debugging
  static Future<Map<String, String?>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'token': prefs.getString(_accessTokenKey),
      'userId': prefs.getString(_userIdKey),
      'role': prefs.getString(_userRoleKey),
      'email': prefs.getString(_userEmailKey),
    };
  }
}
