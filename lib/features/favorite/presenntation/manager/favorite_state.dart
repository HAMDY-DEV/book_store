sealed class FavoriteState {}

final class FavoriteInitial extends FavoriteState {}

final class FavoriteLoading extends FavoriteState {}

final class FavoriteSuccess extends FavoriteState {}

final class FavoriteError extends FavoriteState {}

final class DeleteFavoriteSuccess extends FavoriteState {}

final class DeleteFavoriteLoading extends FavoriteState {}

final class DeleteFavoriteError extends FavoriteState {}

final class AddToCartLoading extends FavoriteState {}

final class AddToCartSuccess extends FavoriteState {}

final class AddToCartError extends FavoriteState {}
