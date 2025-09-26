class LoginRequest {
  final String username;
  final String password;

  LoginRequest({required this.username, required this.password});

  Map<String, dynamic> toJson() {
    return {'username': username, 'password': password};
  }

  // Add a proper toString method for debugging
  @override
  String toString() {
    return 'LoginRequest{username: $username, password: $password}';
  }
}

class LoginResponse {
  final String message;
  final Token token;
  final String userId;
  final String role;

  LoginResponse({
    required this.message,
    required this.token,
    required this.userId,
    required this.role,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'] ?? '',
      token: Token.fromJson(json['token'] ?? {}),
      userId: json['user_id'] ?? '', // Note: 'user_id' not 'userId'
      role: json['role'] ?? '',
    );
  }
}

class Token {
  final String accessToken;
  final String tokenType;

  Token({required this.accessToken, required this.tokenType});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      accessToken: json['access_token'] ?? '',
      tokenType: json['token_type'] ?? '',
    );
  }
}
