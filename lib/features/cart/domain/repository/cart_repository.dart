import 'package:fakestoretask/features/cart/data/model/cart_item_model.dart';
import 'package:fakestoretask/features/cart/data/model/cart_model.dart';

abstract class CartRepository {
  Future<List<CartModel>> getAllCart();
  Future<void> insertCart(CartModel cart);
  Future<void> deleteCart(int cartId);
  Future<void> updateCart(CartModel updatedCart);
  Future<CartModel?> getCartById(int cartId);
  Future<void> addItemToCart(int userId, CartItemModel newItem);
  Future<void> removeItemFromCart(int cartId, int productId);
  Future<void> updateItemQuantity(int cartId, int productId, int newQuantity);
  Future<void> clearCartItems(int cartId);
  Future<void> checkoutCart(int cartId);
}
