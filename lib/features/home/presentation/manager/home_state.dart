import 'package:book_store/features/home/model/bast_sellrey/books_data.dart';
import 'package:book_store/features/home/model/categories_model/categories_model.dart';
import 'package:book_store/features/home/model/profile_model/profile_model.dart';
import 'package:book_store/features/home/model/slidre_model/slidre_model.dart';

sealed class HomeState {}

class HomeInitial extends HomeState {}

class HomeSliderLoading extends HomeState {}

class HomeSliderSuccess extends HomeState {
  SlidreModel slidreModel;
  HomeSliderSuccess({required this.slidreModel});
}

class HomeSliderError extends HomeState {
  String error;
  HomeSliderError({required this.error});
}

//Bast Sellrey
class HomeBastSellreyLoading extends HomeState {}

class HomeBastSellreySuccess extends HomeState {
  BooksData bastSellrey;
  HomeBastSellreySuccess({required this.bastSellrey});
}

class HomeBastSellreyError extends HomeState {
  String error;
  HomeBastSellreyError({required this.error});
}

//Categories

class HomeCategoriesLoading extends HomeState {}

class HomeCategoriesSuccess extends HomeState {
  CategoriesModel categoriesModel;
  HomeCategoriesSuccess({required this.categoriesModel});
}

class HomeCategoriesError extends HomeState {
  String error;
  HomeCategoriesError({required this.error});
}

//New Arrivals

class HomeNewArrivalsLoading extends HomeState {}

class HomeNewArrivalsSuccess extends HomeState {
  BooksData newArrivals;
  HomeNewArrivalsSuccess({required this.newArrivals});
}

class HomeNewArrivalsError extends HomeState {
  String error;
  HomeNewArrivalsError({required this.error});
}

//profile

class HomeProfileLoading extends HomeState {}

class HomeProfileSuccess extends HomeState {
  ProfileModel profileModel;
  HomeProfileSuccess({required this.profileModel});
}

class HomeProfileError extends HomeState {
  String error;
  HomeProfileError({required this.error});
}

final class CartCubitLoading extends HomeState {}

final class CartCubitSuccess extends HomeState {}

final class CartCubitError extends HomeState {
  final String error;
  CartCubitError(this.error);
}
