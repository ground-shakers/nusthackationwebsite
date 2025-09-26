class Diagnosis {
  final String message;
  final DiagnosisDetails diagnosis;

  Diagnosis({required this.message, required this.diagnosis});

  factory Diagnosis.fromJson(Map<String, dynamic> json) {
    return Diagnosis(
      message: json['message'] ?? '',
      diagnosis: DiagnosisDetails.fromJson(json['diagnosis']),
    );
  }
}

class DiagnosisDetails {
  final String id;
  final String diagnosedUserId;
  final String primaryDiagnosis;
  final List<String> secondaryDiagnoses;
  final String description;
  final List<String> precautions;
  final String severityAssessment;
  final String initialSymptom;
  final List<String> additionalSymptoms;
  final int daysExperiencingSymptoms;
  final String confidenceLevel;

  DiagnosisDetails({
    required this.id,
    required this.diagnosedUserId,
    required this.primaryDiagnosis,
    required this.secondaryDiagnoses,
    required this.description,
    required this.precautions,
    required this.severityAssessment,
    required this.initialSymptom,
    required this.additionalSymptoms,
    required this.daysExperiencingSymptoms,
    required this.confidenceLevel,
  });

  factory DiagnosisDetails.fromJson(Map<String, dynamic> json) {
    return DiagnosisDetails(
      id: json['id'] ?? '',
      diagnosedUserId: json['diagnosedUserId'] ?? '',
      primaryDiagnosis: json['primaryDiagnosis'] ?? '',
      secondaryDiagnoses: List<String>.from(json['secondaryDiagnoses'] ?? []),
      description: json['description'] ?? '',
      precautions: List<String>.from(json['precautions'] ?? []),
      severityAssessment: json['severityAssessment'] ?? '',
      initialSymptom: json['initialSymptom'] ?? '',
      additionalSymptoms: List<String>.from(json['additionalSymptoms'] ?? []),
      daysExperiencingSymptoms: json['daysExperiencingSymptoms'] ?? 0,
      confidenceLevel: json['confidenceLevel'] ?? '',
    );
  }
}
