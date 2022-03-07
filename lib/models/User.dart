class User {
  final int? userId;
  final String? firstname;
  String? lastname;
  String? email;
  String? phone;
  String? password;

  User(
      {this.userId,
      this.firstname,
      this.lastname,
      this.email,
      this.phone,
      this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        userId: json['userId'] as int,
        firstname: json['firstname'] as String,
        lastname: json['lastname'] as String,
        email: json['email'] as String,
        phone: json['phone'] as String,
        password: json['password'] as String);
  }
}
