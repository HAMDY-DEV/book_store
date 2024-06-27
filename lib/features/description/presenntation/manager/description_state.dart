sealed class DescriptionState {}

final class DescriptionInitial extends DescriptionState {}

final class DescriptionLoading extends DescriptionState {}

final class DescriptionSuccess extends DescriptionState {}

final class DescriptionError extends DescriptionState {}

final class GetFavoriteSuccess extends DescriptionState {}

final class GetFavoriteLoading extends DescriptionState {}

final class GetFavoriteError extends DescriptionState {}

final class RemoveFavoriteSuccess extends DescriptionState {}

final class RemoveFavoriteLoading extends DescriptionState {}

final class RemoveFavoriteError extends DescriptionState {}

final class AddToCartLoading extends DescriptionState {}

final class AddToCartSuccess extends DescriptionState {}

final class AddToCartError extends DescriptionState {}

final class DescriptionAddToFavoriteLoading extends DescriptionState {}

final class DescriptionAddToFavoriteSuccess extends DescriptionState {}

final class DescriptionAddToFavoriteError extends DescriptionState {}
