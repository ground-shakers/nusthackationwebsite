import 'dart:convert';
import 'package:nusthackationwebsite/models/doctors_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorStorageService {
  static const String _accessTokenKey = 'doctor_access_token';
  static const String _userIdKey = 'doctor_user_id';
  static const String _userRoleKey = 'doctor_user_role';
  static const String _userEmailKey = 'doctor_user_email';
  static const String _userFirstNameKey = 'doctor_first_name';
  static const String _userLastNameKey = 'doctor_last_name';
  static const String _doctorProfileKey = 'doctor_profile';

  // Save login data (token + user)
  static Future<void> saveDoctorLoginData(Map<String, dynamic> response) async {
    final prefs = await SharedPreferences.getInstance();

    final accessToken = response['token']?['access_token'] ?? '';
    final userId = response['user_id'] ?? '';
    final role = response['role'] ?? '';
    final email = response['email'];
    final firstName = response['first_name'];
    final lastName = response['last_name'];

    await prefs.setString(_accessTokenKey, accessToken);
    await prefs.setString(_userIdKey, userId);
    await prefs.setString(_userRoleKey, role);

    if (email != null) await prefs.setString(_userEmailKey, email);
    if (firstName != null) await prefs.setString(_userFirstNameKey, firstName);
    if (lastName != null) await prefs.setString(_userLastNameKey, lastName);
  }

  static Future<void> saveDoctorProfile(Map<String, dynamic> profile) async {
    final prefs = await SharedPreferences.getInstance();
    final profileJson = jsonEncode(profile);
    await prefs.setString(_doctorProfileKey, profileJson);
  }

  // Retrieve user data
  static Future<Map<String, String?>> getDoctorUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'token': prefs.getString(_accessTokenKey),
      'userId': prefs.getString(_userIdKey),
      'role': prefs.getString(_userRoleKey),
      'email': prefs.getString(_userEmailKey),
      'firstName': prefs.getString(_userFirstNameKey),
      'lastName': prefs.getString(_userLastNameKey),
    };
  }

  // Retrieve doctor profile as Map
  static Future<Map<String, dynamic>?> getDoctorProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final profileString = prefs.getString(_doctorProfileKey);
    if (profileString == null) return null;
    return jsonDecode(profileString);
  }

  // Clear all stored doctor data
  static Future<void> clearDoctorAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_accessTokenKey);
    await prefs.remove(_userIdKey);
    await prefs.remove(_userRoleKey);
    await prefs.remove(_userEmailKey);
    await prefs.remove(_userFirstNameKey);
    await prefs.remove(_userLastNameKey);
    await prefs.remove(_doctorProfileKey);
  }
}
