class LoginDto {
  final String email;
  final String password;

  LoginDto({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }

  factory LoginDto.fromJson(Map<String, dynamic> json) {
    return LoginDto(
      email: json['email'] ?? '',
      password: json['password'] ?? '',
    );
  }
}

class SignUpDto {
  final String name;
  final String email;
  final String password;
  final String role;
  final String companyName;
  final String city;

  SignUpDto({
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    required this.companyName,
    required this.city,
  });

  factory SignUpDto.fromJson(Map<String, dynamic> json) {
    final company = json['companyDetails'] ?? {};
    final address = company['companyAddress'] ?? {};
    return SignUpDto(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      role: json['role'] ?? '',
      companyName: company['companyName'] ?? '',
      city: address['city'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'role': role,
      'companyDetails': {
        'companyName': companyName,
        'companyAddress': {'city': city},
      },
    };
  }
}
