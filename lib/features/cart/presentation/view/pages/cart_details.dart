import 'package:fakestoretask/core/components/loading_page.dart';
import 'package:fakestoretask/features/cart/data/model/cart_model.dart';
import 'package:fakestoretask/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:fakestoretask/features/cart/presentation/view/components/cart_item_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/total_summary.dart';

class CartDetails extends StatelessWidget {
  final CartModel cart;
  const CartDetails({super.key, required this.cart});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart Details')),
      body: Column(
        children: [
          CartItemList(cartItemList: cart.products),
          buildTotalSummary(context,cart)
        ],
      ),
    );
  }
}