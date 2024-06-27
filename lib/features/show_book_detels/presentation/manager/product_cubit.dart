import 'package:book_store/core/services/dio_helper.dart';
import 'package:book_store/core/services/token.dart';
import 'package:book_store/features/favorite/presenntation/model/favorite_model.dart';
import 'package:book_store/features/show_book_detels/model/products_model.dart';
import 'package:book_store/features/show_book_detels/presentation/manager/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());
  static ProductCubit get(context) => BlocProvider.of(context);
  FavoriteModel? favoriteModel;
  ProductsModel? productsModel;
  void getProducts() {
    emit(ProductLoading());
    DioHelper.getData(url: 'products').then((value) {
      productsModel = ProductsModel.fromJson(value.data);
      emit(ProductSuccess());
    }).catchError((onError) {
      emit(ProductError());
    });
  }

  void addToFavorite({required int id}) {
    emit(AddFavoriteLoading());
    DioHelper.postData(url: 'add-to-wishlist', data: {'product_id': id})
        .then((value) {
      emit(AddFavoriteSuccess());
      getFavorite();
    }).catchError((onError) {
      emit(AddFavoriteError());
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

  void searchBook({required String name}) {
    emit(ProductLoading());
    DioHelper.getData(url: 'products-search?name=aqaaaq', query: {'name': name})
        .then((value) {
      productsModel = ProductsModel.fromJson(value.data);
      emit(ProductSuccess());
    }).catchError((onError) {
      emit(ProductError());
    });
  }

  List<dynamic> favoriteId = [];
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

  void addToCart({required int product_id}) {
    emit(AddToCartLoading());
    DioHelper.postData(
      url: 'add-to-cart',
      data: {'product_id': product_id},
    ).then((value) {
      emit(AddToCartSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(AddToCartError());
    });
  }
}
