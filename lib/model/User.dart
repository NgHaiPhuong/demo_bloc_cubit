class UserModel {
  final String name;
  final String avatar;
  final String email;
  final String password;
  final String id;

  UserModel({
    required this.name,
    required this.avatar,
    required this.email,
    required this.password,
    required this.id,
  });

  /// Parse từ JSON -> Object
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? '',
      avatar: json['avatar'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      id: json['id'] ?? '',
    );
  }

  /// Convert từ Object -> JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'avatar': avatar,
      'email': email,
      'password': password,
      'id': id,
    };
  }
}
