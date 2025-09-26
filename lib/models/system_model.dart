class Symptom {
  final Map<String, dynamic> symptoms;

  Symptom({required this.symptoms});

  factory Symptom.fromJson(Map<String, dynamic> json) {
    return Symptom(symptoms: json);
  }
}

class SymptomResponse {
  final List<String> symptoms;
  final int totalCount;

  SymptomResponse({required this.symptoms, required this.totalCount});

  factory SymptomResponse.fromJson(Map<String, dynamic> json) {
    return SymptomResponse(
      symptoms: List<String>.from(json['symptoms'] ?? []),
      totalCount: json['total_count'] ?? 0,
    );
  }
}
