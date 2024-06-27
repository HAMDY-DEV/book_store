import 'package:book_store/core/services/dio_helper.dart';
import 'package:book_store/features/update-password/presentation/manager/update_password_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdatePasswordCubit extends Cubit<UpdatePasswordState> {
  UpdatePasswordCubit() : super(UpdatePasswordInitial());

  static UpdatePasswordCubit get(context) => BlocProvider.of(context);

  void updatePassword(
      {required String current_password,
      required String new_password,
      required String new_password_confirmation}) {
    emit(UpdatePasswordLoading());
    DioHelper.postData(url: 'update-password', data: {
      'current_password': current_password,
      'new_password': new_password,
      'new_password_confirmation': new_password_confirmation,
    }).then((value) {
      emit(UpdatePasswordSuccess());
    }).catchError((onError) {
      emit(UpdatePasswordError());
    });
  }
}
