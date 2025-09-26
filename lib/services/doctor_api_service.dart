import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nusthackationwebsite/models/doctors_model.dart';

class DoctorApiService {
  static const String baseUrl = 'https://ground-shakers.xyz/api/v1';

  // CREATE DOCTOR
  static Future<DoctorSignupResponse> createDoctor(
    DoctorSignupRequest request,
  ) async {
    final url = Uri.parse('$baseUrl/doctors');

    // Build request body as JSON
    final body = jsonEncode({
      "contact_info": {
        "email": request.contactInfo.email,
        "phone": request.contactInfo.phone,
      },
      "password": request.password,
      "verify_password": request.verifyPassword,
      "first_name": request.firstName,
      "last_name": request.lastName,
      "gender": request.gender.toLowerCase(),
      "birth_details": {
        "day": request.birthDetails.day,
        "month": request.birthDetails.month,
        "year": request.birthDetails.year,
      },
      "id_number": request.idNumber,
      "specialty": request.specialty,
      "years_of_experience": request.yearsOfExperience,
      "medical_facility": request.medicalFacility,
    });

    print('📤 Sending doctor signup request: $body'); // <-- debug

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    print('📥 Response code: ${response.statusCode}');
    print('📥 Response body: ${response.body}');

    if (response.statusCode == 201) {
      final jsonResponse = jsonDecode(response.body);
      return DoctorSignupResponse.fromJson(jsonResponse);
    } else {
      throw Exception('Doctor signup failed: ${response.body}');
    }
  }

  // DOCTOR LOGIN
  static Future<DoctorLoginResponse> doctorLogin(
    DoctorLoginRequest request,
  ) async {
    final url = Uri.parse('https://ground-shakers.xyz/login');

    final body = jsonEncode({
      "username": request.username,
      "password": request.password,
    });

    print('📤 Sending doctor login request: $body');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    print('📥 Response code: ${response.statusCode}');
    print('📥 Response body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return DoctorLoginResponse.fromJson(jsonResponse);
    } else {
      throw Exception('Doctor login failed: ${response.body}');
    }
  }
}
