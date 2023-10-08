import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_grocery_ecommerce/features/cart/bloc/cart_bloc.dart';
import 'package:simple_grocery_ecommerce/features/cart/ui/cart_tile_widget.dart';
import 'package:simple_grocery_ecommerce/features/home/ui/product_tile_widget.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final CartBloc cartBloc = CartBloc();

  @override
  void initState() {
    cartBloc.add(CartInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Items'),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        bloc: cartBloc,
        listenWhen: (previous, current) => current is CartActionState,
        buildWhen: (previous, current) => current is !CartActionState,
        listener: (context, state) {
          if(state is CartRemovedActionState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Item Cart Removed')));
          } 
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case CartLoadingState:
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            case CartSuccessState:
              final successState = state as CartSuccessState;

              return ListView.builder(
                itemCount: successState.cartItems.length,
                itemBuilder: (context, index) {
                return CartTileWidget(
                  cartBloc: cartBloc,
                  productDataModel: successState.cartItems[index]
                );
              });
            case CartErrorState:
              return Scaffold(
                body: Center(child: Text('Error occurred while processing the cart')),
              );
            default:
            return SizedBox();
          }
          // return Container();
        },
      ),
    );
  }
}
