import 'package:fakestoretask/features/cart/domain/repository/cart_repository.dart';
import 'package:fakestoretask/features/cart/data/model/cart_model.dart';

class UpdateCart {
  final CartRepository repository;

  UpdateCart(this.repository);

  Future<void> call(CartModel updatedCart) {
    return repository.updateCart(updatedCart);
  }
}
