import 'package:fakestoretask/features/cart/data/datasource/local_cart_data_source.dart';
import 'package:fakestoretask/features/cart/data/model/cart_model.dart';
import 'package:fakestoretask/features/cart/data/model/cart_item_model.dart';
import 'package:fakestoretask/features/cart/domain/repository/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final LocalCartDataSource localCartDataSource;
  CartRepositoryImpl({required this.localCartDataSource});

  @override
  Future<void> deleteCart(int cartId) {
    return localCartDataSource.deleteCart(cartId);
  }

  @override
  Future<List<CartModel>> getAllCart() {
    return localCartDataSource.getAllCart();
  }

  @override
  Future<void> insertCart(CartModel cart) {
    return localCartDataSource.insertCart(cart);
  }

  @override
  Future<void> updateCart(CartModel updatedCart) {
    return localCartDataSource.updateCart(updatedCart);
  }

  @override
  Future<CartModel?> getCartById(int cartId) async {
    return localCartDataSource.getCartById(cartId);
  }

  @override
  Future<void> addItemToCart(int cartId, CartItemModel newItem) async {
    return localCartDataSource.addItemToCart(cartId, newItem);
  }

  @override
  Future<void> removeItemFromCart(int cartId, int productId) async {
    return localCartDataSource.removeItemFromCart(cartId, productId);
  }

  @override
  Future<void> updateItemQuantity(
    int cartId,
    int productId,
    int newQuantity,
  ) async {
    return localCartDataSource.updateItemQuantity(
      cartId,
      productId,
      newQuantity,
    );
  }

  @override
  Future<void> clearCartItems(int cartId) async {
    return localCartDataSource.clearCartItems(cartId);
  }

  @override
  Future<void> checkoutCart(int cartId) async {
    return localCartDataSource.checkoutCart(cartId);
  }
}
