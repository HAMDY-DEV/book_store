import 'package:book_store/core/services/dio_helper.dart';
import 'package:book_store/core/services/token.dart';
import 'package:book_store/features/favorite/presenntation/manager/favorite_state.dart';
import 'package:book_store/features/favorite/presenntation/model/favorite_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());

  static FavoriteCubit get(context) => BlocProvider.of(context);

  FavoriteModel? favoriteModel;

  showFavorite() {
    emit(FavoriteLoading());
    DioHelper.getData(
      url: 'wishlist',
      token: Token.getToken(),
    ).then((value) {
      favoriteModel = FavoriteModel.fromJson(value.data);
      emit(FavoriteSuccess());
    }).catchError((error) {
      emit(FavoriteError());
    });
  }

  deleteFavorite({required int id}) {
    emit(DeleteFavoriteLoading());
    DioHelper.postData(
      url: 'remove-from-wishlist',
      data: {'product_id': id},
    ).then((value) {
      emit(DeleteFavoriteSuccess());
      showFavorite();
    }).catchError((error) {
      emit(DeleteFavoriteError());
    });
  }

  void addToCart({required int product_id}) {
    emit(AddToCartLoading());
    DioHelper.postData(
      url: 'add-to-cart',
      data: {'product_id': product_id},
    ).then((value) {
      emit(AddToCartSuccess());
    }).catchError((error) {
      emit(AddToCartError());
    });
  }
}
