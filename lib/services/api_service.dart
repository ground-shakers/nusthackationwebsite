import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nusthackationwebsite/models/auth_model.dart';
import '../models/patient_model.dart';

class ApiService {
  static const String baseUrl = 'https://ground-shakers.xyz';

  static Future<Patient> getPatientProfile(
    String patientId,
    String accessToken,
  ) async {
    final url = Uri.parse('$baseUrl/api/v1/patients/$patientId');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return Patient.fromJson(
          jsonResponse['patient'],
        ); // Extract patient object from response
      } else {
        throw Exception(
          'Failed to fetch patient profile: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Patient profile fetch error: $e');
    }
  }

  static Future<LoginResponse> login(LoginRequest request) async {
    final url = Uri.parse('$baseUrl/login');

    try {
      print('🔐 === LOGIN REQUEST (FORM DATA) ===');
      print('URL: $url');
      print('Username: ${request.username}');
      print('Password: ${request.password}');
      print('========================');

      // Send as form data - use a Map for the body
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'username': request.username, 'password': request.password},
      );

      print('🔐 === LOGIN RESPONSE ===');
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
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
      final requestBody = request.toJson();
      final jsonString = json.encode(requestBody);

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonString,
      );

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
      throw Exception('Network error: $e');
    }
  }
}
