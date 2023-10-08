import 'package:flutter/material.dart';
import 'package:simple_grocery_ecommerce/features/cart/bloc/cart_bloc.dart';
import 'package:simple_grocery_ecommerce/features/home/bloc/home_bloc.dart';
import 'package:simple_grocery_ecommerce/features/home/models/home_product_data.dart';

class CartTileWidget extends StatefulWidget {

  final ProductDataModel productDataModel;
  final CartBloc cartBloc;
  const CartTileWidget({super.key, required this.productDataModel, required this.cartBloc});

  @override
  State<CartTileWidget> createState() => _CartTileWidgetState();
}

class _CartTileWidgetState extends State<CartTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.maxFinite,
            decoration: BoxDecoration(
              image: DecorationImage(
                // image: NetworkImage('http'),
                image: AssetImage('assets/images/${widget.productDataModel.imageUrl}'),
                fit: BoxFit.cover
              )
            ),
          ),
          const SizedBox(height: 20.0),
          Text(widget.productDataModel.name,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),
          ),
          Text(widget.productDataModel.description),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text( "\$." + widget.productDataModel.prices.toString(), 
                style: TextStyle(fontSize: 18.0),
              ),
              Row(
                children: [
                  // IconButton(onPressed: () {
                  //   // cartBloc.add(HomeProductWishlistButtonClickedEvent(
                  //   //   clickedProduct: productDataModel
                  //   // ));
                  // }, icon: Icon(Icons.favorite_border_outlined)),
                  IconButton(
                    onPressed: () {
                      // cartBloc.add(HomeProductCartButtonClickedEvent(
                      //   clickedProduct: productDataModel
                      // ));
                      widget.cartBloc.add(CartRemoveFromEvent(productDataModel: widget.productDataModel));
                    }, 
                    icon: Icon(
                      widget.cartBloc.isProductInCart(widget.productDataModel)
                          ? Icons.shopping_bag
                          : Icons.shopping_bag_outlined,
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}