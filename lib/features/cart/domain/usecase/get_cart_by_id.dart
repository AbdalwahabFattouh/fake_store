import 'package:fakestoretask/features/cart/domain/repository/cart_repository.dart';
import 'package:fakestoretask/features/cart/data/model/cart_model.dart';

class GetCartById {
  final CartRepository repository;

  GetCartById(this.repository);

  Future<CartModel?> call(int cartId) {
    return repository.getCartById(cartId);
  }
}
