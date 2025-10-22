import 'package:equatable/equatable.dart';
import 'package:fakestoretask/core/utils/app_enum.dart';
import 'package:fakestoretask/features/cart/data/model/cart_model.dart';
import 'package:fakestoretask/features/cart/domain/usecase/add_item_to_cart.dart';
import 'package:fakestoretask/features/cart/domain/usecase/checkout_cart.dart';
import 'package:fakestoretask/features/cart/domain/usecase/clear_cart_items.dart';
import 'package:fakestoretask/features/cart/domain/usecase/delete_cart.dart';
import 'package:fakestoretask/features/cart/domain/usecase/get_all_carts.dart';
import 'package:fakestoretask/features/cart/domain/usecase/get_cart_by_id.dart';
import 'package:fakestoretask/features/cart/domain/usecase/insert_cart.dart';
import 'package:fakestoretask/features/cart/domain/usecase/remove_item_from_cart.dart';
import 'package:fakestoretask/features/cart/domain/usecase/update_cart.dart';
import 'package:fakestoretask/features/cart/domain/usecase/update_item_quantity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetAllCarts getAllCarts;
  final InsertCart insertCart;
  final UpdateCart updateCart;
  final DeleteCart deleteCart;
  final GetCartById getCartById;
  final UpdateItemQuantity updateItemQuantity;
  final RemoveItemFromCart removeItemFromCart;
  final AddItemToCart addItemToCart;
  final ClearCartItems clearCartItems;
  final CheckoutCart checkoutCart;

  CartBloc({
    required this.getAllCarts,
    required this.insertCart,
    required this.updateCart,
    required this.deleteCart,
    required this.getCartById,
    required this.updateItemQuantity,
    required this.removeItemFromCart,
    required this.addItemToCart,
    required this.clearCartItems,
    required this.checkoutCart,
  }) : super(CartState()) {
    on<LoadCartsEvent>(_loadCarts);
    on<DeleteCartEvent>(_deleteCart);
    on<RemoveItemFromCartEvent>(_removeItemFromCart);
    on<UpdateItemQuantityEvent>(_updateItemQuantity);
    on<ClearCartItemsEvent>(_clearCartItems);
    on<CheckoutCartEvent>(_checkoutCart);
  }

  Future<void> _loadCarts(LoadCartsEvent event, Emitter<CartState> emit) async {
    print("start load carts");
    emit(state.copyWith(status: BlocStatus.loading));

    try {
      final carts = await getAllCarts();
      emit(
        state.copyWith(
          status: BlocStatus.success,
          carts: carts,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: BlocStatus.failed, errorMessage: e.toString()),
      );
    }
  }

  // Future<void> _addCart(AddCartEvent event, Emitter<CartState> emit) async {
  //   emit(state.copyWith(status: BlocStatus.loading));

  //   try {
  //     await insertCart(event.cart);
  //     emit(state.copyWith(
  //       status: BlocStatus.loaded,
  //       errorMessage: null,
  //     ));
  //     add(const LoadCartsEvent()); // إعادة تحميل القائمة
  //   } catch (e) {
  //     emit(state.copyWith(
  //       status: BlocStatus.error,
  //       errorMessage: e.toString(),
  //     ));
  //   }
  // }

  // Future<void> _updateCart(UpdateCartEvent event, Emitter<CartState> emit) async {
  //   emit(state.copyWith(status: BlocStatus.loading));

  //   try {
  //     await updateCart(event.updatedCart);
  //     emit(state.copyWith(
  //       status: BlocStatus.loaded,
  //       errorMessage: null,
  //     ));
  //   } catch (e) {
  //     emit(state.copyWith(
  //       status: BlocStatus.error,
  //       errorMessage: e.toString(),
  //     ));
  //   }
  // }

  Future<void> _deleteCart(
    DeleteCartEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(state.copyWith(status: BlocStatus.loading));

    try {
      await deleteCart(event.cartId);
      emit(state.copyWith(status: BlocStatus.success, errorMessage: null));
      add(LoadCartsEvent());
    } catch (e) {
      emit(
        state.copyWith(status: BlocStatus.failed, errorMessage: e.toString()),
      );
    }
  }

  Future<void> _removeItemFromCart(
    RemoveItemFromCartEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(state.copyWith(status: BlocStatus.loading));

    try {
      await removeItemFromCart(event.cartId, event.productId);
      emit(state.copyWith(status: BlocStatus.success, errorMessage: null));
      add(LoadCartsEvent());
    } catch (e) {
      emit(
        state.copyWith(status: BlocStatus.failed, errorMessage: e.toString()),
      );
    }
  }

  Future<void> _updateItemQuantity(
    UpdateItemQuantityEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(state.copyWith(status: BlocStatus.loading));

    try {
      await updateItemQuantity(
        event.cartId,
        event.productId,
        event.newQuantity,
      );
      emit(state.copyWith(status: BlocStatus.success, errorMessage: null));
      add(LoadCartsEvent());
    } catch (e) {
      emit(
        state.copyWith(status: BlocStatus.failed, errorMessage: e.toString()),
      );
    }
  }

  Future<void> _clearCartItems(
    ClearCartItemsEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(state.copyWith(status: BlocStatus.loading));

    try {
      await clearCartItems(event.cartId);
      emit(state.copyWith(status: BlocStatus.success, errorMessage: null));
      add(LoadCartsEvent());
    } catch (e) {
      emit(
        state.copyWith(status: BlocStatus.failed, errorMessage: e.toString()),
      );
    }
  }

  Future<void> _checkoutCart(
    CheckoutCartEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(state.copyWith(status: BlocStatus.loading));

    try {
      await checkoutCart(event.cartId);
      emit(state.copyWith(status: BlocStatus.success, errorMessage: null));
      add(LoadCartsEvent());
    } catch (e) {
      emit(
        state.copyWith(status: BlocStatus.failed, errorMessage: e.toString()),
      );
    }
  }
}
