part of 'wishlist_bloc.dart';

@immutable
sealed class WishlistState {}

abstract class WishlistActionState extends WishlistState {

}

final class WishlistInitial extends WishlistState {}

class WishlistLoadingState extends WishlistState {}

class WishlistSuccessState extends WishlistState {
  final List<ProductDataModel> wishlistItems;

  WishlistSuccessState({required this.wishlistItems});
}

class WishlistErrorState extends WishlistState {}

class WishlistRemovedActionState extends WishlistActionState {}
