import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:simple_grocery_ecommerce/data/wishlist_items.dart';
import 'package:simple_grocery_ecommerce/features/home/models/home_product_data.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    // on<WishlistEvent>((event, emit) {
    //   // TODO: implement event handler
    // });
    on<WishlistInitialEvent>(wishlistInitialEvent);
    on<WishlistRemoveEvent>(wishlistRemoveEvent);
  }

  FutureOr<void> wishlistInitialEvent(WishlistInitialEvent event, Emitter<WishlistState> emit) {
    emit(WishlistSuccessState(wishlistItems: wishlistItems));
  }

  FutureOr<void> wishlistRemoveEvent(WishlistRemoveEvent event, Emitter<WishlistState> emit) {
    
    wishlistItems.remove(event.productDataModel);
    emit(WishlistSuccessState(wishlistItems: wishlistItems));
    emit(WishlistRemovedActionState());
  }

  bool isProductInWishlist(ProductDataModel product) {
    String productId = product.id;

    return wishlistItems.any((item) => item.id == productId);
  }
}
