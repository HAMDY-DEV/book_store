class AuthState {}

class AuthInitialState extends AuthState {}

//login
class LoginLoadingStat extends AuthState {}

class LoginSuccessStat extends AuthState {
  final String key;
  LoginSuccessStat({required this.key});
}

class LoginErrorStat extends AuthState {
  final String error;
  LoginErrorStat({required this.error});
}

//register
class RegisterLoadingStat extends AuthState {}

class RegisterSuccessStat extends AuthState {}

class RegisterErrorStat extends AuthState {
  final String error;
  RegisterErrorStat({required this.error});
}

//ForgetPassword
class ForgetPasswordLoadingStat extends AuthState {}

class ForgetPasswordSuccessStat extends AuthState {}

class ForgetPasswordErrorStat extends AuthState {
  final String error;
  ForgetPasswordErrorStat({required this.error});
}

// ResetPassword
class ResetPasswordLoadingStat extends AuthState {}

class ResetPasswordSuccessStat extends AuthState {}

class ResetPasswordErrorStat extends AuthState {
  final String error;
  ResetPasswordErrorStat({required this.error});
}
