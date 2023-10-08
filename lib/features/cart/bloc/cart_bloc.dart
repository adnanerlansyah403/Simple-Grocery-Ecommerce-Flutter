import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:simple_grocery_ecommerce/data/cart_items.dart';
import 'package:simple_grocery_ecommerce/features/home/models/home_product_data.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {


  CartBloc() : super(CartInitial()) {
    // on<CartEvent>((event, emit) {
    //   // TODO: implement event handler
    // });
    on<CartInitialEvent>(cartInitialEvent);
    on<CartRemoveFromEvent>(cartRemoveFromEvent);
  }

  FutureOr<void> cartInitialEvent(CartInitialEvent event, Emitter<CartState> emit) {
    emit(CartSuccessState(cartItems: cartItems));
  }

  FutureOr<void> cartRemoveFromEvent(CartRemoveFromEvent event, Emitter<CartState> emit) {
    // Get your cartItems
    // Check is your product model there in your cartItems
    // run a function to remove that product model from cartItems
    // emit cartItemsRemovedState
    
    cartItems.remove(event.productDataModel);
    emit(CartSuccessState(cartItems: cartItems));
    emit(CartRemovedActionState());
  }
  
  bool isProductInCart(ProductDataModel product) {
    String productId = product.id;

    return cartItems.any((item) => item.id == productId);
  }
}
