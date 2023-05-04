class UserModel {
  int id;
  String email;
  String firstName;
  String lastName;
  String avatar;

  UserModel(
      {required this.avatar,
      required this.email,
      required this.firstName,
      required this.id,
      required this.lastName});

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
        id: map['id'] as int,
        email: map['email'] as String,
        firstName: map['first_name'] as String,
        lastName: map['last_name'] as String,
        avatar: map['avatar'] as String);
  }

  Map<String, dynamic> _toMap() {
    return {
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'avatar': avatar,
    };
  }

  Map<String, dynamic> toJson() => _toMap();

  @override
  String toString() {
    return _toMap().toString();
  }
}
