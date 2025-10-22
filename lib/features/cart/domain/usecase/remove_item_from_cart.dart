import 'package:fakestoretask/features/cart/domain/repository/cart_repository.dart';

class RemoveItemFromCart {
  final CartRepository repository;

  RemoveItemFromCart(this.repository);

  Future<void> call(int cartId, int productId) {
    return repository.removeItemFromCart(cartId, productId);
  }
}
