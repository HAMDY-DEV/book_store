import 'package:book_store/core/services/dio_helper.dart';
import 'package:book_store/core/services/token.dart';
import 'package:book_store/core/widget/show_loading_and_error.dart';
import 'package:book_store/features/description/presenntation/manager/description_state.dart';
import 'package:book_store/features/description/presenntation/model/description_model.dart';
import 'package:book_store/features/favorite/presenntation/model/favorite_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DescriptionCubit extends Cubit<DescriptionState> {
  DescriptionCubit() : super(DescriptionInitial());

  static DescriptionCubit get(context) => BlocProvider.of(context);

  FavoriteModel? favoriteModel;
  List<dynamic> favoriteId = [];
  DescriptionModel? descriptionModel;

  void products({required int id}) {
    emit(DescriptionLoading());
    DioHelper.getData(
      url: 'products/$id',
    ).then((value) {
      descriptionModel = DescriptionModel.fromJson(value.data);
      emit(DescriptionSuccess());
    }).catchError((error) {
      emit(DescriptionError());
    });
  }

  void addToFavorite({required int id}) {
    emit(DescriptionAddToFavoriteLoading());
    DioHelper.postData(url: 'add-to-wishlist', data: {'product_id': id})
        .then((value) {
      getFavorite();
      emit(DescriptionAddToFavoriteSuccess());
    }).catchError((onError) {
      emit(DescriptionAddToFavoriteError());
    });
  }

  void removeInFavorite({required int id}) {
    emit(RemoveFavoriteLoading());
    DioHelper.postData(url: 'remove-from-wishlist', data: {'product_id': id})
        .then((value) {
      favoriteId.clear;
      getFavorite();
      emit(RemoveFavoriteSuccess());
    }).catchError((onError) {
      emit(RemoveFavoriteError());
    });
  }

  getFavorite() {
    emit(GetFavoriteLoading());
    DioHelper.getData(
      url: 'wishlist',
      token: Token.getToken(),
    ).then((value) {
      favoriteId = value.data['data']['data'].map((e) => e['id']).toList();
      emit(GetFavoriteSuccess());
    }).catchError((error) {
      emit(GetFavoriteError());
    });
  }

  void addToCart({required int product_id, required context}) {
    emit(AddToCartLoading());
    DioHelper.postData(
      url: 'add-to-cart',
      data: {'product_id': product_id},
    ).then((value) {
      showSnackBar(context: context, textError: 'Added To Cart');
      emit(AddToCartSuccess());
    }).catchError((error) {
      emit(AddToCartError());
    });
  }
}
