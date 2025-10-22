import 'package:fakestoretask/features/cart/domain/repository/cart_repository.dart';
import 'package:fakestoretask/features/cart/data/model/cart_model.dart';

class InsertCart {
  final CartRepository repository;

  InsertCart(this.repository);

  Future<void> call(CartModel cart) {
    return repository.insertCart(cart);
  }
}
