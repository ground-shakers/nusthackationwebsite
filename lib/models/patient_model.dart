class PatientSignupRequest {
  final ContactInfo contactInfo;
  final String password;
  final String verifyPassword;
  final String firstName;
  final String lastName;
  final String gender;
  final BirthDetails birthDetails;

  PatientSignupRequest({
    required this.contactInfo,
    required this.password,
    required this.verifyPassword,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.birthDetails,
  });

  Map<String, dynamic> toJson() {
    return {
      'contact_info': {'email': contactInfo.email, 'phone': contactInfo.phone},
      'password': password,
      'verify_password': verifyPassword,
      'first_name': firstName,
      'last_name': lastName,
      'gender': gender.toLowerCase(),
      'birth_details': {
        'day': birthDetails.day,
        'month': birthDetails.month,
        'year': birthDetails.year,
      },
    };
  }
}

class ContactInfo {
  final String email;
  final String phone;

  ContactInfo({required this.email, required this.phone});

  Map<String, dynamic> toJson() {
    return {'email': email, 'phone': phone};
  }

  factory ContactInfo.fromJson(Map<String, dynamic> json) {
    return ContactInfo(email: json['email'] ?? '', phone: json['phone'] ?? '');
  }
}

class BirthDetails {
  final int day;
  final int month;
  final int year;

  BirthDetails({required this.day, required this.month, required this.year});

  Map<String, dynamic> toJson() {
    return {'day': day, 'month': month, 'year': year};
  }

  factory BirthDetails.fromJson(Map<String, dynamic> json) {
    return BirthDetails(
      day: json['day'] ?? 1,
      month: json['month'] ?? 1,
      year: json['year'] ?? 1900,
    );
  }
}

class PatientSignupResponse {
  final String message;
  final Patient patient;

  PatientSignupResponse({required this.message, required this.patient});

  factory PatientSignupResponse.fromJson(Map<String, dynamic> json) {
    return PatientSignupResponse(
      message: json['message'] ?? '',
      patient: Patient.fromJson(json['patient'] ?? {}),
    );
  }
}

class Patient {
  final String id;
  final String firstName;
  final String lastName;
  final ContactInfo contactInfo;
  final String gender;
  final BirthDetails birthDetails;

  Patient({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.contactInfo,
    required this.gender,
    required this.birthDetails,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      contactInfo: ContactInfo.fromJson(json['contactInfo'] ?? {}),
      gender: json['gender'] ?? '',
      birthDetails: BirthDetails.fromJson(json['birthDetails'] ?? {}),
    );
  }
}
