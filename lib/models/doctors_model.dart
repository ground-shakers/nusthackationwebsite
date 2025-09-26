class DoctorSignupRequest {
  final String firstName;
  final String lastName;
  final String password;
  final String verifyPassword;
  final String gender;
  final DoctorBirthDetails birthDetails;
  final DoctorContactInfo contactInfo;
  final String idNumber;
  final List<String> specialty;
  final int yearsOfExperience;
  final String medicalFacility;

  DoctorSignupRequest({
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.verifyPassword,
    required this.gender,
    required this.birthDetails,
    required this.contactInfo,
    required this.idNumber,
    required this.specialty,
    required this.yearsOfExperience,
    required this.medicalFacility,
  });

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "password": password,
    "verifyPassword": verifyPassword,
    "gender": gender,
    "birthDetails": birthDetails.toJson(),
    "contactInfo": contactInfo.toJson(),
    "idNumber": idNumber,
    "specialty": specialty,
    "yearsOfExperience": yearsOfExperience,
    "medicalFacility": medicalFacility,
  };
}

class DoctorBirthDetails {
  final int day;
  final int month;
  final int year;

  DoctorBirthDetails({
    required this.day,
    required this.month,
    required this.year,
  });

  Map<String, dynamic> toJson() => {"day": day, "month": month, "year": year};
}

class DoctorContactInfo {
  final String email;
  final String phone;

  DoctorContactInfo({required this.email, required this.phone});

  Map<String, dynamic> toJson() => {"email": email, "phone": phone};
}

class DoctorSignupResponse {
  final String message;
  final Map<String, dynamic> doctor;

  DoctorSignupResponse({required this.message, required this.doctor});

  factory DoctorSignupResponse.fromJson(Map<String, dynamic> json) {
    return DoctorSignupResponse(
      message: json['message'] ?? 'Doctor created',
      doctor: json['doctor'] ?? {},
    );
  }
}

class DoctorLoginRequest {
  final String username;
  final String password;

  DoctorLoginRequest({required this.username, required this.password});

  Map<String, dynamic> toJson() => {"username": username, "password": password};
}

class DoctorLoginResponse {
  final String accessToken;
  final DoctorUser user;

  DoctorLoginResponse({required this.accessToken, required this.user});

  factory DoctorLoginResponse.fromJson(Map<String, dynamic> json) {
    return DoctorLoginResponse(
      accessToken: json['accessToken'],
      user: DoctorUser.fromJson(json['user']),
    );
  }
}

class DoctorUser {
  final String id;
  final String email;
  final String role;
  final String? firstName;
  final String? lastName;

  DoctorUser({
    required this.id,
    required this.email,
    required this.role,
    this.firstName,
    this.lastName,
  });

  factory DoctorUser.fromJson(Map<String, dynamic> json) {
    return DoctorUser(
      id: json['id'],
      email: json['email'],
      role: json['role'],
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }
}
