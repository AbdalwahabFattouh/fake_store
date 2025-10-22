import 'package:fakestoretask/core/errors/exceptions.dart';
import 'package:fakestoretask/core/services/isar_db_helper.dart';
import 'package:fakestoretask/features/cart/data/model/cart_model.dart';
import 'package:fakestoretask/features/cart/data/model/cart_item_model.dart';
import 'package:isar/isar.dart';

abstract class LocalCartDataSource {
  Future<List<CartModel>> getAllCart();
  Future<void> insertCart(CartModel cart);
  Future<void> deleteCart(int cartId);
  Future<void> updateCart(CartModel updatedCart);
  Future<CartModel?> getCartById(int cartId);
  Future<void> addItemToCart(int cartId, CartItemModel newItem);
  Future<void> removeItemFromCart(int cartId, int productId);
  Future<void> updateItemQuantity(int cartId, int productId, int newQuantity);
  Future<void> clearCartItems(int cartId);
  Future<void> checkoutCart(int cartId);
}

class LocatCartDataSource implements LocalCartDataSource {
  final IsarDBHelper isarDBHelper;
  LocatCartDataSource({required this.isarDBHelper});
  Isar get _isar => isarDBHelper.isar;

  @override
  Future<void> deleteCart(int cartId) async {
    try {
      await _isar.writeTxn(() async {
        await _isar.cartModels.delete(cartId);
      });
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<List<CartModel>> getAllCart() async {
    try {
      return await _isar.cartModels.where().findAll();
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<void> insertCart(CartModel cart) async {
    try {
      await _isar.writeTxn(() async {
        await _isar.cartModels.put(cart);
      });
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<void> updateCart(CartModel updatedCart) async {
    try {
      await _isar.writeTxn(() async {
        await _isar.cartModels.put(updatedCart);
      });
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<CartModel?> getCartById(int cartId) async {
    try {
      return await _isar.cartModels.get(cartId);
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<void> addItemToCart(int userId, CartItemModel newItem) async {
    try {
      await _isar.writeTxn(() async {
        final activeCart = await _isar.cartModels
            .filter()
            .userIdEqualTo(userId)
            .and()
            .isActiveEqualTo(true)
            .findFirst();

        if (activeCart != null) {
          final updatedProducts = List<CartItemModel>.from(activeCart.products);
          updatedProducts.add(newItem);

          final updatedCart = activeCart.copyWith(products: updatedProducts);
          await _isar.cartModels.put(updatedCart);
        } else {
          final newCart = CartModel(
            userId: userId,
            date: DateTime.now(),
            products: [newItem],
            isActive: true,
          );
          await _isar.cartModels.put(newCart);
        }
      });
    } catch (e) {
      print('Error in addItemToCart: $e');
      throw CacheException(message: e.toString());
    }
  }


  // @override
  // Future<void> removeItemFromCart(int cartId, int productId) async {
  //   try {
  //     await _isar.writeTxn(() async {
  //       final cart = await _isar.cartModels.get(cartId);
  //       if (cart != null) {
  //         cart.products.removeWhere((item) => item.productId == productId);
  //         await _isar.cartModels.put(cart);
  //       }
  //     });
  //   } catch (e) {
  //     throw CacheException(message: e.toString());
  //   }
  // }

  // @override
  // Future<void> updateItemQuantity(
  //   int cartId,
  //   int productId,
  //   int newQuantity,
  // ) async {
  //   try {
  //     await _isar.writeTxn(() async {
  //       final cart = await _isar.cartModels.get(cartId);
  //       if (cart != null) {
  //         final itemIndex = cart.products.indexWhere(
  //           (item) => item.productId == productId,
  //         );
  //         if (itemIndex != -1) {
  //           cart.products[itemIndex].quantity = newQuantity;
  //           await _isar.cartModels.put(cart);
  //         }
  //       }
  //     });
  //   } catch (e) {
  //     throw CacheException(message: e.toString());
  //   }
  // }

  // @override
  // Future<void> clearCartItems(int cartId) async {
  //   try {
  //     await _isar.writeTxn(() async {
  //       final cart = await _isar.cartModels.get(cartId);
  //       if (cart != null) {
  //         cart.products.clear();
  //         await _isar.cartModels.put(cart);
  //       }
  //     });
  //   } catch (e) {
  //     throw CacheException(message: e.toString());
  //   }
  // }

  @override
  Future<void> checkoutCart(int cartId) async {
    try {
      await _isar.writeTxn(() async {
        final cart = await _isar.cartModels.get(cartId);
        if (cart != null && cart.isActive) {
          final updated = cart.copyWith(isActive: false);
          await _isar.cartModels.put(updated);
        }
      });
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }


  @override
  Future<void> removeItemFromCart(int cartId, int productId) async {
    try {
      await _isar.writeTxn(() async {
        final cart = await _isar.cartModels.get(cartId);
        if (cart != null) {
          final updatedProducts = List<CartItemModel>.from(cart.products)
            ..removeWhere((item) => item.productId == productId);

          final updatedCart = cart.copyWith(products: updatedProducts);
          await _isar.cartModels.put(updatedCart);
        }
      });
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<void> updateItemQuantity(
      int cartId,
      int productId,
      int newQuantity,
      ) async {
    try {
      await _isar.writeTxn(() async {
        final cart = await _isar.cartModels.get(cartId);
        if (cart != null) {
          final updatedProducts = List<CartItemModel>.from(cart.products);
          final itemIndex = updatedProducts.indexWhere(
                (item) => item.productId == productId,
          );
          if (itemIndex != -1) {
            updatedProducts[itemIndex] = updatedProducts[itemIndex].copyWith(
              quantity: newQuantity,
            );

            final updatedCart = cart.copyWith(products: updatedProducts);
            await _isar.cartModels.put(updatedCart);
          }
        }
      });
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<void> clearCartItems(int cartId) async {
    try {
      await _isar.writeTxn(() async {
        final cart = await _isar.cartModels.get(cartId);
        if (cart != null) {
          final updatedCart = cart.copyWith(products: []);
          await _isar.cartModels.put(updatedCart);
        }
      });
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }
}
