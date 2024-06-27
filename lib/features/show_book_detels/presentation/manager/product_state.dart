sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductSuccess extends ProductState {}

final class ProductError extends ProductState {}
//

//
final class GetFavoriteSuccess extends ProductState {}

final class GetFavoriteLoading extends ProductState {}

final class GetFavoriteError extends ProductState {}

//
final class AddToCartLoading extends ProductState {}

final class AddToCartSuccess extends ProductState {}

final class AddToCartError extends ProductState {}

//
final class AddFavoriteSuccess extends ProductState {}

final class AddFavoriteLoading extends ProductState {}

final class AddFavoriteError extends ProductState {}

//
final class RemoveFavoriteSuccess extends ProductState {}

final class RemoveFavoriteLoading extends ProductState {}

final class RemoveFavoriteError extends ProductState {}
