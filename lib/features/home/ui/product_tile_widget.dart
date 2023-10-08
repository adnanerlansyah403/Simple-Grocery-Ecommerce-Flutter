import 'package:flutter/material.dart';
import 'package:simple_grocery_ecommerce/features/home/bloc/home_bloc.dart';
import 'package:simple_grocery_ecommerce/features/home/models/home_product_data.dart';

class ProductTileWidget extends StatefulWidget {
  final ProductDataModel productDataModel;
  final HomeBloc homeBloc;

  const ProductTileWidget({
    Key? key,
    required this.productDataModel,
    required this.homeBloc,
  }) : super(key: key);

  @override
  _ProductTileWidgetState createState() => _ProductTileWidgetState();
}

class _ProductTileWidgetState extends State<ProductTileWidget> {
  
  @override
  Widget build(BuildContext context) {
    // Mengakses productDataModel
    final ProductDataModel productDataModel = widget.productDataModel;

    // Mengakses homeBloc
    final HomeBloc homeBloc = widget.homeBloc;
    
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
                image: AssetImage('assets/images/${'${productDataModel.imageUrl}'}'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Text(
            '${productDataModel.name}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text('${productDataModel.description}'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$." + '${productDataModel.prices}'.toString(),
                style: TextStyle(fontSize: 18.0),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      widget.homeBloc.add(HomeProductWishlistButtonClickedEvent(
                        clickedProduct: widget.productDataModel,
                      ));
                      setState(() {}); // Memanggil setState di sini karena kita di dalam Stateful widget
                    },
                    icon: Icon(
                      widget.homeBloc.isProductInWishlist(widget.productDataModel)
                        ? Icons.favorite 
                        : Icons.favorite_border_outlined
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      widget.homeBloc.add(HomeProductCartButtonClickedEvent(
                        clickedProduct: widget.productDataModel,
                      ));
                      setState(() {});
                    },
                    icon: Icon(
                      widget.homeBloc.isProductInCart(widget.productDataModel)
                          ? Icons.shopping_bag
                          : Icons.shopping_bag_outlined,
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
