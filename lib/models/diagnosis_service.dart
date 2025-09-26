import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nusthackationwebsite/models/system_model.dart';
import '../models/diagnosis_model.dart';

class DiagnosisService {
  static const String baseUrl = 'https://noble-dev.site';

  // Get list of symptoms
  static Future<SymptomResponse> getSymptoms() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/symptoms/list'),
        headers: {'accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return SymptomResponse.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load symptoms: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching symptoms: $e');
    }
  }

  // Get diagnosis based on symptoms
  static Future<Diagnosis> getDiagnosis({
    required String initialSymptom,
    required int daysExperiencing,
    required List<String> additionalSymptoms,
    required String userId,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/diagnosis'),
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'initial_symptom': initialSymptom,
          'days_experiencing': daysExperiencing,
          'additional_symptoms': additionalSymptoms,
          'user_id': userId,
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return Diagnosis.fromJson(jsonResponse);
      } else {
        throw Exception(
          'Failed to get diagnosis: ${response.statusCode}. Response: ${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Error getting diagnosis: $e');
    }
  }
}
