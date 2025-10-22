import 'package:fakestoretask/features/cart/domain/repository/cart_repository.dart';
import 'package:fakestoretask/features/cart/data/model/cart_model.dart';

class GetAllCarts {
  final CartRepository repository;

  GetAllCarts(this.repository);

  Future<List<CartModel>> call() {
    return repository.getAllCart();
  }
}
