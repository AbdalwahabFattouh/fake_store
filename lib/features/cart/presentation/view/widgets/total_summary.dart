import 'package:fakestoretask/features/cart/data/model/cart_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/components/loading_page.dart';
import '../../bloc/cart_bloc.dart';

Widget buildTotalSummary(BuildContext context,CartModel cart) {
  final totalItems = cart.products.fold(0, (sum, item) => sum + item.quantity);
  final totalPrice = cart.products.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Price',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                ),
              ),
              Text(
                '${totalItems} item${totalItems > 1 ? 's' : ''}',
                style: TextStyle(
                  color: Colors.blue[600],
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Text(
            '\$${totalPrice.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue[700],
            ),
          ),
          cart.isActive?
          ElevatedButton(
            onPressed: () {
              _simpleCheckout(context,cart);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[700],
              foregroundColor: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            ),
            child:  Text(
              'Checkout',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ):
          Text("completed",style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blue[700],
          ),)
        ],
      ),
    ),
  );
}
void _simpleCheckout(BuildContext context,CartModel cart) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AdvancedLoadingScreen(
      title: "Checkout in Progress",
      subtitle: "Please wait while we complete your payment",
      type: LoadingType.dots,
      primaryColor: Colors.blue,
      secondaryColor: Colors.purple,
    ),
  );
  Future.delayed(const Duration(seconds: 3), () {
    context.read<CartBloc>().add(CheckoutCartEvent(cart.id));
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Payment completed successfully!'),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.of(context).pop();
  });
}

