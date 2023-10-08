import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_grocery_ecommerce/features/home/models/home_product_data.dart';
import 'package:simple_grocery_ecommerce/features/wishlist/bloc/wishlist_bloc.dart';
import 'package:simple_grocery_ecommerce/features/wishlist/ui/wishlist_tile_widget.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  final WishlistBloc wishlistBloc = WishlistBloc();

  @override
  void initState() {
    wishlistBloc.add(WishlistInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist Items'),
      ),
      body: BlocConsumer<WishlistBloc, WishlistState>(
        bloc: wishlistBloc,
        listenWhen: (previous, current) => current is WishlistActionState,
        buildWhen: (previous, current) => current is !WishlistActionState,
        listener: (context, state) {
          
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case WishlistLoadingState:
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            case WishlistSuccessState:
              final successState = state as WishlistSuccessState;

              return ListView.builder(
                itemCount: successState.wishlistItems.length,
                itemBuilder: (context, index) {
                return WishlistTileWidget(
                  wishlistBloc: wishlistBloc,
                  productDataModel: successState.wishlistItems[index]
                );
              });
            default:
              return SizedBox();
          }
        },
      ),
    );
  }
}