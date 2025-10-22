import 'package:fakestoretask/features/cart/data/model/cart_model.dart';
import 'package:flutter/material.dart';

import '../widgets/animated_carts_list.dart';
import 'cart_card.dart';

class CartsList extends StatelessWidget {
  final List<CartModel> carts;
  const CartsList({super.key, required this.carts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: carts.length,
      itemBuilder: (context, index) {
        final cart = carts[index];
        return AnimatedCartItem(
          item: cart,
          index: index,
        );
      },
    );
  }
}

