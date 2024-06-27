import 'package:book_store/core/services/dio_helper.dart';
import 'package:book_store/core/services/token.dart';
import 'package:book_store/features/auth/presentation/manager/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

//Login
  login({required String email, required String password}) {
    emit(LoginLoadingStat());
    DioHelper.postData(url: "login", data: {
      "email": email,
      "password": password,
    }).then((value) {
      emit(LoginSuccessStat(key: value.data['data']['token']));
      Token.siveToken(token: value.data['data']['token']);
    }).catchError((onError) {
      emit(LoginErrorStat(error: onError.toString()));
    });
  }

//forgot_password
  forgotPassword({required String email}) {
    emit(ForgetPasswordLoadingStat());
    DioHelper.postData(url: "forget-password", data: {
      "email": email,
    }).then((value) {
      emit(ForgetPasswordSuccessStat());
    }).catchError((onError) {
      emit(ForgetPasswordErrorStat(error: onError.toString()));
    });
  }

//ResetPassword
  resetPassword({
    required String code,
    required String password,
    required String passwordConfirmation,
  }) {
    emit(ResetPasswordSuccessStat());
    DioHelper.postData(url: "reset-password", data: {
      "verify_code": code,
      "new_password": password,
      "new_password_confirmation": passwordConfirmation,
    }).then((value) {
      emit(ResetPasswordSuccessStat());
    }).catchError((onError) {
      emit(ResetPasswordErrorStat(error: onError.toString()));
    });
  }

//Signup
  signup({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) {
    emit(RegisterLoadingStat());
    DioHelper.postData(url: "register", data: {
      "name": name,
      "email": email,
      "password": password,
      "password_confirmation": passwordConfirmation,
    }).then((value) {
      emit(RegisterSuccessStat());
    }).catchError((onError) {
      emit(RegisterErrorStat(error: onError.toString()));
    });
  }
}
