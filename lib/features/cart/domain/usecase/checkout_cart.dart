import 'package:fakestoretask/features/cart/domain/repository/cart_repository.dart';

class CheckoutCart {
  final CartRepository repository;
  CheckoutCart(this.repository);

  Future<void> call(int cartId) {
    return repository.checkoutCart(cartId);
  }
}
