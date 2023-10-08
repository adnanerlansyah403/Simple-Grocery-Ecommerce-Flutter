
import 'package:flutter/material.dart';
import 'package:simple_grocery_ecommerce/features/home/models/home_product_data.dart';
import 'package:simple_grocery_ecommerce/features/wishlist/bloc/wishlist_bloc.dart';

class WishlistTileWidget extends StatefulWidget {
  const WishlistTileWidget({super.key, required this.productDataModel, required this.wishlistBloc});

  final ProductDataModel productDataModel;
  final WishlistBloc wishlistBloc;
  
  @override
  State<WishlistTileWidget> createState() => _WishlistTileWidgetState();
}

class _WishlistTileWidgetState extends State<WishlistTileWidget> {
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
                  IconButton(
                    onPressed: () {
                      widget.wishlistBloc.add(WishlistRemoveEvent(
                        productDataModel: widget.productDataModel,
                      ));
                      setState(() {}); // Memanggil setState di sini karena kita di dalam Stateful widget
                    },
                    icon: Icon(
                      widget.wishlistBloc.isProductInWishlist(widget.productDataModel)
                        ? Icons.favorite 
                        : Icons.favorite_border_outlined
                    ),
                  ),
                  // IconButton(
                  //   onPressed: () {
                  //     // cartBloc.add(HomeProductCartButtonClickedEvent(
                  //     //   clickedProduct: productDataModel
                  //     // ));
                  //     // widget.wishlistBloc.add(WishlistRemoveEvent(productDataModel: widget.productDataModel));
                  //   }, 
                  //   icon: Icon(
                  //     widget.wishlistBloc.isProductInWishlist(widget.productDataModel)
                  //         ? Icons.shopping_bag
                  //         : Icons.shopping_bag_outlined,
                  //   ),
                  // ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}