import 'package:fakestoretask/features/cart/domain/repository/cart_repository.dart';

class DeleteCart {
  final CartRepository repository;

  DeleteCart(this.repository);

  Future<void> call(int cartId) {
    return repository.deleteCart(cartId);
  }
}
