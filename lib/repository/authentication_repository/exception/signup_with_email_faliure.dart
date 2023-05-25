class SignupWithEmailAndPasswordFailure {
  final String message;

  SignupWithEmailAndPasswordFailure(
      [this.message = "An Unknown Error Occurred"]);

  factory SignupWithEmailAndPasswordFailure.code(String code) {
    switch (code) {
      case 'weak-password':
        {
          return SignupWithEmailAndPasswordFailure(
              "please Enter a Stronger password");
        }
      case 'invalid-email':
        {
          return SignupWithEmailAndPasswordFailure(
              "Email is not valid or badly formatted");
        }
      case 'email-already-in-use':
        {
          return SignupWithEmailAndPasswordFailure(
              "An account  already exists for that email");
        }
      default:
        {
          return SignupWithEmailAndPasswordFailure();
        }
    }
  }
}
