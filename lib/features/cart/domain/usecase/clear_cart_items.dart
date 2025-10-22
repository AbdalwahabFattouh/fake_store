import 'package:fakestoretask/features/cart/domain/repository/cart_repository.dart';

class ClearCartItems {
  final CartRepository repository;

  ClearCartItems(this.repository);

  Future<void> call(int cartId) {
    return repository.clearCartItems(cartId);
  }
}
