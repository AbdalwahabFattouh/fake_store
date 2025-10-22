import 'package:fakestoretask/features/cart/domain/repository/cart_repository.dart';

class UpdateItemQuantity {
  final CartRepository repository;

  UpdateItemQuantity(this.repository);

  Future<void> call(int cartId, int productId, int newQuantity) {
    return repository.updateItemQuantity(cartId, productId, newQuantity);
  }
}
