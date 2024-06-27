import 'package:book_store/core/services/dio_helper.dart';
import 'package:book_store/core/services/token.dart';
import 'package:book_store/features/home/model/bast_sellrey/books_data.dart';
import 'package:book_store/features/home/model/categories_model/categories_model.dart';
import 'package:book_store/features/home/model/profile_model/profile_model.dart';
import 'package:book_store/features/home/model/slidre_model/slidre_model.dart';
import 'package:book_store/features/home/presentation/manager/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:book_store/features/cart/model/cart_model.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);

  CartModel? cartModel;
  //profile
  ProfileModel? profileModel;

  void getProfile() {
    emit(HomeProfileLoading());
    DioHelper.getData(
      url: 'profile',
      token: Token.getToken(),
    ).then((value) {
      profileModel = ProfileModel.fromJson(value.data);
      emit(HomeProfileSuccess(profileModel: ProfileModel.fromJson(value.data)));
    }).catchError((onError) {
      emit(HomeProfileError(error: onError.toString()));
    });
  }

  //Slider
  SlidreModel? slidreModel;
  void getSlider() {
    emit(HomeSliderLoading());
    DioHelper.getData(url: 'sliders').then((value) {
      slidreModel = SlidreModel.fromJson(value.data);
      emit(HomeSliderSuccess(slidreModel: SlidreModel.fromJson(value.data)));
    }).catchError((onError) {
      emit(HomeSliderError(error: onError.toString()));
    });
  }

//Bast Sellrey
  BooksData? bastSellrey;
  void getBastSellrey() {
    emit(HomeBastSellreyLoading());
    DioHelper.getData(url: 'products-bestseller').then((value) {
      bastSellrey = BooksData.fromJson(value.data);
      emit(HomeBastSellreySuccess(bastSellrey: BooksData.fromJson(value.data)));
    }).catchError((onError) {
      emit(HomeBastSellreyError(error: onError.toString()));
    });
  }

//CategoriesModel
  CategoriesModel? categoriesModel;
  void getCategories() {
    emit(HomeCategoriesLoading());
    DioHelper.getData(url: 'categories').then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(HomeCategoriesSuccess(
          categoriesModel: CategoriesModel.fromJson(value.data)));
    }).catchError((onError) {
      emit(HomeCategoriesError(error: onError.toString()));
    });
  }

  //New Arrivals
  BooksData? newArrivals;
  void getNewArrivals() {
    emit(HomeNewArrivalsLoading());
    DioHelper.getData(url: 'products-new-arrivals').then((value) {
      newArrivals = BooksData.fromJson(value.data);
      emit(HomeNewArrivalsSuccess(newArrivals: BooksData.fromJson(value.data)));
    }).catchError((onError) {
      emit(HomeNewArrivalsError(error: onError.toString()));
    });
  }

  void getCart() {
    emit(CartCubitLoading());
    DioHelper.getData(
      url: 'cart',
      token: Token.getToken(),
    ).then((value) {
      cartModel = CartModel.fromJson(value.data);
      emit(CartCubitSuccess());
    }).catchError((error) {
      emit(CartCubitError(error.toString()));
    });
  }
}
