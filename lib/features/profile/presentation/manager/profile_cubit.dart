import 'package:book_store/core/services/dio_helper.dart';
import 'package:book_store/core/services/token.dart';
import 'package:book_store/features/home/model/profile_model/profile_model.dart';
import 'package:book_store/features/profile/presentation/manager/profile_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  static ProfileCubit get(context) => BlocProvider.of(context);

  //profile
  ProfileModel? profileModel;
  void getProfile() {
    emit(ProfileLoading());
    DioHelper.getData(
      url: 'profile',
      token: Token.getToken(),
    ).then((value) {
      profileModel = ProfileModel.fromJson(value.data);
      emit(ProfileSuccess());
    }).catchError((onError) {
      emit(ProfileError());
    });
  }

  void logout() {
    emit(ProfileLoading());
    DioHelper.postData(
      url: 'logout',
    ).then((value) {});
  }

  //Update Profile
  updateProfile({
    required String name,
    required XFile? image,
    required String phone,
    required String address,
    required String city,
  }) async {
    emit(ProfileLoading());
    DioHelper.postData(
        url: 'update-profile',
        data: FormData.fromMap({
          'name': name,
          'image':
              image == null ? null : await MultipartFile.fromFile(image.path),
          'address': address,
          'city': city,
          'phone': phone,
        })).then((value) {
      getProfile();
      emit(ProfileSuccess());
    }).catchError((onError) {
      print(onError.toString());
      emit(ProfileError());
    });
  }
}
