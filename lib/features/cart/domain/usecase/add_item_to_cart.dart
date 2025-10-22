import 'package:fakestoretask/features/cart/domain/repository/cart_repository.dart';
import 'package:fakestoretask/features/cart/data/model/cart_item_model.dart';

class AddItemToCart {
  final CartRepository repository;

  AddItemToCart(this.repository);

  Future<void> call(int userId, CartItemModel newItem) async {
    try {
      await repository.addItemToCart(userId, newItem);
    } catch (e) {
      // يمكنك إضافة تحسينات إضافية هنا
      print('Error in AddItemToCart UseCase: $e');
      rethrow; // أو throw CustomException('Failed to add item to cart');
    }
  }
}
