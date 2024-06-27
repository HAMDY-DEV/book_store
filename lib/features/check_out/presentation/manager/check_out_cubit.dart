import 'package:book_store/core/services/dio_helper.dart';
import 'package:book_store/features/check_out/presentation/manager/check_out_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckOutCubit extends Cubit<CheckOutState> {
  CheckOutCubit() : super(CheckOutInitial());

  static CheckOutCubit get(context) => BlocProvider.of(context);

  void checkOut(context, String name, String phone, String address,
      String governorate_id, String email) {
    emit(CheckOutLoading());
    DioHelper.postData(url: 'place-order', data: {
      'name': name,
      'governorate_id': governorate_id,
      'phone': phone,
      'address': address,
      'email': email
    }).then((value) {
      emit(CheckOutSuccess());
    }).catchError((error) {
      emit(CheckOutError(error.toString()));
    });
  }
}
