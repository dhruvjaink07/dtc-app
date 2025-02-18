class User {
  final String username;
  final String password;

  User({required this.username, required this.password});

  // Convert User to Map for sending in requests to Database
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}
