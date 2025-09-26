import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nusthackationwebsite/models/auth_model.dart';
import '../models/patient_model.dart';

class ApiService {
  static const String baseUrl = 'https://ground-shakers.xyz';

  static Future<LoginResponse> login(LoginRequest request) async {
    final url = Uri.parse('$baseUrl/login'); // Adjust endpoint if needed

    try {
      final requestBody = json.encode(request.toJson());
      print('🔐 === LOGIN REQUEST ===');
      print('URL: $url');
      print('Body: $requestBody');
      print('=====================');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: requestBody,
      );

      print('🔐 === LOGIN RESPONSE ===');
      print('Status Code: ${response.statusCode}');
      print('Response: ${response.body}');
      print('========================');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return LoginResponse.fromJson(jsonResponse);
      } else if (response.statusCode == 422) {
        final errorJson = json.decode(response.body);
        throw Exception('Login validation error: ${errorJson['detail']}');
      } else {
        throw Exception('Login failed: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Login error: $e');
      throw Exception('Login error: $e');
    }
  }

  static Future<PatientSignupResponse> createPatient(
    PatientSignupRequest request,
  ) async {
    final url = Uri.parse('$baseUrl/api/v1/patients');

    try {
      // Convert request to JSON
      final requestBody = request.toJson();
      final jsonString = json.encode(requestBody);

      // Detailed printing
      print('🚀 === API REQUEST DETAILS ===');
      print('📍 URL: $url');
      print('📋 METHOD: POST');
      print('🔗 ENDPOINT: /api/v1/patients');
      print('📦 HEADERS: {"Content-Type": "application/json"}');
      print('');
      print('📊 REQUEST BODY STRUCTURE:');
      _printRequestBody(requestBody);
      print('');
      print('📨 RAW JSON BEING SENT:');
      print(jsonString);
      print('================================');
      print('');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonString,
      );

      print('📡 === API RESPONSE ===');
      print('📟 STATUS CODE: ${response.statusCode}');
      print('📄 RESPONSE BODY:');
      print(response.body);
      print('📎 RESPONSE HEADERS: ${response.headers}');
      print('========================');
      print('');

      if (response.statusCode == 201) {
        final jsonResponse = json.decode(response.body);
        return PatientSignupResponse.fromJson(jsonResponse);
      } else if (response.statusCode == 422) {
        final errorJson = json.decode(response.body);
        throw Exception('Validation error: ${errorJson['detail']}');
      } else if (response.statusCode == 500) {
        throw Exception('Server error (500). Response: ${response.body}');
      } else {
        throw Exception(
          'Failed to create account. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('❌ === API ERROR ===');
      print('💥 Error type: ${e.runtimeType}');
      print('💥 Error message: $e');
      print('====================');
      throw Exception('Network error: $e');
    }
  }

  // Helper method to print the request body in a structured way
  static void _printRequestBody(Map<String, dynamic> requestBody) {
    requestBody.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        print('  📍 $key: {');
        value.forEach((nestedKey, nestedValue) {
          print('    🏷️  $nestedKey: $nestedValue');
        });
        print('  }');
      } else {
        print('  🏷️  $key: $value');
      }
    });
  }
}
