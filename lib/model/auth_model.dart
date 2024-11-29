class AuthModel {
  String userName;
  String email;
  String password;
  String? confirmPassword;

  AuthModel(
      {required this.userName,
      required this.email,
      required this.password,
      this.confirmPassword});
}

List<AuthModel> getAuth() {
  return [
    AuthModel(
        email: "duy@gmail.com", password: "1234567", userName: 'Nguyen Duy'),
    AuthModel(
        email: "duy1@gmail.com", password: "123456", userName: 'Nguyen Hung'),
    AuthModel(
        email: "duy12@gmail.com", password: "123456", userName: 'Nguyen Canh'),
  ];
}
