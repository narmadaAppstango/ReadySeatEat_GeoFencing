//email validator
extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
extension NameValidator on String {
  bool isValidName() {
    return RegExp(r'^[a-zA-Z ]*$').hasMatch(this);
  }
}
extension PhoneNumberValidator on String {
  bool isValidPhoneNo() {
    String pattern = r'^[0-9]*$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(this);
  }
}


extension PasswordValidator on String {
  bool isValidPassword() {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(this);
  }
}
