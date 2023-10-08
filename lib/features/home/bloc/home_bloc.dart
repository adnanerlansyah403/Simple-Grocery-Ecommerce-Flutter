import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:simple_grocery_ecommerce/data/cart_items.dart';
import 'package:simple_grocery_ecommerce/data/grocery_data.dart';
import 'package:simple_grocery_ecommerce/data/wishlist_items.dart';
import 'package:simple_grocery_ecommerce/features/home/models/home_product_data.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    // on<HomeEvent>((event, emit) {
    //   // TODO: implement event handler
    // });
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeProductWishlistButtonClickedEvent>(homeProductWishlistButtonClickedEvent);
    on<HomeProductCartButtonClickedEvent>(homeProductCartButtonClickedEvent);
    on<HomeWishlistButtonNavigateEvent>(homeWishlistButtonNavigateEvent);
    on<HomeCartButtonNavigateEvent>(homeCartButtonNavigateEvent);
  }

  FutureOr<void> homeInitialEvent(HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(Duration(seconds: 3));
    emit(HomeLoadedSuccessState(products: GroceryData.groceryProducts.map((e) => ProductDataModel(id: e['id'], name: e['name'], description: e['description'], prices: e['prices'], imageUrl: e['imageUrl'])).toList()));
  }

  FutureOr<void> homeProductWishlistButtonClickedEvent(HomeProductWishlistButtonClickedEvent event, Emitter<HomeState> emit) {
    print('Wishlist Product clicked');
    if(!isProductInWishlist(event.clickedProduct)) {
      wishlistItems.add(event.clickedProduct);
      emit(HomeProductItemWishlistedActionState());
      // emit(HomeLoadedSuccessState(products: GroceryData.groceryProducts.map((e) => ProductDataModel(id: e['id'], name: e['name'], description: e['description'], prices: e['prices'], imageUrl: e['imageUrl'])).toList()));
    } else {
      wishlistItems.remove(event.clickedProduct);
      emit(HomeWishlistRemovedActionState());
      // emit(HomeLoadedSuccessState(products: GroceryData.groceryProducts.map((e) => ProductDataModel(id: e['id'], name: e['name'], description: e['description'], prices: e['prices'], imageUrl: e['imageUrl'])).toList()));
    }
  }

  FutureOr<void> homeProductCartButtonClickedEvent(HomeProductCartButtonClickedEvent event, Emitter<HomeState> emit) {
    print('Cart Product clicked');
    if(!isProductInCart(event.clickedProduct)) {
      cartItems.add(event.clickedProduct);
      emit(HomeProductItemCartedActionState());
      // emit(HomeLoadedSuccessState(products: GroceryData.groceryProducts.map((e) => ProductDataModel(id: e['id'], name: e['name'], description: e['description'], prices: e['prices'], imageUrl: e['imageUrl'])).toList()));
    } else {
      cartItems.remove(event.clickedProduct);
      emit(HomeCartRemovedActionState());
      // emit(HomeLoadedSuccessState(products: GroceryData.groceryProducts.map((e) => ProductDataModel(id: e['id'], name: e['name'], description: e['description'], prices: e['prices'], imageUrl: e['imageUrl'])).toList()));
    }
  }

  FutureOr<void> homeWishlistButtonNavigateEvent(HomeWishlistButtonNavigateEvent event, Emitter<HomeState> emit) {
    print('Wishlist Navigate clicked');
    emit(HomeNavigateToWishlistPageActionState());
  }

  FutureOr<void> homeCartButtonNavigateEvent(HomeCartButtonNavigateEvent event, Emitter<HomeState> emit) {
    print('Cart Navigate clicked');
    emit(HomeNavigateToCartPageActionState());
  }

  bool isProductInCart(ProductDataModel product) {
    String productId = product.id;

    return cartItems.any((item) => item.id == productId);
  }
  
  bool isProductInWishlist(ProductDataModel product) {
    String productId = product.id;

    return wishlistItems.any((item) => item.id == productId);
  }

}
