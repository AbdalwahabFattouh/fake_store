import 'package:flutter/material.dart';
import '../../../data/model/cart_item_model.dart';
import 'cart_item_card.dart';

class CartItemList extends StatelessWidget {
  final List<CartItemModel> cartItemList;
  const CartItemList({super.key, required this.cartItemList});

  @override
  Widget build(BuildContext context) {
    if (cartItemList.isEmpty) {
      return _buildEmptyState();
    }

    return
        Expanded(
          child: ListView.separated(
            itemCount: cartItemList.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final cartItem = cartItemList[index];
              return CartItemCard(cartItem: cartItem);
            },
          ),
        );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_rounded,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No Items in Cart',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add some products to see them here',
            style: TextStyle(
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }


}